import 'package:get_it/get_it.dart';
import 'package:milkapis_sdk_dart/sdk.dart';

export 'package:milkapis_sdk_dart/src/auth_firebase_impl.dart';
export 'package:milkapis_sdk_dart/src/auth_interface.dart';
export 'package:milkapis_sdk_dart/src/core_interface.dart';
export 'package:milkapis_sdk_dart/src/core_firebase_impl.dart';
export 'package:milkapis_sdk_dart/src/space_impl.dart';
export 'package:milkapis_sdk_dart/src/space_interface.dart';
export 'package:milkapis_sdk_dart/src/messaging_interface.dart';

class MilkSdk {
  static init() {
    GetIt.instance
        .registerLazySingleton<CoreFirebaseImpl>(() => CoreFirebaseImpl());
    GetIt.instance
        .registerLazySingleton<AuthFirebaseImpl>(() => AuthFirebaseImpl());
    GetIt.instance.registerLazySingleton<SpaceImpl>(() => SpaceImpl());
  }

  static CoreFirebaseImpl get core => GetIt.instance.get<CoreFirebaseImpl>();
  static SpaceImpl get space => GetIt.instance.get<SpaceImpl>();
  static AuthFirebaseImpl get auth => GetIt.instance.get<AuthFirebaseImpl>();
}
