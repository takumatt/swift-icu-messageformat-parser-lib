// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "ICUMessageParser",
	products: [
		.library(
			name: "ICUMessageParser",
			targets: ["ICUMessageParser"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "ICUMessageParser",
			dependencies: ["RustXcframework"])
	]
)
	