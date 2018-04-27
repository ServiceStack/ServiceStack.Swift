// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServiceStackClient",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .Package(url: "https://github.com/mxcl/PromiseKit.git", versions: Version(6, 0, 0)..<Version(6, 2, 5))
    ],
    exclude: ["Tests"]
)
