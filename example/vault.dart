import 'dart:io';
import 'package:iop_sdk/crypto.dart';


void main(List<String> arguments) async {
  // YOU HAVE TO SAVE IT TO A SAFE PLACE!
  final phrase = Bip39('en').generatePhrase();
  final vault = Vault.create(
    phrase,
    '8qjaX^UNAafDL@!#',
    'unlock password',
  );

  final serializedState = vault.save();
  await File('tutorial_vault.state').writeAsString(
    serializedState,
    flush: true,
  );

  final backup = await File('tutorial_vault.state').readAsString();
  final loadedVault = Vault.load(backup);

  print('Loaded saved vault state: ${serializedState == loadedVault.save()}');

  await File('tutorial_vault.state').delete();
}
