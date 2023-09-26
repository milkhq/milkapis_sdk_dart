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

  Future<UpdateChannelStatusRequest> deleteSpaceChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusRequest> deleteDirectChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusRequest> deleteThreadChannel(
      {required UpdateChannelStatusRequest request});

  Future<UpdateChannelStatusRequest> archiveSpaceChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusRequest> archiveDirectChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusRequest> archiveThreadChannel(
      {required UpdateChannelStatusRequest request});

  Future<UpdateChannelStatusRequest> activateSpaceChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusRequest> activateDirectChannel(
      {required UpdateChannelStatusRequest request});
  Future<UpdateChannelStatusRequest> activateThreadChannel(
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
}
