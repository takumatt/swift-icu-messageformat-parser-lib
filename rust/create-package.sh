#!/bin/bash

cd "$(dirname "$0")"

swift-bridge-cli create-package \
  --bridges-dir ./generated \
  --out-dir ../ \
  --ios target/aarch64-apple-ios/debug/libswift_icu_messageformat_parser.a \
  --simulator target/universal-ios/debug/libswift_icu_messageformat_parser.a \
  --macos target/universal-macos/debug/libswift_icu_messageformat_parser.a \
  --name ICUMessageFormatParser \
