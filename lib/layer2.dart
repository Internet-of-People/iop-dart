export './src/layer2/did_document.dart';
export './src/layer2/io.dart';

import './src/layer2/coeus_api.dart';
import './src/layer2/morpheus_api.dart';
import './network.dart';

class Layer2Api {
  static MorpheusApi createMorpheusApi(NetworkConfig networkConfig) =>
      MorpheusApi(networkConfig);

  static CoeusApi createCoeusApi(NetworkConfig networkConfig) =>
      CoeusApi(networkConfig);
}
