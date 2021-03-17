import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_JwtBuilder = Void Function(
  Pointer<Void> builder,
);
typedef DDelete_JwtBuilder = void Function(
  Pointer<Void> builder,
);

typedef NJwtBuilder_Default = Pointer<Void> Function();
typedef DJwtBuilder_Create = Pointer<Void> Function();

typedef NJwtBuilder_WithContentId = Pointer<Result> Function(
  Pointer<Utf8> contentId,
);
typedef DJwtBuilder_WithContentId = Pointer<Result> Function(
  Pointer<Utf8> contentId,
);

typedef NJwtBuilder_CreatedAt_Set = Void Function(
  Pointer<Void> builder,
  Int64 createdAt,
);
typedef DJwtBuilder_CreatedAt_Set = void Function(
  Pointer<Void> builder,
  int createdAt,
);

typedef NJwtBuilder_CreatedAt_Get = Int64 Function(
  Pointer<Void> builder,
);
typedef DJwtBuilder_CreatedAt_Get = int Function(
  Pointer<Void> builder,
);

typedef NJwtBuilder_TimeToLive_Set = Void Function(
  Pointer<Void> builder,
  Int64 timeToLive,
);
typedef DJwtBuilder_TimeToLive_Set = void Function(
  Pointer<Void> builder,
  int timeToLive,
);

typedef NJwtBuilder_TimeToLive_Get = Int64 Function(
  Pointer<Void> builder,
);
typedef DJwtBuilder_TimeToLive_Get = int Function(
  Pointer<Void> builder,
);

typedef NJwtBuilder_Sign = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Void> privateKey,
);
typedef DJwtBuilder_Sign = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Void> privateKey,
);

class NativeJwtBuilder {
  final DDelete_JwtBuilder delete;
  final DJwtBuilder_Create create;
  final DJwtBuilder_WithContentId withContentId;
  final DJwtBuilder_CreatedAt_Get createdAt_get;
  final DJwtBuilder_CreatedAt_Set createdAt_set;
  final DJwtBuilder_TimeToLive_Get timeToLive_get;
  final DJwtBuilder_TimeToLive_Set timeToLive_set;
  final DJwtBuilder_Sign sign;

  NativeJwtBuilder(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_JwtBuilder, DDelete_JwtBuilder>(
          'delete_JwtBuilder',
        ),
        // "default" is a reserved word and cannot be used as a class member name
        create = lib.lookupFunction<NJwtBuilder_Default, DJwtBuilder_Create>(
          'JwtBuilder_default',
        ),
        withContentId = lib.lookupFunction<NJwtBuilder_WithContentId,
            DJwtBuilder_WithContentId>(
          'JwtBuilder_with_content_id',
        ),
        createdAt_get = lib.lookupFunction<NJwtBuilder_CreatedAt_Get,
            DJwtBuilder_CreatedAt_Get>(
          'JwtBuilder_created_at_get',
        ),
        createdAt_set = lib.lookupFunction<NJwtBuilder_CreatedAt_Set,
            DJwtBuilder_CreatedAt_Set>(
          'JwtBuilder_created_at_set',
        ),
        timeToLive_get = lib.lookupFunction<NJwtBuilder_TimeToLive_Get,
            DJwtBuilder_TimeToLive_Get>(
          'JwtBuilder_time_to_live_set',
        ),
        timeToLive_set = lib.lookupFunction<NJwtBuilder_TimeToLive_Set,
            DJwtBuilder_TimeToLive_Set>(
          'JwtBuilder_time_to_live_set',
        ),
        sign = lib.lookupFunction<NJwtBuilder_Sign, DJwtBuilder_Sign>(
          'JwtBuilder_sign',
        );
}
