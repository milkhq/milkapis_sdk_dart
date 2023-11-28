import 'package:grpc/grpc.dart';
import 'package:milkapis_client_dart/generated/user.pbgrpc.dart' as user_schema;
import 'package:milkapis_sdk_dart/sdk.dart';
import 'package:milkapis_sdk_dart/src/grpc_client.dart';
import 'package:pool/pool.dart';

export 'package:milkapis_client_dart/generated/user.pbgrpc.dart';

class UserFirebaseImpl extends User {
  final String userId;

  UserFirebaseImpl({
    required this.userId,
  });

  @override
  Future<String> getIdToken() async {
    final token = (await MilkSdk.core.auth.tokenProvider.idToken);

    if (token.isEmpty) {
      throw Exception('Token is null/invalid');
    }

    return token;
  }

  @override
  String get uid => userId;
}

class AuthFirebaseImpl extends Auth {
  final _clientPool = Pool(2, timeout: Duration(seconds: 30));

  Future<Channel> get channel {
    return _clientPool.withResource(() {
      return createChannel(isGrpcWeb: isGrpcWeb, host: host, port: port);
    });
  }

  CallOptions get callOptions =>
      CallOptions(compression: const GzipCodec(), providers: [
        (map, key) async {
          try {
            map['authorization'] = (await idToken) ?? '';
          } catch (e, stackTrace) {
            print('Error getting token: $e');
            print(stackTrace);
          }
        }
      ]);

  Future<user_schema.UserClient> getClient() async {
    return user_schema.UserClient(await channel, options: callOptions);
  }

  Future<user_schema.UserClient> getUnauthenticatedClient() async {
    return user_schema.UserClient(await channel);
  }

  @override
  Future<void> signInWithCustomToken(String token) {
    print('signInWithCustomToken: $token');
    return MilkSdk.core.auth.signInWithCustomToken(token);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return MilkSdk.core.auth.signIn(email, password);
  }

  @override
  Future<void> signOut() async {
    return MilkSdk.core.auth.signOut();
  }

  @override
  Stream<bool> get userChanges => MilkSdk.core.auth.signInState;

  @override
  Future<CustomToken> signUpWithOauthCode(
      {required user_schema.SOCIAL socialId, required String code}) async {
    final client = await getUnauthenticatedClient();

    print('signUpWithOauthCode: $socialId, $code');
    final response = await client.createUser(user_schema.CreateUserRequest(
      social: socialId,
      oauthCode: code,
    ));

    print('response: $response');

    return response.customToken;
  }

  @override
  Future<CustomToken> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    final client = await getUnauthenticatedClient();

    final response = await client
        .createUserEmailPassword(user_schema.CreateUserEmailPasswordRequest(
      email: email,
      password: password,
    ));

    return response.customToken;
  }

  @override
  Future<String?> get idToken {
    return MilkSdk.core.auth.tokenProvider.idToken;
  }

  @override
  Future<user_schema.CustomizationProfileDocument> getCustomizationProfileByUid(
      {required String uid}) async {
    final client = await getClient();

    final response = await client.getUserCustomizationProfile(
        user_schema.GetUserCustomizationProfileRequest(
      uid: uid,
    ));

    return response;
  }

  @override
  Future<List<String>> getCustomizationProfilesByUid(
      {required String uid}) async {
    final client = await getClient();

    final response = await client.listUserCustomizationProfiles(
        user_schema.ListUserCustomizationProfilesRequest(
      uid: uid,
    ));

    return response.documents;
  }

  @override
  Stream<user_schema.CustomizationProfileDocument>
      subscribeCustomizationProfileByUid({required String uid}) {
    // TODO: implement subscribeCustomizationProfileByUid
    throw UnimplementedError();
  }

  @override
  Stream<List<user_schema.CustomizationProfileDocument>>
      subscribeCustomizationProfilesByUid({required String uid}) {
    // TODO: implement subscribeCustomizationProfilesByUid
    throw UnimplementedError();
  }

  @override
  Future<void> updateCustomizationProfile(
      {required String uid,
      required String customizationProfileId,
      required user_schema.CustomizationProfileDocument
          customizationProfile}) async {
    final client = await getClient();

    await client.updateUserCustomizationProfile(
        user_schema.UpdateUserCustomizationProfileRequest(
      uid: uid,
      customizationProfileId: customizationProfileId,
      updatedDocument: customizationProfile,
    ));
  }

  @override
  Future<user_schema.UpdateUserCustomizationProfileResponse>
      updateUserCustomizationProfile(
          {required user_schema.UpdateUserCustomizationProfileRequest
              request}) {
    return getClient().then((client) {
      return client.updateUserCustomizationProfile(request);
    });
  }

  @override
  Future<user_schema.CustomizationProfileDocument>
      createUserCustomizationProfile(
          {required user_schema.CreateUserCustomizationProfileRequest
              request}) {
    return getClient().then((client) {
      return client.createUserCustomizationProfile(request);
    });
  }

  @override
  Future<user_schema.CustomizationProfileDocument> getUserCustomizationProfile(
      {required user_schema.GetUserCustomizationProfileRequest request}) {
    return getClient().then((client) {
      return client.getUserCustomizationProfile(request);
    });
  }

  @override
  Future<UserMetadata?> getMetadataByUid({required String uid}) {
    return getClient().then((client) {
      return client.getUser(user_schema.GetUserRequest(uid: uid));
    });
  }
}
