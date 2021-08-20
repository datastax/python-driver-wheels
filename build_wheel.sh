#!/bin/bash

. multibuild/common_utils.sh
. multibuild/travis_steps.sh

echo "Platform is $PLAT"

before_install
clean_code $REPO_DIR $BUILD_COMMIT
build_wheel $REPO_DIR $PLAT
install_run $PLAT

