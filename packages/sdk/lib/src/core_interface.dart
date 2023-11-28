import 'package:firedart/firedart.dart';
import 'package:milkapis_sdk_dart/sdk.dart';
import 'package:rxdart/subjects.dart';

abstract class Core {
  Future<void>? isReady;

  BehaviorSubject<User?> userChanges = BehaviorSubject();

  FirebaseAuth? _auth;
  set auth(FirebaseAuth? value) {
    _auth = value;
  }

  Future<void> init({required String apiKey}) async {}

  FirebaseAuth get auth {
    if (_auth == null) {
      throw Exception(
          "FirebaseAuth hasn't been initialized. Please call await Core.init() before using it.");
    }
    return _auth!;
  }
}
