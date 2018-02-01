#!/bin/sh

export DUKTAKE_SUPPORT=ON
touch ~/.sparkUseDuktape
echo "**************Enabling ducktape ******************* $?"
rm -rf $TRAVIS_BUILD_DIR/logs
pwd
sh $TRAVIS_BUILD_DIR/ci/duktape_install.sh

sh $TRAVIS_BUILD_DIR/ci/script.sh

sh $TRAVIS_BUILD_DIR/ci/after_script.sh

cat $TRAVIS_BUILD_DIR/temp/logs/test_logs
printf "\n\n\n\n"
cat $TRAVIS_BUILD_DIR/temp/logs/exec_logs
