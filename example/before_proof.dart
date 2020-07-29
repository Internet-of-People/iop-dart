import 'dart:convert';
import 'dart:typed_data';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';


final network = Network.TestNet;
final hydraGasPassphrase = 'scout try doll stuff cake welcome random taste load town clerk ostrich';
final hydraGasPublicKey = "03d4bda72219264ff106e21044b047b6c6b2c0dde8f49b42c848e086b97920adbf";
final unlockPassword = '+*7=_X8<3yH:v2@s';


void main(List<String> arguments) async {
  // YOU HAVE TO SAVE IT TO A SAFE PLACE!
  final phrase = Bip39('en').generatePhrase();
  final vault = Vault.create(
    phrase,
    '8qjaX^UNAafDL@!#', // this is for plausible deniability
    unlockPassword,
  );

  MorpheusPlugin.rewind(vault, unlockPassword);
  final morpheusPlugin = MorpheusPlugin.get(vault);

  final did = morpheusPlugin.public.personas.did(0);  // you are going to use the first DID
  print('Using DID: ${did.toString()}');

  final keyId = did.defaultKeyId(); // acquire the default key
  final contractStr = 'A long legal document, e.g. a contract with all details';
  final contractBytes = Uint8List.fromList(utf8.encode(contractStr)).buffer.asByteData();
  final morpheusPrivate = morpheusPlugin.private(unlockPassword); // acquire the plugin's private interface that provides you the sign interface

  final signedContract = morpheusPrivate.signDidOperations(keyId, contractBytes); // YOU NEED TO SAVE IT TO A SAFE PLACE!

  final signedContractJson = <String, dynamic>{
    'content': utf8.decode(signedContract.content.content.buffer.asUint8List()), // you must use this Buffer wrapper at the moment, we will improve in later releases,
    'publicKey': signedContract.signature.publicKey.value,
    'signature': signedContract.signature.bytes.value,
  };
  print('Signed contract: ${stringifyJson(signedContractJson)}');

  final beforeProof = digestJson(signedContractJson);
  print('Before proof: ${beforeProof.value}');

  final opAttempts = OperationAttemptsBuilder()  // let's create our operation attempts data structure
      .registerBeforeProof(beforeProof)
      .getAttempts();

  // let's initialize our layer-1 API
  final layer1Api = Layer1Api(network);

  // let's query and then increment the current nonce of the owner of the tx fee
  int nonce = await layer1Api.getWalletNonce(hydraGasPublicKey);
  nonce = nonce + 1;

  // and now you are ready to send it
  final txId = await layer1Api.sendMorpheusTxWithPassphrase(opAttempts, hydraGasPassphrase, nonce: nonce);
  print('Transaction ID: $txId');

  await Future.delayed(Duration(seconds: 12));  // it'll be included in the SDK Soon in 2020

  // layer-1 transaction must be confirmed
  final txStatus = await layer1Api.getTxnStatus(txId);
  print('Tx status: ${txStatus.value.toJson()}');  // the SDK uses optional's Optional result

  // now you can query from the layer-2 API as well!
  final layer2Api = Layer2Api(network);
  final dacTxStatus = await layer2Api.getTxnStatus(txId);
  print('DAC Tx status: ${dacTxStatus.value}');  // the SDK uses optional's Optional result

  // we assume here that signedContract is in scope and available
  final expectedContentId = digestJson(signedContractJson);

  final history = await layer2Api.getBeforeProofHistory(expectedContentId);
  print('Proof history: ${history.toJson()}');

  // TODO make sure that everything's properly disposed:
  //      keyId, morpheusPrivate, signedContract, beforeProof, etc
  morpheusPlugin.dispose();
  vault.dispose();
}
