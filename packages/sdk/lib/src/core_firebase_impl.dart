// import 'package:firebase_core/firebase_core.dart' as firebase_core;
// import 'dart:convert';

import 'dart:convert';

import 'package:milkapis_sdk_dart/sdk.dart';
import 'package:firedart/firedart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// / Stores tokens as preferences in Android and iOS.
// / Depends on the shared_preferences plugin: https://pub.dev/packages/shared_preferences
class PreferencesStore extends TokenStore {
  static const keyToken = "auth_token";

  static Future<PreferencesStore> create() async =>
      PreferencesStore._internal(await SharedPreferences.getInstance());

  final SharedPreferences _prefs;

  PreferencesStore._internal(this._prefs);

  @override
  Token? read() => _prefs.containsKey(keyToken)
      ? Token.fromMap(json.decode(_prefs.get(keyToken).toString()))
      : null;

  @override
  void write(Token? token) =>
      _prefs.setString(keyToken, json.encode(token?.toMap()));

  @override
  void delete() => _prefs.remove(keyToken);
}
// typedef ClientOptions = firebase_core.FirebaseOptions;

class CoreFirebaseImpl extends Core {
  @override
  Future<void> init({required String apiKey}) async {
    auth = FirebaseAuth.initialize(apiKey, await PreferencesStore.create());
    if (auth.isSignedIn) {
      final user = await auth.getUser();
      currentUser = UserFirebaseImpl(userId: user.id);
      userChanges.add(currentUser);
    }
    auth.signInState.listen((isSignIn) async {
      if (isSignIn) {
        final user = await auth.getUser();
        print('User signed in: $user');
        currentUser = UserFirebaseImpl(userId: user.id);
      } else {
        currentUser = null;
      }

      userChanges.add(currentUser);
    });
  }

  User? currentUser;
}
