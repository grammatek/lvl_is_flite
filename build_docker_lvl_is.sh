#! /bin/bash

set -euo pipefail
docker build -f docker/Dockerfile.festvox -t harbour.grammatek.com/sim/festvox-build-tools:latest .
docker build -f docker/Dockerfile.lvl_is --progress=plain -t harbour.grammatek.com/sim/lvl_is:latest .

# Copy generated android voices out of container into current directory
docker create --name dummy harbour.grammatek.com/sim/lvl_is:latest
docker cp dummy:/usr/local/src/lvl_is_flite/lvl_is_f/voice_deliverables .
docker rm -f dummy