import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/network.dart';
import 'package:test/test.dart';

import '../util.dart';

final network = Network.TestNet;
final unlockPassword = '+*7=_X8<3yH:v2@s';
final hydraAccount = 0;
final random = Random();

void main() {
  group('BeforeProof registration', () {
    test('works', () async {
      final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
      MorpheusPlugin.init(vault, unlockPassword);
      HydraPlugin.init(vault, unlockPassword, network, hydraAccount);

      final morpheusPlugin = MorpheusPlugin.get(vault);
      final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
      final hydraPrivate = hydraPlugin.private(unlockPassword);

      final did = morpheusPlugin.public.personas.did(0);
      final keyId = did.defaultKeyId();
      final contractStr = 'A long legal document ${random.nextInt(1000000000)}';
      final contractBytes =
          Uint8List.fromList(utf8.encode(contractStr)).buffer.asByteData();
      final morpheusPrivate = morpheusPlugin.private(unlockPassword);
      final signedContract = morpheusPrivate.signDidOperations(
        keyId,
        contractBytes,
      );

      final signedContractJson = <String, dynamic>{
        'content':
            utf8.decode(signedContract.content.content!.buffer.asUint8List()),
        'publicKey': signedContract.signature.publicKey.value,
        'signature': signedContract.signature.bytes.value,
      };

      final beforeProof = digestJson(signedContractJson);
      final asset = MorpheusAssetBuilder.create()
          .addRegisterBeforeProof(beforeProof)
          .build();

      final layer1Api = Layer1Api.createApi(NetworkConfig.fromNetwork(network));

      final senderAddress = hydraPlugin.public.key(0).address;
      final txId = await layer1Api.sendMorpheusTx(
        senderAddress,
        asset,
        hydraPrivate,
      );
      await waitForMorpheusLayer2Confirmation(txId, true);

      final expectedContentId = digestJson(signedContractJson);

      final history =
          await morpheusLayer2.getBeforeProofHistory(expectedContentId);
      expect(history, isNotNull);

      hydraPrivate.dispose();
      morpheusPrivate.dispose();
      keyId.dispose();
      did.dispose();
      morpheusPlugin.dispose();
      hydraPlugin.dispose();
      vault.dispose();
    });
  });
}
