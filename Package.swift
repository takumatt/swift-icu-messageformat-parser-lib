// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "ICUMessageFormatParser",
	products: [
		.library(
			name: "ICUMessageFormatParser",
			targets: ["ICUMessageFormatParser"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "ICUMessageFormatParser",
			dependencies: ["RustXcframework"])
	]
)
	