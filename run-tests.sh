#!/usr/bin/env dash
# Build the test container and run the test cases. Finally remove the container.
# If everything is fine then the status code is zero as expected.
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

docker build -t tmcw/rtb-wrapper-test -f test/Dockerfile .
docker run -t --rm -v "$(pwd)/test:/tests:ro" tmcw/rtb-wrapper-test