.PHONY: build-rust create-package

target: build-rust create-package

build-rust:
	@echo "Building Rust"
	cd ./rust && ./build-rust.sh

create-package:
	@echo "Creating package"
	cd ./rust && ./create-package.sh