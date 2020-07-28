import 'dart:io';
import 'package:iop_sdk/crypto.dart';

const VAULT_FILE = '/tmp/tutorial_vault.state';

void main(List<String> arguments) async {
  await createAndSaveVault();
  await loadVault();
}

Future<void> createAndSaveVault() async {
  // YOU HAVE TO SAVE IT TO A SAFE PLACE!
  final phrase = Bip39('en').generatePhrase();

  final vault = Vault.create(phrase, '8qjaX^UNAafDL@!#', 'unlock password');
  final serializedState = vault.save();
  await File(VAULT_FILE).writeAsString(serializedState, flush: true);

  print('Saved vault to $VAULT_FILE');
}

Future<void> loadVault() async {
  final backup = await File(VAULT_FILE).readAsString();
  final vault = Vault.load(backup);

  print('Loaded vault state: ${vault.save()}');
}
