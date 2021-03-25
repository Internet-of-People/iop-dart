enum Network {
  LocalTestNet,
  TestNet,
  DevNet,
  MainNet,
}

class NetworkConfig {
  final String host;
  final int port;
  final Network network;

  NetworkConfig._(this.host, this.port, this.network);

  static NetworkConfig fromUrl(String host, int port, Network network) {
    return NetworkConfig._(host, port, network);
  }

  static NetworkConfig fromNetwork(Network network, {port = 4705}) {
    return NetworkConfig._(network.seedServerUrlBase, port, network);
  }
}

extension NetworkProperties on Network {
  String get networkNativeName => const {
        Network.LocalTestNet: 'HYD testnet',
        Network.TestNet: 'HYD testnet',
        Network.DevNet: 'HYD devnet',
        Network.MainNet: 'HYD mainnet',
      }[this]!;

  String get seedServerUrlBase => const {
        Network.LocalTestNet: 'http://127.0.0.1',
        Network.TestNet: 'https://test.explorer.hydraledger.io',
        Network.DevNet: 'https://dev.explorer.hydraledger.io',
        Network.MainNet: 'https://explorer.hydraledger.io',
      }[this]!;
}
