import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:milkapis_sdk_dart/src/core_interface.dart';

typedef ClientOptions = firebase_core.FirebaseOptions;

class CoreFirebaseImpl extends Core {
  void init({required ClientOptions options}) {
    isReady = firebase_core.Firebase.initializeApp(
      options: options,
    );
  }
}
