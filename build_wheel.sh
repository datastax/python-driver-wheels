#!/bin/bash

. multibuild/common_utils.sh
. multibuild/travis_steps.sh

echo "Platform is $PLAT"

before_install
clean_code $REPO_DIR $BUILD_COMMIT
build_wheel $REPO_DIR $PLAT
install_run $PLAT

cd wheelhouse
curl -u $ARTIFACTORY_USER:$ARTIFACTORY_PASS -T "{$(echo cassandra_driver* | tr ' ' ',')}" "https://datastax.jfrog.io/datastax/python-drivers/python-driver-wheels/builds/{$TRAVIS_BUILD_NUMBER}/"
