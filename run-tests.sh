#!/usr/bin/env sh
# Build the test container and run the test cases. Finally remove the container.
# If everything is fine then the status code is zero as expected.
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

docker build -t tmcw/rtb-wrapper-test -f test/Dockerfile .

# run every test in a clean container
for test in test/bats/*.bats; do
    echo
    # flat file mapping - no folder structure
    filename=$(basename "$test")
    docker run -t --rm -v "$(pwd)/${test}:/tests/${filename}:ro" tmcw/rtb-wrapper-test
done