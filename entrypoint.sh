#!/bin/sh
set -e

# Navigate to the working directory
cd "${INPUT_WORKINGDIR:-.}"

# Find the template file
if ([ $INPUT_TEMPLATEFILE != *.json ] && [ ! -f "$INPUT_TEMPLATEFILE" ]); then
    echo "${INPUT_TEMPLATEFILE} does not exit in the working directory (${INPUT_WORKINGDIR})"
    exit 1
fi

# Find the var file file and it should be a json file
if ([ -f "$INPUT_VARFILE" ] && [ $INPUT_VARFILE != *.json ]); then
    echo "${INPUT_VARFILE} must be a valid json file in the working directory (${INPUT_WORKINGDIR})"
    exit 1
fi

# #check if variable file is supply
if [ -f "{$INPUT_VARFILE}" ]
then
    variableCommand="-var-file=${INPUT_VARFILE}"
else
    variableCommand=""
fi

set +e
# Run Packer validate
echo "Running packer validate"
PACKER_VALIDATE_OUTPUT=$(sh -c "packer validate ${variableCommand} ${INPUT_TEMPLATEFILE}" 2>&1)
echo "$PACKER_VALIDATE_OUTPUT"
set -e

set +e
# Run Packer build
echo "Running packer build"
BUILD_OUTPUT=$(sh -c "packer build ${variableCommand} ${INPUT_TEMPLATEFILE}" 2>&1)
BUILD_SUCCESS=$?
echo "$BUILD_OUTPUT"
set -e

exit $BUILD_SUCCESS