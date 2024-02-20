#!/bin/bash

swift-bridge-cli create-package \
  --bridges-dir ./generated \
  --out-dir output \
  --ios target/aarch64-apple-ios/debug/libswift_icu_messageformat_parser.a \
  --simulator target/universal-ios/debug/libswift_icu_messageformat_parser.a \
  --macos target/universal-macos/debug/libswift_icu_messageformat_parser.a \
  --name icu-message-format-parser \