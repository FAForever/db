#!/bin/bash
set -e

echo '# Generating db diagram with Schemaspy'

# Must be generated into the folder 'public' as we're going to use it as GitLab pages
# See https://gitlab.com/help/user/project/pages/index.md#how-it-works
SCHEMASPY_OUTPUT_DIR=$PWD/public

cat "$PWD/ci/schemaspy.properties"

mkdir -p "${SCHEMASPY_OUTPUT_DIR}"
chmod a+rw "${SCHEMASPY_OUTPUT_DIR}"

docker run --network="host" \
            -v "$PWD/ci/schemaspy.properties:/schemaspy.properties" \
            -v "${SCHEMASPY_OUTPUT_DIR}:/output" \
            schemaspy/schemaspy:latest \
           || { echo "Could not generate schema"; exit 1; }
