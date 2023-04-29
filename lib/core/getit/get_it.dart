import 'package:cine_me/features/authentification/data/datasourses/auth_remote_datasource.dart';
import 'package:cine_me/features/authentification/domain/usecases/silent_login.dart';
import 'package:cine_me/features/films/data/datasourses/films_remote_datasourse.dart';
import 'package:cine_me/features/films/data/repositories/films_repository_imp.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../../features/authentification/data/repositories/auth_repository_imp.dart';
import '../../features/authentification/domain/repositories/silent_authentication_repository.dart';
import '../../features/authentification/presentation/bloc/silent_login_bloc.dart';
import '../../features/films/domain/usecases/get_films.dart';
import '../../features/films/presentation/bloc/films_bloc.dart';


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


  getItInst.registerLazySingleton<FilmsRemoteDatasourse>(
          () => FilmsRemoteDatasourseImpl());
  getItInst.registerLazySingleton<Films>(() => Films(getItInst()));
  getItInst.registerLazySingleton<FilmsRepository>(
          () => FilmsRepositoryImpl(getItInst()));
  getItInst.registerFactory(() => FilmsBloc(
      films: getItInst(),
      date: '',
      search: ''
  ));
}
