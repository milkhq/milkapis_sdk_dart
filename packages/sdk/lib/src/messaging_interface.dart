import 'package:milkapis_sdk_dart/sdk.dart';

export 'package:milkapis_client_dart/generated/messaging.pbgrpc.dart';

abstract class Messaging {
  String host = 'localhost';
  int port = 8083;
  bool isGrpcWeb = false;

  Future<CreateChannelResponse> createSpaceChannel(
      {required CreateChannelRequest request});
  Future<CreateChannelResponse> createDirectChannel(
      {required CreateChannelRequest request});
  Future<CreateChannelResponse> createThreadChannel(
      {required CreateChannelRequest request});

  Future<UpdateChannelMetadataResponse> updateSpaceChannelMetadata({
    required UpdateChannelMetadataRequest request,
  });
  Future<UpdateChannelMetadataResponse> updateDirectChannelMetadata({
    required UpdateChannelMetadataRequest request,
  });
  Future<UpdateChannelMetadataResponse> updateThreadChannelMetadata({
    required UpdateChannelMetadataRequest request,
  });

  Future<UpdateChannelStatusResponse> deleteSpaceChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusResponse> deleteDirectChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusResponse> deleteThreadChannel(
      {required UpdateChannelStatusRequest request});

  Future<UpdateChannelStatusResponse> archiveSpaceChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusResponse> archiveDirectChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusResponse> archiveThreadChannel(
      {required UpdateChannelStatusRequest request});

  Future<UpdateChannelStatusResponse> activateSpaceChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusResponse> activateDirectChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusResponse> activateThreadChannel(
      {required UpdateChannelStatusRequest request});

  Future<SendMessageResponse> sendSpaceChannelMessage(
      {required SendMessageRequest request});
  Future<SendMessageResponse> sendDirectChannelMessage(
      {required SendMessageRequest request});
  Future<SendMessageResponse> sendThreadChannelMessage(
      {required SendMessageRequest request});

  Future<UpdateMessageResponse> updateSpaceChannelMessage(
      {required UpdateMessageRequest request});
  Future<UpdateMessageResponse> updateDirectChannelMessage(
      {required UpdateMessageRequest request});
  Future<UpdateMessageResponse> updateThreadChannelMessage(
      {required UpdateMessageRequest request});

  Future<DeleteMessageResponse> deleteSpaceChannelMessage(
      {required DeleteMessageRequest request});
  Future<DeleteMessageResponse> deleteDirectChannelMessage(
      {required DeleteMessageRequest request});
  Future<DeleteMessageResponse> deleteThreadChannelMessage(
      {required DeleteMessageRequest request});

  Future<List<ChannelDocument>> getSpaceChannels(
      {required GetSpaceChannelsRequest request});

  Future<ChannelDocument> getSpaceChannel({
    required GetSpaceChannelRequest request,
  });
}
