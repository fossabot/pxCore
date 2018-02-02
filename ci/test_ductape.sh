#!/bin/sh

export DUKTAPE_SUPPORT=ON
touch ~/.sparkUseDuktape
rm -rf $TRAVIS_BUILD_DIR/logs
pwd

function validateExe()
{
if [ "$1" -ne 0 ]
printf  "\n\n************** "$2" failed *******************\n\n"
#exit 1;
fi
}

sh $TRAVIS_BUILD_DIR/ci/duktape_install.sh
validateExe "$?" "duktape_install.sh"

sh $TRAVIS_BUILD_DIR/ci/script.sh
validateExe "$?" "script.sh"

if [0]

if [ "$TRAVIS_EVENT_TYPE" = "push" ] || [ "$TRAVIS_EVENT_TYPE" = "pull_request"]; then 
  codecov --build "$TRAVIS_OS_NAME-$TRAVIS_COMMIT-$TRAVIS_BUILD_NUMBER" -X gcov -f $TRAVIS_BUILD_DIR/tracefile ; 
fi

if [ "$TRAVIS_EVENT_TYPE" = "push" ] || [ "$TRAVIS_EVENT_TYPE" = "pull_request"]; then 
  genhtml -o $TRAVIS_BUILD_DIR/logs/codecoverage $TRAVIS_BUILD_DIR/tracefile;
fi

fi

sh $TRAVIS_BUILD_DIR/ci/after_script.sh
validateExe "$?" "after_script.sh"


