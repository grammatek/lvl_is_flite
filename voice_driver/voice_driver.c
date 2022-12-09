//
// Copyright (c) 2022 Grammatek ehf. All rights reserved.
// Licensed under Apache Version 2.0
//

#include <stdio.h>
#include <string.h>

#include "flite.h"
#include "cst_voice.h"

#include "voice_driver.h"

// forward declarations

extern cst_val *flite_set_voice_list(const char *voxdir);
extern void *flite_set_lang_list(void);

// local functions

static ssize_t voice_drv_phones_to_pcm(const char *phonemes,
                                       cst_voice *voice,
                                       char* buf, size_t bufSize, float* duration);

/**
 * Private voice driver structure
 */
struct __attribute__((aligned(8))) voice_drv_priv_t {
    uint64_t reserved[4];
    cst_voice* v;
};

// voice driver implementation

void* voice_driver_init()
{
    struct voice_drv_priv_t* drv_priv = NULL;
    posix_memalign((void **) &drv_priv, sizeof(uint64_t), sizeof(struct voice_drv_priv_t));
    if (drv_priv == NULL)
    {
        fprintf(stderr, "malloc() returned NULL!\n");
        return NULL;
    }

    flite_init();
    flite_set_lang_list(); /* defined at compilation time */

    // this is a global set via flite_set_voice_list() and declared in flite.h
    if (flite_voice_list == NULL)
    {
        flite_set_voice_list(NULL);
    }

    // this call needs to have flite_voice_list set
    cst_voice *v = flite_voice_select(NULL);
    if (NULL == v)
    {
        fprintf(stderr, "No voices available ?!");
        free(drv_priv);
        return(NULL);
    }
    drv_priv->v = v;
    return (void*) drv_priv;
}

ssize_t voice_driver_speak(void* handle, const char* phonemes, float* duration, char* buf, size_t buf_size)
{
    if ((phonemes == NULL) || (duration == NULL) || (buf == NULL))
    {
        fprintf(stderr, "One of the given parameters is NULL\n");
        return -1;
    }
    struct voice_drv_priv_t* drv_priv = (struct voice_drv_priv_t*) handle;

    // need to be set to 0, otherwise Flite crashes !
    memset(buf, 0, buf_size);

    // call into the Flite voice, to do the phoneme 2 PCM conversion.
    return voice_drv_phones_to_pcm(phonemes, drv_priv->v, buf,
                                   buf_size, duration);
}

struct voice_drv_info_t voice_driver_info(void* handle)
{
    struct voice_drv_priv_t* drv_priv = (struct voice_drv_priv_t*) handle;
    struct voice_drv_info_t info;

    // voice features
    const char* const DESCRIPTION = "This is a voice generated by cadia lvl is. Early beta";
    strncpy(info.description, DESCRIPTION, sizeof(info.description));

    info.sample_rate = (uint32_t) flite_get_param_int(drv_priv->v->features, "sample_rate", 0);
    strncpy(info.name, flite_get_param_string(drv_priv->v->features, "name", "N/A"), sizeof(info.name));

    // we know the following values, but it would be better to get them programmatically
    // (any Flite "features" available) ?
    info.bit_depth = VOICE_DRV_BIT_DEPTH_16;
    info.channels = 1;

    return info;
}

void voice_driver_cleanup(void* handle)
{
    struct voice_drv_priv_t* drv_priv = (struct voice_drv_priv_t*) handle;
    delete_val(flite_voice_list);
    flite_voice_list = 0;
    free(drv_priv);
}

/**
 * Converts given phonemes to raw PCM audio and writes the data into given
 * buffer. If the generated audio exceeds the buffer size, only that amount
 * is written to the buffer that it can hold.
 *
 * @param phonemes          phonemes that should be transformed into PCM
 * @param voice             the voice to be used
 * @param buf               buffer to write results into
 * @param bufSize           size of the provided buffer
 * @param duration[output]  the duration of the PCM inside the buffer
 *
 * @return  number of bytes written into the provided buffer, -1 otherwise
 */
ssize_t voice_drv_phones_to_pcm(const char *phonemes, cst_voice *voice,
                                char* buf, size_t bufSize, float* duration)
{
    ssize_t nBytes = -1;
    cst_utterance *utterances;
    utterances = flite_synth_phones(phonemes, voice);
    if (utterances)
    {
        cst_wave *waves = utt_wave(utterances);
        size_t nSamples = cst_wave_num_samples(waves);
        if (sizeof(short) * nSamples > bufSize)
        {
            // adapt nSamples if our buffer is shorter than generated
            // audio
            nSamples = bufSize / sizeof(short);
        }
        nBytes = sizeof(short) * nSamples;
        *duration = (float) nSamples / (float) waves->sample_rate;
        memcpy(buf, cst_wave_samples(waves), nBytes);
        delete_utterance(utterances);
    }

    return nBytes;
}