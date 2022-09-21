//
// Copyright (c) 2022 Grammatek ehf. All rights reserved.
// Licensed under Apache Version 2.0
//

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <sys/fcntl.h>
#include <unistd.h>

#include "flite.h"
#include "cst_voice.h"

#include "voice_driver.h"

// forward declarations

extern cst_val *flite_set_voice_list(const char *voxdir);
extern void *flite_set_lang_list(void);

// voice driver implementation

void* voice_driver_init()
{
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
        return(NULL);
    }

    return (void*) v;
}

ssize_t voice_driver_speak(void* handle, const char* phonemes, float* duration, char* buf, size_t buf_size)
{
    if ((phonemes == NULL) || (duration == NULL) || (buf == NULL))
    {
        return -1;
    }
    // need to be set to 0, otherwise Flite crashes !
    memset(buf, 0, buf_size);
    // use a temporary file for riff audio output, read it into the given buffer
    const char* temp_file = tmpnam(NULL);
    if (temp_file == NULL)
    {
        return -1;
    }

    // call into the Flite voice, to do the phoneme 2 wav conversion. This will write to the given file
    *duration = flite_phones_to_speech(phonemes, (cst_voice *) handle, temp_file);

    // we read the file into provided memory
    int fd = open(temp_file, O_RDONLY);
    if (-1 == fd)
    {
        return -1;
    }
    // we can not read more than available memory; n_read contains less than buf_size in case the file has less
    // bytes
    size_t n_read = read(fd, buf, buf_size);
    close(fd);
    return (ssize_t) n_read;
}

struct voice_drv_info_t voice_driver_info(void* handle)
{
    struct voice_drv_info_t info;

    // voice features
    const char* const DESCRIPTION = "This is a voice generated by cadia lvl is. Early beta";
    strncpy(info.description, DESCRIPTION, sizeof(info.description));

    info.sample_rate = (uint32_t) flite_get_param_int(((cst_voice *) handle)->features, "sample_rate", 0);
    strncpy(info.name, flite_get_param_string(((cst_voice *) handle)->features, "name", "N/A"), sizeof(info.name));

    // we know the following values, but it would be better to get them programmatically
    // (any Flite "features" available) ?
    info.bit_depth = VOICE_DRV_BIT_DEPTH_16;
    info.channels = 1;

    return info;
}

void voice_driver_cleanup()
{
    delete_val(flite_voice_list);
    flite_voice_list = 0;
}