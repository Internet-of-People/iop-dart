# IOP SDK

This package contains Dart tools needed to interact with IOP SSI (project Morpheus) and DNS (project Coeus) and create awesome decentralized apps. For more info please visit the [IOP Developer Portal](https://developer.iop.technology).

This SDK is a work in progress and its convenience improves over time.

## Table of Contents <!-- omit in toc -->

- [Prerequisites](#prerequisites)
- [Install](#install)
- [Architecture](#architecture)
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

- Dart 2.12.0+
- Linux / MacOS

## Install

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  iop_sdk: ^5.0.0
```

## Architecture

#### Dynamic Libraries and OS Support

Most of the codebase is implemented in Rust and this Dart library uses [Dart FFI](https://dart.dev/guides/libraries/c-interop) to communicate with a shared dynamic library generated from Rust using its C bindings. The native library binary is loaded dynamically on demand.

Currently, we support only Linux, MacOS and Android, but we are also preparing iOS and Windows support as well.

#### Memory Management

As Dart finalizers are [not ready yet](https://github.com/dart-lang/sdk/issues/35770), only manual memory management is available. Consequently, some classes of this package are extended from `Disposable` and you have to manually dispose their instances when not using those objects anymore. This is common for Android developers, but might not be that evident for others.

## Modules

### Crypto

Cryptographic primitives mostly for creating a [vault](https://developer.iop.technology/glossary?id=vault) and generating a large set of purpose-specified private keys for Hydra addresses, SSI DIDs, etc. It also contains tools to sign and validate signatures based on DIDs with a managable keyset and easily handle JWT tokens.

### Entities

#### Authority

All interfaces and types that are needed to communicate with an [Authority](https://developer.iop.technology/glossary?id=authority) endpoint. Authorities have a public and a private API as described below.

See more about the Authorities API [here](https://developer.iop.technology/api/authority_api)

##### Public API

The Public API is available without authentication, mostly used by clients of the given authority's services.

##### Private API

The Private API is available with authentication only and used mostly by internal entities (e.g. clerks) of an authority.

#### Inspector

All interfaces and types needed to communicate with an [Inspector](https://developer.iop.technology/glossary?id=inspector) endpoint. See more about the Inspector API [here](https://developer.iop.technology/api/inspector_api).

#### Verifier

All interfaces and types needed to communicate with a [Verifier](https://developer.iop.technology/glossary?id=verifier) endpoint. See more about the Verifier API [here](https://developer.iop.technology/api/verifier_api).

### Layer1

SSI's API consists of two main parts. Layer-1 and layer-2. Layer-1 performs write operations that change the blockchain's state, while layer-2 executes queries (i.e. read operations without touching the state).

This module contains all Dart classes and utils needed to interact with the [SSI Layer-1 API](https://developer.iop.technology/api/layer1_api). 

For more detailed examples please visit our [tutorial center](https://developer.iop.technology/sdk?id=tutorial-center).

### Layer2

This module contains all Dart classes and utils needed to interact with the [Layer-2 API](https://developer.iop.technology/api/layer2_api). 

For more detailed examples please visit our [tutorial center](https://developer.iop.technology/sdk?id=tutorial-center).

### SSI

Contains all interfaces needed to use the SSI (project Morpheus) protocol including all entities defined in the specification.

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
