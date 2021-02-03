#!/usr/bin/env bash
set -e

if [[ -z "${PIP_INSTALL}" ]]; then
    PIP_INSTALL='install'
fi

# Directory of *this* script
this_dir="$( cd "$( dirname "$0" )" && pwd )"
src_dir="$(realpath "${this_dir}/..")"

# -----------------------------------------------------------------------------

#download="${src_dir}/download"
download="${src_dir}download" 
# -----------------------------------------------------------------------------

: "${PYTHON=python3}"


# Install Python dependencies
echo "Installing Python dependencies"
pip3 ${PIP_INSTALL} --upgrade pip
pip3 ${PIP_INSTALL} --upgrade wheel setuptools

# Install local Rhasspy dependencies if available
grep '^rhasspy-' "${src_dir}/requirements.txt" | \
    xargs pip3 ${PIP_INSTALL} -f "${download}"

pip3 ${PIP_INSTALL} -r requirements.txt

# -----------------------------------------------------------------------------

echo "OK"
