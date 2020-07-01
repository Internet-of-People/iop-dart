// TODO previous design, adapt and remove
//class Morpheus {
//  List<Did> listDids() { throw UnimplementedError(); }
//  Did createDid() { throw UnimplementedError(); }
//
//  Future<MorpheusSigned<WitnessRequest>> signWitnessRequest(String witnessRequest, Authentication authentication)
//    { throw UnimplementedError(); }
//  Future<MorpheusSigned<WitnessStatement>> signWitnessStatement(String witnessStatement, Authentication authentication)
//    { throw UnimplementedError(); }
//  Future<MorpheusSigned<Presentation>> signClaimPresentation(String claimPresentation, Authentication authentication)
//    { throw UnimplementedError(); }
//}


// TODO should be strongly typed, e.g. returning SignedContent and maybe extracting signer address from tx
//String signMorpheusTransaction(MorpheusTransaction tx, HydraAddress gasAddress)
//  { throw UnimplementedError(); }
//Future<MorpheusSigned<MorpheusSignableOperationAttempt>> signDidOperation
//        (MorpheusSignableOperationAttempt tx, Authentication authentication)