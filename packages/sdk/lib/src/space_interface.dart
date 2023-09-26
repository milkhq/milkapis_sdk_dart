import 'package:milkapis_client_dart/generated/space.pbgrpc.dart'
    as space_schema;

abstract class Space {
  String host = 'localhost';
  int port = 8082;
  bool isGrpcWeb = false;

  Future<space_schema.SpaceDocument> getSpaceById({required String spaceId});
  Future<space_schema.SpaceDocument> createSpace(
      {required space_schema.SpaceDocument space});
  Future<void> updateSpaceMetadata(
      {required String spaceId,
      required space_schema.SpaceDocument_Metadata metadata});
  Future<void> deleteSpace({required String spaceId});
  Future<void> archiveSpace({required String spaceId});
  Future<void> activateSpace({required String spaceId});
  Future<void> updateSpaceVisibility(
      {required String spaceId,
      required space_schema.SPACE_VISIBILITY visibility});
  Future<void> updateSpaceCategory(
      {required String spaceId, required space_schema.SPACE_CATEGORY category});
  Future<String> createSpaceInvite(
      {required String spaceId, required String uid});
  Future<void> deleteSpaceInvite(
      {required String spaceId, required String spaceInviteDocumentId});
  Future<List<space_schema.SpaceInviteDocument>> getSpaceInvites(
      {required String spaceId});
  Future<space_schema.SpaceInviteDocument> getSpaceInvite(
      {required String spaceId, required String spaceInviteDocumentId});

  Future<List<space_schema.UserSpaceDocument>> getUserSpaces(
      {required String uid});
}
