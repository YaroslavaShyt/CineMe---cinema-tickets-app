import 'package:cine_me/features/authentification/data/datasourses/auth_remote_datasource.dart';
import 'package:cine_me/features/authentification/domain/usecases/silent_login.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentification/data/repositories/auth_repository_imp.dart';
import '../../features/authentification/domain/repositories/silent_authentication_repository.dart';
import '../../features/authentification/presentation/bloc/silent_login_bloc.dart';


final getItInst = GetIt.I;

Future init() async {
  getItInst.registerLazySingleton<AuthenticationRemoteDatasource>(
          () => AuthenticationRemoteDatasourceImpl());
  getItInst.registerLazySingleton<SilentLogin>(() => SilentLogin(getItInst()));
  getItInst.registerLazySingleton<AuthenticationRepository>(
          () => AuthenticationRepositoryImp(getItInst()));

  getItInst.registerFactory(() => SilentLoginBloc(
    silentLogin: getItInst(),
  ));// getItInst<SilentLoginBloc>
}
