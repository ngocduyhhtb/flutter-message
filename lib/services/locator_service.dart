import 'package:chat_app/bloc/user_bloc/user_bloc.dart';
import 'package:chat_app/repository/user/user_repository.dart';
import 'package:chat_app/utils/network_util/api_client.dart';
import 'package:chat_app/utils/uiUtil/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

Future setupLocator() async {
  GetIt.instance.registerLazySingleton(() => UserRepository());
  GetIt.instance.registerLazySingleton(() => ApiClient());
  GetIt.instance.registerFactory(() => SecureStorage());
  // GetIt.instance.registerSingleton()
}
