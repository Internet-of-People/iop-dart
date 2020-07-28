import 'dart:convert';
import 'dart:typed_data';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';

void main(List<String> arguments) async {
  final network = Network.TestNet;
  final unlockPassword = '+*7=_X8<3yH:v2@s';
  // TODO why TS example works with passphrase if it needs a vault anyway?
  //final hydraAccount = 0;
  final hydraGasPassphrase =
      'scout try doll stuff cake welcome random taste load town clerk ostrich';

  // YOU HAVE TO SAVE IT TO A SAFE PLACE!
  final phrase = Bip39('en').generatePhrase();
  final word25 = '8qjaX^UNAafDL@!#'; // this is for plausible deniability
  final vault = Vault.create(phrase, word25, unlockPassword);

  //HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);
  MorpheusPlugin.rewind(vault, unlockPassword);

  //final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
  final morpheusPlugin = MorpheusPlugin.get(vault);

  // you are going to use the first key
  final pubKey = morpheusPlugin.public.personas.key(0);
  print('Using Key: ${pubKey.toString()}');

  final keyId = pubKey.keyId(); // acquire the keyId
  final contractStr = 'A long legal document, e.g. a contract with all details';
  final contractBytes =
      Uint8List.fromList(utf8.encode(contractStr)).buffer.asByteData();
  // acquire the plugin's private interface that provides you the sign interface
  final morpheusPrivate = morpheusPlugin.private(unlockPassword);
  // YOU NEED TO SAVE IT TO A SAFE PLACE!
  // TODO should use something like signRawBytes() instead of signDidOperations() here
  final signedContract =
      morpheusPrivate.signDidOperations(keyId, contractBytes);

  // you must use this Buffer wrapper at the moment, we will improve in later releases
  final content =
      utf8.decode(signedContract.content.content.buffer.asUint8List());
  final signedContractJson = <String, dynamic>{
    'content': content,
    'publicKey': signedContract.signature.publicKey.value,
    'signature': signedContract.signature.bytes.value,
  };
  print('Signed contract: ${stringifyJson(signedContractJson)}');

  final beforeProof = digestJson(signedContractJson);
  print('Before proof: ${beforeProof.value}');

  // create our operation attempts data structure
  final opAttempts =
      OperationAttemptsBuilder().registerBeforeProof(beforeProof).getAttempts();

  //  final senderAddress = hydraPlugin.public.key(0).address;
  //  final hydraPrivate = hydraPlugin.private(unlockPassword);

  // initialize our layer-1 API and send the transaction
  final layer1Api = Layer1Api(network);
  final txId = await layer1Api.sendMorpheusTxWithPassphrase(
      opAttempts, hydraGasPassphrase);

  print('Transaction ID: $txId');

  await Future.delayed(Duration(seconds: 12));
  // layer-1 transaction must be confirmed
  final txStatus = await layer1Api.getTxnStatus(txId);
  print('Tx confirmed in block: ${txStatus.value.blockId}');

  // now you can query from the layer-2 API as well!
  final layer2Api = Layer2Api(network);
  final dacTxStatus = await layer2Api.getTxnStatus(txId);
  print('DAC Tx status: ${dacTxStatus.value}');

  // TODO validate that's everything's properly disposed:
  //      keyId, morpheusPrivate, signedContract, beforeProof, etc
  morpheusPlugin.dispose();
  vault.dispose();
}
