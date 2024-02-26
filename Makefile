CI ?= false
BUILD_TYPE ?= Debug
GRADLE_ARGS ?= --build-cache

ifeq ($(CI), true)
  GRADLE_ARGS += --console 'plain'
  BUILD_TYPE = Release
endif

all: clean lint test assemble

assemble:
	./gradlew assemble${BUILD_TYPE} ${GRADLE_ARGS}
.PHONY: assemble

bundle:
	./gradlew bundle${BUILD_TYPE} ${GRADLE_ARGS}
.PHONY: bundle

clean:
	./gradlew clean ${GRADLE_ARGS}
.PHONY: clean

lint: lint-android
.PHONY: lint

lint-android:
	./gradlew lint${BUILD_TYPE} ${GRADLE_ARGS}
.PHONY: lint-android

test: test-android
.PHONY: test

test-android:
	./gradlew test${BUILD_TYPE}UnitTest ${GRADLE_ARGS}
.PHONY: test-android
