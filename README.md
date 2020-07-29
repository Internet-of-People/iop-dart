# IOP SDK

This package contains all Dart tool you need to interact with IOP DAC and Fort APIs and create awesome apps. For more info please visit the [IOP Developer Portal](https://developer.iop.global/).

This SDK will improve over time to be able to use it more easily.

## Table of Contents <!-- omit in toc -->

- [Prerequisites](#prerequisites)
- [Install](#install)
- [Modules](#modules)
  - [Crypto](#crypto)
  - [Entities](#entities)
    - [Authority](#authority)
    - [Inspector](#inspector)
    - [Verifier](#verifier)
  - [Layer1](#layer1)
  - [Layer2](#layer2)
  - [SSI](#ssi)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- Dart 2.8.4+
- Linux / MacOS

## Install

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  iop_sdk: ^3.1.0
```

## Modules

### Crypto

IOP implemented its crypto codebase in Rust and uses [Dart FFI](https://dart.dev/guides/libraries/c-interop) to communicate with it from Dart.

#### Memory Management

As Dart finalizers are [not ready yet](https://github.com/dart-lang/sdk/issues/35770), only manual memory management is available. Consequently, some classes of this package are extended from `Disposable` and you have to manually dispose their instances when not using those objects anymore. This is common for Android developers, but might not be that evident for others.

##### Dynamic Libraries and OS Support

As we use our Rust code through its C-based FFI, we have to use dynamic libraries included as binaries loaded dynamically on demand.

Currently we support only Linux and MacOS, but we are preparing Android, iOS and Windows support as well.

### Entities

#### Authority

All interfaces and types that are needed to communicate with an Authority endpoint. Authorities have two types of APIs, a public and a private as described below.

See more about the Authorities API [here](https://developer.iop.global/#/api/authority_api)

##### Public API

The Public API is available for anyone without authentication. Mostly used to provide an endpoint for users to use the given authority's services.

##### Private API

The Private API is available with authentication only and used mostly by internal entities of an authority.

#### Inspector

All interfaces and types needed to communicate with an Inspector endpoint. See more about the Inspector API [here](https://developer.iop.global/#/api/inspector_api).

#### Verifier

All interfaces and types needed to communicate with a Verifier endpoint. See more about the Verifier API [here](https://developer.iop.global/#/api/verifier_api).

### Layer1

DAC's API consists of two main parts. Layer-1 and layer-2. On layer-1 you perform write operations that change the blockchain's state, while on layer-2 you execute read operations without touching the state.

This module contains all Dart classes and utils needed to interact with the [DAC Layer-1 API](https://developer.iop.global/#/api/layer1_api). 

For more detailed examples please visit our [tutorial center](https://developer.iop.global/#/sdk/dac?id=tutorial-center).

### Layer2

This module contains all Dart classes and utils needed to interact with the [DAC Layer-2 API](https://developer.iop.global/#/api/layer2_api). 

For more detailed examples please visit our [tutorial center](https://developer.iop.global/#/sdk/dac?id=tutorial-center).

### SSI

Contains all interfaces needed to use the DAC (Morpheus) protocol including all entities defined in the specification.

## Development

```bash
# Build json converters
$ pub run build_runner build --delete-conflicting-outputs
```

```bash
# Run tests
$ pub run test --concurrency=1 # note: the test must run on a single thread becaus of nonce generation
```

```bash
# Run Analyzer
$ dartanalyzer .
```

## Contributing

Feel free to open issues and pull requests in this repository. By contributing you agree to transfer all intellectual property from your changes to the Decentralized Society Foundation, Panama, copyright owner of this code. To avoid losing precious time you spend on coding, you could open an issue first and discuss what you are up to before forking and sending us a PR.

Small note: If editing the README, please conform to the standard-readme specification.

## License

[LGPL-3.0 or later](https://spdx.org/licenses/LGPL-3.0-or-later) © 2020 Decentralized Society Foundation, PA
