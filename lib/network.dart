enum Network {
  LocalTestNet,
  TestNet,
  DevNet,
  MainNet,
}

extension NetworkProperties on Network {
  String get RustApiId => const {
        Network.LocalTestNet: 'HYD testnet',
        Network.TestNet: 'HYD testnet',
        Network.DevNet: 'HYD devnet',
        Network.MainNet: 'HYD mainnet',
      }[this];

  String get seedServerUrlBase => const {
        Network.LocalTestNet: 'http://127.0.0.1',
        Network.TestNet: 'https://test.hydra.iop.global',
        Network.DevNet: 'https://dev.hydra.iop.global',
        Network.MainNet: 'https://hydra.iop.global',
      }[this];

  String get layer1ApiUrl => seedServerUrlBase + ':4705/api/v2';
}
