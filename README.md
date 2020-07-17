# IoP SDK

This package contains all Dart tool you need to interact with IoP DAC and Fort APIs and create awesome apps. For more info please visit the [IoP Developer Portal](https://developer.iop.global/).

This SDK will improve over time to be able to use it more easily.

## Table of Contents <!-- omit in toc -->

- [Prerequisites](#prerequisites)
- [Install](#install)
- [Modules](#modules)
  - [Authority](#authority)
    - [Public API](#public-api)
    - [Private API](#private-api)
  - [Crypto](#crypto)
  - [Inspector](#inspector)
  - [Layer1](#layer1)
  - [Layer2](#layer2)
  - [Sdk](#sdk)
  - [Verifier](#verifier)
- [Development](#development)

## Prerequisites

- Dart 2.8.4+
- Linux

## Install

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  iop_sdk: ^3.1.0
```

## Modules

### Authority

All interfaces and types that needed to be able to communicate with an Authority endpoint. Authorities have two type of APIs.
A public and a private, described below.

#### Public API

The Public API which is available for anyone without authentication.

```dart
import 'package:morpheus_sdk/entities/authority/public_api.dart';
import 'package:morpheus_sdk/entities/io.dart';

final config = ApiConfig('https://authority', 443);
final api = AuthorityPublicApi(config);
```

#### Private API

### Crypto

All interfaces and types you need to use the [Crypto Module](#Crypto-Module) to create vault, keys & DID wrappers, etc. See more info about this package under the [Crypto Module](#Crypto-Module) section.

### Inspector

All interfaces and types that needed to be able to communicate with an Inspector endpoint. See more about the Inspector's API [here](https://github.com/Internet-of-People/morpheus-ts/tree/master/packages/inspector-service).

### Layer1

This module contains all Dart classes and utils that you need to interact with the [DAC Layer-1 API](https://developer.iop.global/#/glossary?id=layer-1). Below we provide you example how can you interact with Layer-1 APIs.

For more detailed examples please visit our [tutorial center](https://developer.iop.global/#/sdk/dac?id=tutorial-center).

### Layer2

All interfaces you need to interact with the Layer-2 API.

### Sdk

All interfaces that describes the DAC (Morpheus) protocol including all participants defined in the specification.

### Verifier

All interfaces and types that needed to be able to communicate with a Verifier endpoint. Currently our verifier is implemented in the inspector package, hence to see more about the Verifier's API, please visit [this page](https://github.com/Internet-of-People/morpheus-ts/tree/master/packages/inspector-service).

## Development

```bash
# Build json converters
$ pub run build_runner build --delete-conflicting-outputs
```
