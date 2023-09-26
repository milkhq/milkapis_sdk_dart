import 'package:get_it/get_it.dart';
import 'package:milkapis_sdk_dart/sdk.dart';
import 'package:milkapis_sdk_dart/src/messaging_impl.dart';
import 'package:milkapis_sdk_dart/src/auth_firebase_impl.dart' as auth;
import 'package:milkapis_sdk_dart/src/space_impl.dart' as space;
import 'package:milkapis_sdk_dart/src/messaging_impl.dart' as messaging;

export 'package:milkapis_sdk_dart/src/auth_firebase_impl.dart'
    hide DOCUMENT_STATUS;

export 'package:milkapis_sdk_dart/src/auth_interface.dart';
export 'package:milkapis_sdk_dart/src/core_interface.dart';
export 'package:milkapis_sdk_dart/src/core_firebase_impl.dart';
export 'package:milkapis_sdk_dart/src/space_impl.dart' hide DOCUMENT_STATUS;
export 'package:milkapis_sdk_dart/src/space_interface.dart';
export 'package:milkapis_sdk_dart/src/messaging_interface.dart'
    hide DOCUMENT_STATUS;

// ignore: camel_case_types
typedef AUTH_DOCUMENT_STATUS = auth.DOCUMENT_STATUS;
// ignore: camel_case_types
typedef SPACE_DOCUMENT_STATUS = space.DOCUMENT_STATUS;
// ignore: camel_case_types
typedef MESSAGING_DOCUMENT_STATUS = messaging.DOCUMENT_STATUS;

class MilkSdk {
  static init() {
    GetIt.instance
        .registerLazySingleton<CoreFirebaseImpl>(() => CoreFirebaseImpl());
    GetIt.instance
        .registerLazySingleton<AuthFirebaseImpl>(() => AuthFirebaseImpl());
    GetIt.instance.registerLazySingleton<SpaceImpl>(() => SpaceImpl());
    GetIt.instance.registerLazySingleton<MessagingImpl>(() => MessagingImpl());
  }

  static CoreFirebaseImpl get core => GetIt.instance.get<CoreFirebaseImpl>();
  static SpaceImpl get space => GetIt.instance.get<SpaceImpl>();
  static AuthFirebaseImpl get auth => GetIt.instance.get<AuthFirebaseImpl>();
  static MessagingImpl get messaging => GetIt.instance.get<MessagingImpl>();
}
