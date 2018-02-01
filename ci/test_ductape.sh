#!/bin/sh

export DUKTAKE_SUPPORT=ON
touch ~/.sparkUseDuktape

rm -rf $TRAVIS_BUILD_DIR/logs
echo pwd
sh $TRAVIS_BUILD_DIR/ci/duktape_install.sh

sh $TRAVIS_BUILD_DIR/ci/script.sh

