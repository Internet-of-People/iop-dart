import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_MorpheusPrivate = Void Function(
  Pointer<Void> morpheusPrivate,
);
typedef DDelete_MorpheusPrivate = void Function(
  Pointer<Void> morpheusPrivate,
);

typedef NMorpheusPrivate_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
);
typedef DMorpheusPrivate_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
);

typedef NMorpheusPrivate_Public_Get = Pointer<Void> Function(
  Pointer<Void> morpheusPrivate,
);
typedef DMorpheusPrivate_Public_Get = Pointer<Void> Function(
  Pointer<Void> morpheusPrivate,
);

typedef NMorpheusPrivate_KeyByPk = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> pk,
);
typedef DMorpheusPrivate_KeyByPk = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> pk,
);

typedef NMorpheusPrivate_SignDidOperations = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> id,
  Pointer<NativeSlice> data,
);
typedef DMorpheusPrivate_SignDidOperations = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> id,
  Pointer<NativeSlice> data,
);

typedef NMorpheusPrivate_SignWitnessRequest = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> id,
  Pointer<Utf8> request,
);
typedef DMorpheusPrivate_SignWitnessRequest = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> id,
  Pointer<Utf8> request,
);

typedef NMorpheusPrivate_SignWitnessStatement = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> id,
  Pointer<Utf8> statement,
);
typedef DMorpheusPrivate_SignWitnessStatement = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> id,
  Pointer<Utf8> statement,
);

typedef NMorpheusPrivate_SignClaimPresentation = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> id,
  Pointer<Utf8> presentation,
);
typedef DMorpheusPrivate_SignClaimPresentation = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> id,
  Pointer<Utf8> presentation,
);

class NativeMorpheusPrivate {
  final DDelete_MorpheusPrivate delete;
  final DMorpheusPrivate_Personas_Get personasGet;
  final DMorpheusPrivate_Public_Get publicGet;
  final DMorpheusPrivate_KeyByPk keyByPk;
  final DMorpheusPrivate_SignDidOperations signDidOperations;
  final DMorpheusPrivate_SignWitnessRequest signWitnessRequest;
  final DMorpheusPrivate_SignWitnessStatement signWitnessStatement;
  final DMorpheusPrivate_SignClaimPresentation signClaimPresentation;

  NativeMorpheusPrivate(DynamicLibrary lib)
      : delete = lib
            .lookupFunction<NDelete_MorpheusPrivate, DDelete_MorpheusPrivate>(
          'delete_MorpheusPrivate',
        ),
        personasGet = lib.lookupFunction<NMorpheusPrivate_Personas_Get,
            DMorpheusPrivate_Personas_Get>(
          'MorpheusPrivate_personas_get',
        ),
        publicGet = lib.lookupFunction<NMorpheusPrivate_Public_Get,
            DMorpheusPrivate_Public_Get>(
          'MorpheusPrivate_public_get',
        ),
        keyByPk = lib
            .lookupFunction<NMorpheusPrivate_KeyByPk, DMorpheusPrivate_KeyByPk>(
          'MorpheusPrivate_key_by_pk',
        ),
        signDidOperations = lib.lookupFunction<
            NMorpheusPrivate_SignDidOperations,
            DMorpheusPrivate_SignDidOperations>(
          'MorpheusPrivate_sign_did_operations',
        ),
        signWitnessRequest = lib.lookupFunction<
            NMorpheusPrivate_SignWitnessRequest,
            DMorpheusPrivate_SignWitnessRequest>(
          'MorpheusPrivate_sign_witness_request',
        ),
        signWitnessStatement = lib.lookupFunction<
            NMorpheusPrivate_SignWitnessStatement,
            DMorpheusPrivate_SignWitnessStatement>(
          'MorpheusPrivate_sign_witness_statement',
        ),
        signClaimPresentation = lib.lookupFunction<
            NMorpheusPrivate_SignClaimPresentation,
            DMorpheusPrivate_SignClaimPresentation>(
          'MorpheusPrivate_sign_claim_presentation',
        );
}
