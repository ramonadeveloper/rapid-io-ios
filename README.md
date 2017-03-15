#Rapid iOS SDK

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Alamofire.svg)](https://img.shields.io/cocoapods/v/Alamofire.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Rapid iOS SDK is an SDK written in Swift for accessing Rapid.io realtime database.

- [Features](#features)
- [Requirements](#requirements)
- [Migration Guides](#migration-guides)
- [Communication](#communication)
- [Installation](#installation)
- [Credits](#credits)
- [License](#license)

## Features

- [-] Connect to Rapid.io database
- [-] Subscribe to changes
- [-] Mutate database
- [-] Authenticate
- [-] Complete Documentation

## Requirements

- iOS 8.0+
- Xcode 8.1+
- Swift 3.0+

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build Rapid 1.0.0+.

To integrate Rapid iOS SDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Rapid'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Rapid iOS SDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Alamofire/Alamofire" ~> 4.4
```

Run `carthage update` to build the framework and drag the built `Rapid.framework` into your Xcode project.

### Manually

If you prefer not to use either of the dependency managers, you can download the latest [framework](Framework/Rapid.framework) and integrate Rapid iOS SDK into your project manually.

---

## Credits

Rapid iOS SDK is owned and maintained by the [Rapid.io](http://www.rapid.io).

### Security Disclosure

If you believe you have identified a security vulnerability with Rapid iOS SDK, you should report it as soon as possible via email to security@rapid.io. Please do not post it to a public issue tracker.

## License

Rapid iOS SDK is released under the MIT license. See LICENSE for details.
