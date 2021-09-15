#!/bin/bash

PYTHON_MAJOR_MINOR=`python -c 'import sys; print(str(sys.version_info[0])+"."+str(sys.version_info[1]))'`
if [[ $PYTHON_MAJOR_MINOR == "2.7" || $PYTHON_MAJOR_MINOR == "3.5" ]]; then
    echo "Python version $PYTHON_MAJOR_MINOR needs a custom pip install"
    PIP_URL = "https://bootstrap.pypa.io/pip/$PYTHON_MAJOR_MINOR/get-pip.py"
    echo "Trying URL $PIP_URL"
    curl $PIP_URL | sudo python -
fi

. multibuild/common_utils.sh
. multibuild/travis_steps.sh

echo "Platform is $PLAT"

before_install
clean_code $REPO_DIR $BUILD_COMMIT
build_wheel $REPO_DIR $PLAT
install_run $PLAT

cd wheelhouse
curl -u $ARTIFACTORY_USER:$ARTIFACTORY_PASS -T "{$(echo cassandra_driver* | tr ' ' ',')}" "https://datastax.jfrog.io/datastax/python-drivers/python-driver-wheels/builds/{$TRAVIS_BUILD_NUMBER}/"
