import 'package:grpc/grpc.dart';
import 'package:milkapis_client_dart/generated/user.pbgrpc.dart' as user_schema;
import 'package:milkapis_sdk_dart/src/auth_interface.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:milkapis_sdk_dart/src/grpc_client.dart';
import 'package:pool/pool.dart';

export 'package:milkapis_client_dart/generated/user.pbgrpc.dart';

class UserFirebaseImpl extends User {
  final firebase_auth.User user;

  UserFirebaseImpl({
    required this.user,
  });

  @override
  Future<String> getIdToken() async {
    final token = await user.getIdToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token is null/invalid');
    }

    return token;
  }

  @override
  String get uid => user.uid;
}

class AuthFirebaseImpl extends Auth {
  final _clientPool = Pool(3, timeout: Duration(seconds: 30));

  Future<Channel> get channel {
    return _clientPool.withResource(() {
      return createChannel(isGrpcWeb: isGrpcWeb, host: host, port: port);
    });
  }

  CallOptions get callOptions =>
      CallOptions(compression: const GzipCodec(), providers: [
        (map, key) async {
          map['authorization'] = (await idToken) ?? '';
        }
      ]);

  Future<user_schema.UserClient> getClient() async {
    return user_schema.UserClient(await channel, options: callOptions);
  }

  @override
  User? get currentUser =>
      firebase_auth.FirebaseAuth.instance.currentUser == null
          ? null
          : UserFirebaseImpl(
              user: firebase_auth.FirebaseAuth.instance.currentUser!);

  @override
  Future<void> signInWithCustomToken(String token) {
    return firebase_auth.FirebaseAuth.instance.signInWithCustomToken(token);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return firebase_auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return firebase_auth.FirebaseAuth.instance.signOut();
  }

  @override
  Stream<User?> get userChanges => firebase_auth.FirebaseAuth.instance
      .userChanges()
      .map((user) => user == null ? null : UserFirebaseImpl(user: user));

  @override
  Future<CustomToken> signUpWithOauthCode(
      {required user_schema.SOCIAL socialId, required String code}) async {
    final client = await getClient();

    final response = await client.createUser(user_schema.CreateUserRequest(
      social: socialId,
      oauthCode: code,
    ));

    return response.customToken;
  }

  @override
  Future<CustomToken> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    final client = await getClient();

    final response = await client
        .createUserEmailPassword(user_schema.CreateUserEmailPasswordRequest(
      email: email,
      password: password,
    ));

    return response.customToken;
  }

  @override
  Future<String?> get idToken {
    return currentUser?.getIdToken() ?? Future.value(null);
  }

  @override
  Future<UserMetadata?> get metadata {
    return currentUser?.uid == null || currentUser?.uid.isEmpty == true
        ? Future.value(null)
        : getMetadataByUid(uid: currentUser!.uid);
  }

  @override
  Stream<UserMetadata> get metadataChanges => throw UnimplementedError();

  @override
  Future<UserMetadata?> getMetadataByUid({required String uid}) async {
    final client = await getClient();

    final response = await client.getUser(user_schema.GetUserRequest(
      uid: uid,
    ));

    return response;
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
  Future<List<user_schema.CustomizationProfileDocument>>
      getCustomizationProfilesByUid({required String uid}) async {
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
}
