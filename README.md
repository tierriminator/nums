# nums

## Description

The purpose of this project is to provide a numerical library for the Swift programming language.
Focus lies on cross-platform compatibility, performance and ease of use.
The project is currently in early development and everyone is welcome to contribute.
Updates to the project design will currently be published in this document, until there is a more suitable system set up for planning the development.

The following features are currently implemented:
- Complex Numbers

The following features are planned in the nearest future
- Matrices

## Unit Tests

Every implemented feature should provide an extensive test suite.
Tests are located, as usually for a Swift PM project, in the `Tests` directory, which replicates the directory structure of the `Sources` directory.
Every source file should have a corresponding test file, testing the features from the respective source file.
Every test case should be compatible for Linux, as described in the [XCTest project repository](https://github.com/apple/swift-corelibs-xctest).

## Usage

The project is configured for [Swift Package Manager](https://swift.org/package-manager/).
Simply clone the repository and execute `swift build` to build the project.
For running unit tests, execute `swift test`.