import 'dart:math';

import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';
import 'package:test/test.dart';

void main() {
  final api = Layer2Api.createCoeusApi(
    NetworkConfig.fromNetwork(Network.TestNet),
  );

  final randomDomain = () {
    final r = Random();
    return String.fromCharCodes(List.generate(10, (index) => r.nextInt(33) + 89));
  };

  group('api', () {
    test('resolve', () async {
      final domain = randomDomain();
      // TODO: register a random domain

      final resp = await api.resolve('.schema.$domain');

      // TODO delete the domain

      expect(resp.isPresent, true);
      expect(resp.value, '{"The_Answer_to_the_Ultimate_Question_of_Life_the_Universe_and_Everything_is": 42}');
    });

    test('resolve - not existing', () async {
      final resp = await api.resolve('.schema.itsnotthere');
      expect(resp.isPresent, false);
    });

    test('getMetadata', () async {
      final domain = randomDomain();
      // TODO: register a random domain

      final resp = await api.getMetadata('.schema.$domain');
      // TODO delete the domain
      expect(resp.isPresent, true);
      expect(resp.value.expiresAtHeight, 10000000000);
      expect(resp.value.owner, 'TODO');
      expect(resp.value.registraionPolicy, 'owner');
      expect(resp.value.subtreePolicies, 'TODO');
    });

    test('getMetadata - not existing', () async {
      final resp = await api.getMetadata('.schema.itsnotthere');
      expect(resp.isPresent, false);
    });

    test('getChildren', () async {
      final domain = randomDomain();
      // TODO: register a random domain
      // TODO: register some subdomains

      final resp = await api.getChildren('.schema.$domain');
      // TODO delete the domain
      expect(resp.isPresent, true);
      expect(resp.value.length, 2);
      expect(resp.value[0], '.sub1');
      expect(resp.value[1], '.sub2');
    });

    test('getChildren - not existing', () async {
      final resp = await api.getChildren('.schema.itsnotthere');
      expect(resp.isPresent, false);
    });

    test('getLastNonce', () async {
      final nonceBefore = await api.getLastNonce('TODO');
      expect(nonceBefore, 0);

      final domain = randomDomain();
      // TODO: register a random domain

      final nonceAfter = await api.getLastNonce('TODO');
      // TODO delete the domain
      expect(nonceAfter, 1);
    });
  });
}
