import 'dart:convert';
import 'dart:typed_data';

// Shamelessly copied from https://github.com/hathibelagal-dev/LEB128/blob/master/lib/leb128.dart#L55
List<int> encodeVarUint(int number) {
  final parts = <int>[];
  while (number > 0) {
    final part = number & 0x7f;
    number >>= 7;
    parts.add(part);
  }
  for (var i = 0; i < parts.length - 1; i++) {
    parts[i] |= 0x80;
  }
  return parts;
}

// This binary encoding of a string resembles protobuf strings
ByteData serialize(String input) {
  final inputBytes = utf8.encode(input);
  final prefix = encodeVarUint(inputBytes.length);
  return Uint8List.fromList(List.of(prefix.followedBy(inputBytes)))
      .buffer
      .asByteData();
}
