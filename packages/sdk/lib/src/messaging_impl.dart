import 'package:grpc/grpc.dart';
import 'package:milkapis_sdk_dart/sdk.dart';
import 'package:milkapis_sdk_dart/src/grpc_client.dart';
import 'package:pool/pool.dart';
import 'package:milkapis_client_dart/generated/messaging.pbgrpc.dart'
    as messaging;

export 'package:milkapis_client_dart/generated/messaging.pbgrpc.dart';

class MessagingImpl extends Messaging {
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
  Future<messaging.MessagingClient> getClient() async {
    return messaging.MessagingClient(await channel, options: callOptions);
  }

  @override
  Future<UpdateChannelStatusResponse> activateDirectChannel(
      {required UpdateChannelStatusRequest request}) async {
    final client = await getClient();
    final response = await client.activateDirectChannel(request);
    return response;
  }

  @override
  Future<UpdateChannelStatusResponse> activateSpaceChannel(
      {required UpdateChannelStatusRequest request}) {
    return getClient().then((client) => client.activateSpaceChannel(request));
  }

  @override
  Future<UpdateChannelStatusResponse> activateThreadChannel(
      {required UpdateChannelStatusRequest request}) {
    return getClient().then((client) => client.activateThreadChannel(request));
  }

  @override
  Future<UpdateChannelStatusResponse> archiveDirectChannel(
      {required UpdateChannelStatusRequest request}) {
    return getClient().then((client) => client.archiveDirectChannel(request));
  }

  @override
  Future<UpdateChannelStatusResponse> archiveSpaceChannel(
      {required UpdateChannelStatusRequest request}) {
    return getClient().then((client) => client.archiveSpaceChannel(request));
  }

  @override
  Future<UpdateChannelStatusResponse> archiveThreadChannel(
      {required UpdateChannelStatusRequest request}) {
    return getClient().then((client) => client.archiveThreadChannel(request));
  }

  @override
  Future<CreateChannelResponse> createDirectChannel(
      {required CreateChannelRequest request}) {
    return getClient().then((client) => client.createDirectChannel(request));
  }

  @override
  Future<CreateChannelResponse> createSpaceChannel(
      {required CreateChannelRequest request}) {
    return getClient().then((client) => client.createSpaceChannel(request));
  }

  @override
  Future<CreateChannelResponse> createThreadChannel(
      {required CreateChannelRequest request}) {
    return getClient().then((client) => client.createThreadChannel(request));
  }

  @override
  Future<UpdateChannelStatusResponse> deleteDirectChannel(
      {required UpdateChannelStatusRequest request}) {
    return getClient().then((client) => client.deleteDirectChannel(request));
  }

  @override
  Future<DeleteMessageResponse> deleteDirectChannelMessage(
      {required DeleteMessageRequest request}) {
    return getClient()
        .then((client) => client.deleteDirectChannelMessage(request));
  }

  @override
  Future<UpdateChannelStatusResponse> deleteSpaceChannel(
      {required UpdateChannelStatusRequest request}) {
    return getClient().then((client) => client.deleteSpaceChannel(request));
  }

  @override
  Future<UpdateChannelStatusResponse> deleteThreadChannel(
      {required UpdateChannelStatusRequest request}) {
    return getClient().then((client) => client.deleteThreadChannel(request));
  }

  @override
  Future<DeleteMessageResponse> deleteThreadChannelMessage(
      {required DeleteMessageRequest request}) {
    return getClient()
        .then((client) => client.deleteThreadChannelMessage(request));
  }

  @override
  Future<SendMessageResponse> sendDirectChannelMessage(
      {required SendMessageRequest request}) {
    return getClient()
        .then((client) => client.sendDirectChannelMessage(request));
  }

  @override
  Future<SendMessageResponse> sendSpaceChannelMessage(
      {required SendMessageRequest request}) {
    return getClient()
        .then((client) => client.sendSpaceChannelMessage(request));
  }

  @override
  Future<SendMessageResponse> sendThreadChannelMessage(
      {required SendMessageRequest request}) {
    return getClient()
        .then((client) => client.sendThreadChannelMessage(request));
  }

  @override
  Future<UpdateMessageResponse> updateDirectChannelMessage(
      {required UpdateMessageRequest request}) {
    return getClient()
        .then((client) => client.updateDirectChannelMessage(request));
  }

  @override
  Future<UpdateChannelMetadataResponse> updateDirectChannelMetadata(
      {required UpdateChannelMetadataRequest request}) {
    return getClient()
        .then((client) => client.updateDirectChannelMetadata(request));
  }

  @override
  Future<UpdateChannelMetadataResponse> updateSpaceChannelMetadata(
      {required UpdateChannelMetadataRequest request}) {
    return getClient()
        .then((client) => client.updateSpaceChannelMetadata(request));
  }

  @override
  Future<UpdateMessageResponse> updateThreadChannelMessage(
      {required UpdateMessageRequest request}) {
    return getClient()
        .then((client) => client.updateThreadChannelMessage(request));
  }

  @override
  Future<UpdateChannelMetadataResponse> updateThreadChannelMetadata(
      {required UpdateChannelMetadataRequest request}) {
    return getClient()
        .then((client) => client.updateThreadChannelMetadata(request));
  }

  @override
  Future<ChannelDocument> getSpaceChannel(
      {required GetSpaceChannelRequest request}) {
    return getClient().then((client) => client.getSpaceChannel(request));
  }

  @override
  Future<List<String>> getSpaceChannels(
      {required GetSpaceChannelsRequest request}) {
    return getClient()
        .then((client) => client.getSpaceChannels(request))
        .then((response) => response.documents);
  }

  @override
  Future<UpdateSpaceChannelOrderResponse> updateSpaceChannelOrder(
      {required UpdateSpaceChannelOrderRequest request}) {
    return getClient()
        .then((client) => client.updateSpaceChannelOrder(request));
  }

  @override
  Future<List<ChannelCategoryDocument>> getSpaceChannelCategories(
      {required GetSpaceChannelCategoriesRequest request}) {
    return getClient()
        .then((client) => client.getSpaceChannelCategories(request))
        .then((response) => response.documents);
  }
}
