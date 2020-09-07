import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';


typedef NDelete_JwtParser = Void Function(
  Pointer<Void> parser,
);
typedef DDelete_JwtParser = void Function(
  Pointer<Void> parser,
);

typedef NJwtParser_New = Pointer<Result> Function(
  Pointer<Utf8> token,
  Pointer<Int64> currentTime,
);
typedef DJwtParser_Create = Pointer<Result> Function(
  Pointer<Utf8> token,
  Pointer<Int64> currentTime,
);

typedef NJwtParser_PublicKey_Get = Pointer<Void> Function(
  Pointer<Void> parser,
);
typedef DJwtParser_PublicKey_Get = Pointer<Void> Function(
  Pointer<Void> parser,
);

typedef NJwtParser_CreatedAt_Get = Int64 Function(
  Pointer<Void> parser,
);
typedef DJwtParser_CreatedAt_Get = int Function(
  Pointer<Void> parser,
);

typedef NJwtParser_TimeToLive_Get = Int64 Function(
  Pointer<Void> parser,
);
typedef DJwtParser_TimeToLive_Get = int Function(
  Pointer<Void> parser,
);

typedef NJwtParser_ContentId_Get = Pointer<Utf8> Function(
  Pointer<Void> parser,
);
typedef DJwtParser_ContentId_Get = Pointer<Utf8> Function(
  Pointer<Void> parser,
);



class NativeJwtParser {
  final DDelete_JwtParser delete;
  final DJwtParser_Create create;
  final DJwtParser_PublicKey_Get publicKey_get;
  final DJwtParser_CreatedAt_Get createdAt_get;
  final DJwtParser_TimeToLive_Get timeToLive_get;
  final DJwtParser_ContentId_Get contentId_get;

  NativeJwtParser(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_JwtParser, DDelete_JwtParser>(
      'delete_JwtParser',
    ),
    create = lib.lookupFunction<NJwtParser_New, DJwtParser_Create>(
      'JwtParser_new',
    ),
    publicKey_get = lib.lookupFunction<NJwtParser_PublicKey_Get, DJwtParser_PublicKey_Get>(
      'JwtParser_public_key_get',
    ),
    createdAt_get = lib.lookupFunction<NJwtParser_CreatedAt_Get, DJwtParser_CreatedAt_Get>(
      'JwtParser_created_at_get',
    ),
    timeToLive_get = lib.lookupFunction<NJwtParser_TimeToLive_Get, DJwtParser_TimeToLive_Get>(
      'JwtParser_time_to_live_get',
    ),
    contentId_get = lib.lookupFunction<NJwtParser_ContentId_Get, DJwtParser_ContentId_Get>(
      'JwtParser_content_id_get',
    );
}