#!/usr/bin/env sh

# exit immediately if any command fails (works also on sh to my best knowledge)
set -e

PROJECT_FILE="pubspec.yaml"

# Expects the following usual flutter dependency in pubspec.yaml configuration
#  flutter:
#    sdk: flutter
FLUTTER_DEPENDENCY="(?s)flutter:.*?sdk:\s*flutter"

echo "Checking Flutter project, i.e. $PROJECT_FILE with flutter dependency configured"
if ! grep -zqP "$FLUTTER_DEPENDENCY" $PROJECT_FILE
then
  echo ERROR: Current directory does not contain a Flutter project
  exit 1
fi

ANDROID_MAIN_PATH="./android/app/src/main"

echo Checking application sources for Android
if [ ! -e $ANDROID_MAIN_PATH ]; then
  echo ERROR: Flutter project does not contain Android target
  exit 2
fi

ANDROID_JNILIBS_PATH="$ANDROID_MAIN_PATH/jniLibs"

echo Creating platform-specific native library directories
mkdir -p "$ANDROID_JNILIBS_PATH/arm64-v8a"
mkdir -p "$ANDROID_JNILIBS_PATH/x86"
mkdir -p "$ANDROID_JNILIBS_PATH/x86_64"

echo Downloading latest shared library binaries
curl --proto '=https' --tlsv1.2 -#L -o "$ANDROID_JNILIBS_PATH/arm64-v8a/Android-ARMv8.zip" \
  https://github.com/Internet-of-People/morpheus-rust/releases/latest/download/Android-ARMv8.zip
curl --proto '=https' --tlsv1.2 -#L -o "$ANDROID_JNILIBS_PATH/x86_64/Android-x86_64.zip" \
  https://github.com/Internet-of-People/morpheus-rust/releases/latest/download/Android-x86_64.zip
curl --proto '=https' --tlsv1.2 -#L -o "$ANDROID_JNILIBS_PATH/x86/Android-x86.zip" \
  https://github.com/Internet-of-People/morpheus-rust/releases/latest/download/Android-x86.zip

echo Extracting downloaded archives
unzip $ANDROID_JNILIBS_PATH/arm64-v8a/Android-ARMv8.zip -d $ANDROID_JNILIBS_PATH/arm64-v8a
unzip $ANDROID_JNILIBS_PATH/x86_64/Android-x86_64.zip -d $ANDROID_JNILIBS_PATH/x86_64
unzip $ANDROID_JNILIBS_PATH/x86/Android-x86.zip -d $ANDROID_JNILIBS_PATH/x86

echo Removing extracted archives
rm $ANDROID_JNILIBS_PATH/arm64-v8a/Android-ARMv8.zip
rm $ANDROID_JNILIBS_PATH/x86_64/Android-x86_64.zip
rm $ANDROID_JNILIBS_PATH/x86/Android-x86.zip

# TODO consider autoextracting sdk version from our pubspec.yaml
IOP_DEPENDENCY_NAME="iop_sdk"
IOP_DEPENDENCY_LATEST_VERSION="4.0.0"
echo Checking IoP package dependency
if ! grep -zqP "$IOP_DEPENDENCY_NAME:" $PROJECT_FILE
then
  OLD_PROJECT_FILE="$PROJECT_FILE.old"
  echo Adding IoP package dependency to project, saving old file in $OLD_PROJECT_FILE
  mv $PROJECT_FILE $OLD_PROJECT_FILE
  sed "s/^\(dependencies:\)/\1\n  $IOP_DEPENDENCY_NAME: \"$IOP_DEPENDENCY_LATEST_VERSION\"/" $OLD_PROJECT_FILE > $PROJECT_FILE
else
  echo Project file already has "$IOP_DEPENDENCY_NAME" as a dependency
fi
