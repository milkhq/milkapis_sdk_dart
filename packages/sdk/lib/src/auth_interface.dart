import 'package:milkapis_client_dart/generated/user.pbgrpc.dart' as user_schema;
import 'package:milkapis_sdk_dart/sdk.dart';

typedef UserMetadata = user_schema.UserDocument;

abstract class User {
  String get uid;
  Future<String?> getIdToken();
}

typedef CustomToken = String;

abstract class Auth {
  String host = 'localhost';
  int port = 8081;
  bool isGrpcWeb = false;

  Future<CustomToken> signUpWithOauthCode(
      {required user_schema.SOCIAL socialId, required String code});
  Future<CustomToken> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<user_schema.CustomizationProfileDocument> getCustomizationProfileByUid(
      {required String uid});

  Future<List<String>> getCustomizationProfilesByUid({required String uid});

  Future<CustomizationProfileDocument> getUserCustomizationProfile({
    required GetUserCustomizationProfileRequest request,
  });

  Stream<List<user_schema.CustomizationProfileDocument>>
      subscribeCustomizationProfilesByUid({required String uid});

  Stream<user_schema.CustomizationProfileDocument>
      subscribeCustomizationProfileByUid({required String uid});

  Future<void> updateCustomizationProfile(
      {required String uid,
      required String customizationProfileId,
      required user_schema.CustomizationProfileDocument customizationProfile});

  Future<UpdateUserCustomizationProfileResponse> updateUserCustomizationProfile(
      {required UpdateUserCustomizationProfileRequest request});
  Future<CustomizationProfileDocument> createUserCustomizationProfile(
      {required CreateUserCustomizationProfileRequest request});

  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signInWithCustomToken(String token);
  Future<void> signOut();
  User? get currentUser;
  Stream<User?> get userChanges;
  Future<String?> get idToken;
  Stream<UserMetadata?> get metadataChanges;
  Future<UserMetadata?> get metadata;
  Future<UserMetadata?> getMetadataByUid({required String uid});
}
