CI ?= false
BUILD_TYPE ?= Debug
GRADLE_ARGS ?= --build-cache

ifeq ($(CI), true)
  GRADLE_ARGS += --console 'plain'
  BUILD_TYPE = Release
endif

# iOS
DEVICE ?= iPhone 15
PROJECT_ARGS ?= -scheme ios -sdk iphonesimulator -destination 'platform=iOS Simulator,name=${DEVICE}'

# TODO: Remove this and enable code signing on CI
SIGNING_CONFIG ?= CODE_SIGNING_ALLOWED=NO

all: all-android all-ios all-shared
.PHONY: all

all-android: clean-gradle test-android assemble
.PHONY: all-android

all-ios: clean-ios analyze-ios test-ios build-ios
.PHONY: all-ios

all-shared: test-shared
.PHONY: all-shared

clean: clean-gradle clean-ios
.PHONY: clean

lint: lint-android
.PHONY: lint

test: test-android test-shared test-ios
.PHONY: test

# Android
assemble:
	./gradlew assemble${BUILD_TYPE} ${GRADLE_ARGS}
.PHONY: assemble

bundle:
	./gradlew bundle${BUILD_TYPE} ${GRADLE_ARGS}
.PHONY: bundle

clean-gradle:
	./gradlew clean ${GRADLE_ARGS}
.PHONY: clean

lint-android:
	./gradlew lint${BUILD_TYPE} ${GRADLE_ARGS}
.PHONY: lint-android

test-android:
	./gradlew test${BUILD_TYPE}UnitTest ${GRADLE_ARGS}
.PHONY: test-android

# iOS
analyze-ios:
	(cd ios && xcodebuild analyze ${PROJECT_ARGS} ${SIGNING_CONFIG})
.PHONY: analyze

build-ios:
	(cd ios && xcodebuild build ${PROJECT_ARGS} ${SIGNING_CONFIG})
.PHONY: build

clean-ios:
	(cd ios && xcodebuild clean)
.PHONY: clean

test-ios:
	(cd ios && xcodebuild test ${PROJECT_ARGS} ${SIGNING_CONFIG})
.PHONY: test-ios

# Shared
test-shared: test-shared-android test-shared-ios
.PHONY: test-shared

test-shared-android:
	./gradlew :shared:test${BUILD_TYPE}UnitTest ${GRADLE_ARGS}
.PHONY: test-shared-android

test-shared-ios:
	./gradlew :shared:cleanIosX64Test :shared:iosX64Test ${GRADLE_ARGS}
.PHONY: test-shared-ios
