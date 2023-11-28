import 'package:milkapis_client_dart/generated/space.pbgrpc.dart'
    as space_schema;
import 'package:milkapis_sdk_dart/sdk.dart';

abstract class Space {
  String host = 'localhost';
  int port = 8082;
  bool isGrpcWeb = false;

  Future<space_schema.SpaceClient> getClient();
  Future<space_schema.SpaceClient> getUnauthenticatedClient();
  Future<space_schema.SpaceDocument> getSpaceById({required String spaceId});
  Future<space_schema.CreateSpaceResponse> createSpace(
      {required CreateSpaceRequest request});
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

  Future<List<String>> getUserSpaces({required String uid});
  Future<space_schema.UpdateSpaceCustomizationResponse>
      updateSpaceCustomization(
          {required space_schema.UpdateSpaceCustomizationRequest request});
  Future<space_schema.UpdateSpaceCustomizationResponse>
      updateSpaceCustomizationProfile(
          {required space_schema.UpdateSpaceCustomizationRequest request});

  Future<space_schema.UpdateUserSpaceOrderResponse> updateUserSpaceOrder(
      {required space_schema.UpdateUserSpaceOrderRequest request});
}
