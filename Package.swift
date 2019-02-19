// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServiceStack",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ServiceStack",
            targets: ["ServiceStack"]),
        ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .Package(url: "https://github.com/mxcl/PromiseKit.git", versions: Version(6, 8, 0)..<Version(6, 8, 3))
    ],
    exclude: ["Tests"]
)
