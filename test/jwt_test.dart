import 'package:iop_sdk/crypto.dart';
import 'package:test/test.dart';

import 'util.dart';

const TOKEN =
    'eyJhbGciOiJNdWx0aWNpcGhlciIsImtpZCI6InBlejJDTGtCVWpIQjh3OEc4N0QzWWtSRWpwUnVpcVB1NkJyUnNnSE1ReTJQenQ2In0.eyJleHAiOjE1OTYxOTU1NjcsIm5iZiI6MTU5NjE5NTI2NywianRpIjoiY2p1cHFxdVJSYWcybEtUV0FqZS1mRGdvcllVQkVuNE5pNks4Uk11TmhYV05hOCJ9.c2V6NmlTQWU0TGE1NllveHhHREdod2NOYzZNZFZQOWhIUzdTN2g4ZU1WUW9jNTVMS1RrZ0pTUU52eG5VNHV2RGV2YXhWRjN2Q2MyWHYyY1hYekp5YmZNQ3FBMg';
const CONTENT_ID = 'cjupqquRRag2lKTWAje-fDgorYUBEn4Ni6K8RMuNhXWNa8';

DateTime testNow() {
  return DateTime.fromMillisecondsSinceEpoch(1000 * 1596195267);
}

void main() {
  group('JWT', () {
    test('builder/parser', () {
      final vault = TestVault.create();
      final sk = vault.privateKey;

      final builder = JwtBuilder.withContentId(CONTENT_ID);
      builder.createdAt = testNow();
      final token = builder.sign(sk);
      expect(token, TOKEN);
      builder.dispose();

      final parser = JwtParser.create(TOKEN, currentTime: testNow());
      expect(parser.createdAt, testNow());
      expect(parser.publicKey.toString(), sk.publicKey().toString());
      expect(parser.contentId, CONTENT_ID);
      expect(parser.timeToLive, Duration(minutes: 5));
      parser.dispose();

      sk.dispose();
    });
  });
}
