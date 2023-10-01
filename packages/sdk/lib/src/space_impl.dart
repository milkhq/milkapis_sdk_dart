import 'package:grpc/grpc.dart';
import 'package:milkapis_client_dart/generated/space.pbgrpc.dart'
    as space_schema;
import 'package:milkapis_sdk_dart/src/base.dart';
import 'package:milkapis_sdk_dart/src/grpc_client.dart';
import 'package:pool/pool.dart';

export 'package:milkapis_client_dart/generated/space.pbgrpc.dart';

class SpaceImpl extends Space {
  final _clientPool = Pool(3, timeout: Duration(seconds: 30));

  Future<Channel> get channel {
    return _clientPool.withResource(() {
      return createChannel(isGrpcWeb: isGrpcWeb, host: host, port: port);
    });
  }

  CallOptions get callOptions =>
      CallOptions(compression: const GzipCodec(), providers: [
        (map, key) async {
          map['authorization'] = (await MilkSdk.auth.idToken) ?? '';
        }
      ]);

  @override
  Future<space_schema.SpaceClient> getClient() async {
    return space_schema.SpaceClient(await channel, options: callOptions);
  }

  @override
  Future<void> activateSpace({required String spaceId}) async {
    final client = await getClient();

    await client
        .activateSpace(space_schema.UpdateSpaceStatusRequest(spaceId: spaceId));
  }

  @override
  Future<void> archiveSpace({required String spaceId}) async {
    final client = await getClient();

    await client
        .archiveSpace(space_schema.UpdateSpaceStatusRequest(spaceId: spaceId));
  }

  @override
  Future<space_schema.CreateSpaceResponse> createSpace(
      {required space_schema.CreateSpaceRequest request}) {
    return getClient().then((client) {
      return client.createSpace(request);
    });
  }

  @override
  Future<String> createSpaceInvite(
      {required String spaceId, required String uid}) async {
    final client = await getClient();

    final response = await client.createSpaceInvite(
        space_schema.CreateSpaceInviteRequest(spaceId: spaceId, uid: uid));

    return response.spaceInviteDocumentId;
  }

  @override
  Future<void> deleteSpace({required String spaceId}) async {
    final client = await getClient();

    await client
        .deleteSpace(space_schema.UpdateSpaceStatusRequest(spaceId: spaceId));
  }

  @override
  Future<void> deleteSpaceInvite(
      {required String spaceId, required String spaceInviteDocumentId}) async {
    final client = await getClient();

    await client.deleteSpaceInvite(space_schema.DeleteSpaceInviteRequest(
        spaceId: spaceId, spaceInviteDocumentId: spaceInviteDocumentId));
  }

  @override
  Future<space_schema.SpaceDocument> getSpaceById(
      {required String spaceId}) async {
    final client = await getClient();

    final response =
        await client.getSpace(space_schema.GetSpaceRequest(spaceId: spaceId));

    return response;
  }

  @override
  Future<space_schema.SpaceInviteDocument> getSpaceInvite(
      {required String spaceId, required String spaceInviteDocumentId}) async {
    final client = await getClient();

    final response = await client.getSpaceInvite(
        space_schema.GetSpaceInviteRequest(
            spaceId: spaceId, spaceInviteDocumentId: spaceInviteDocumentId));

    return response;
  }

  @override
  Future<List<space_schema.SpaceInviteDocument>> getSpaceInvites(
      {required String spaceId}) async {
    final client = await getClient();

    final response = await client
        .getSpaceInvites(space_schema.GetSpaceInviteRequest(spaceId: spaceId));

    return response.documents;
  }

  @override
  Future<void> updateSpaceCategory(
      {required String spaceId,
      required space_schema.SPACE_CATEGORY category}) async {
    final client = await getClient();

    await client.updateSpaceCategory(space_schema.UpdateSpaceCategoryRequest(
        spaceId: spaceId, category: category));
  }

  @override
  Future<void> updateSpaceMetadata(
      {required String spaceId,
      required space_schema.SpaceDocument_Metadata metadata}) async {
    final client = await getClient();

    await client.updateSpaceMetadata(space_schema.UpdateSpaceMetadataRequest(
        spaceId: spaceId, metadata: metadata));
  }

  @override
  Future<void> updateSpaceVisibility(
      {required String spaceId,
      required space_schema.SPACE_VISIBILITY visibility}) async {
    final client = await getClient();

    await client.updateSpaceVisibility(
        space_schema.UpdateSpaceVisibilityRequest(
            spaceId: spaceId, visibility: visibility));
  }

  @override
  Future<List<String>> getUserSpaces({required String uid}) async {
    final client = await getClient();

    final response =
        await client.getUserSpaces(space_schema.GetUserSpacesRequest(uid: uid));

    return response.documents;
  }

  @override
  Future<space_schema.UpdateSpaceCustomizationResponse>
      updateSpaceCustomization(
          {required space_schema.UpdateSpaceCustomizationRequest request}) {
    return getClient().then((client) {
      return client.updateSpaceCustomization(request);
    });
  }

  @override
  Future<space_schema.UpdateSpaceCustomizationResponse>
      updateSpaceCustomizationProfile(
          {required space_schema.UpdateSpaceCustomizationRequest request}) {
    return getClient().then((client) {
      return client.updateSpaceCustomization(request);
    });
  }

  @override
  Future<space_schema.UpdateUserSpaceOrderResponse> updateUserSpaceOrder(
      {required space_schema.UpdateUserSpaceOrderRequest request}) {
    return getClient().then((client) {
      return client.updateUserSpaceOrder(request);
    });
  }
}
