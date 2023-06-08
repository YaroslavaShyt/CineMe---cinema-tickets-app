import 'package:cine_me/features/account/domain/usecases/get_account.dart';
import 'package:cine_me/features/account/domain/usecases/get_user_tickets.dart';
import 'package:cine_me/features/account/presentation/bloc/account_bloc.dart';
import 'package:cine_me/features/authentication/data/datasourses/auth_remote_datasource.dart';
import 'package:cine_me/features/authentication/domain/usecases/silent_login.dart';
import 'package:cine_me/features/films/data/datasourses/films_remote_datasourse.dart';
import 'package:cine_me/features/films/data/repositories/films_repository_imp.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';
import 'package:cine_me/features/films/domain/usecases/buy_ticket.dart';
import 'package:cine_me/features/films/domain/usecases/get_session.dart';
import 'package:cine_me/features/films/domain/usecases/get_ticket_booked.dart';
import 'package:cine_me/features/films/presentation/bloc/book_ticket/book_ticket_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:cine_me/features/account/data/datasourses/account_remote_datasource.dart';
import 'package:cine_me/features/account/data/repositories/account_repository_imp.dart';
import 'package:cine_me/features/account/domain/repository/account_repository.dart';
import 'package:cine_me/features/authentication/data/repositories/auth_repository_imp.dart';
import 'package:cine_me/features/authentication/domain/repositories/silent_authentication_repository.dart';
import 'package:cine_me/features/authentication/presentation/bloc/silent_login_bloc.dart';
import 'package:cine_me/features/films/domain/usecases/get_films.dart';
import 'package:cine_me/features/films/presentation/bloc/buy_ticket/buy_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/bloc/films/films_bloc.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';

import '../../features/films/presentation/bloc/films_search_bloc/films_search_bloc.dart';


final getItInst = GetIt.I;

Future init() async {
  getItInst.registerLazySingleton<AuthenticationRemoteDatasource>(
          () => AuthenticationRemoteDatasourceImpl());
  getItInst.registerLazySingleton<SilentLogin>(() => SilentLogin(getItInst()));
  getItInst.registerLazySingleton<AuthenticationRepository>(
          () => AuthenticationRepositoryImp(getItInst()));
  getItInst.registerFactory(() =>
      SilentLoginBloc(
        silentLogin: getItInst(),
      ));


  getItInst.registerLazySingleton<FilmsRemoteDataSource>(
          () => FilmsRemoteDataSourceImpl());
  getItInst.registerLazySingleton<Films>(() => Films(getItInst()));
  getItInst.registerLazySingleton<FilmsRepository>(
          () => FilmsRepositoryImpl(getItInst()));

  getItInst.registerFactoryParam<FilmsBloc, String, String>((param1, param2) {
    return FilmsBloc(films: getItInst(), date: param1, search: param2);
  });

  getItInst.registerFactoryParam<FilmsSearchBloc, String, String>((param1, param2) {
    return FilmsSearchBloc(films: getItInst(), date: param1, search: param2);
  });



  getItInst.registerLazySingleton<FilmSessions>(() => FilmSessions(getItInst()));
  getItInst.registerFactoryParam<SessionsBloc, String, String>((param1, param2){
    return SessionsBloc(filmSessions: getItInst(), filmId: param1, sessionId: param2);
   },
  );

  getItInst.registerLazySingleton<BookedTicket>(() => BookedTicket(getItInst()));
  getItInst.registerFactoryParam<BookTicketBloc, int, List<int>>((param1, param2){
    return BookTicketBloc(bookedTicket: getItInst(), sessionId: param1, seats: param2);
  },
  );

  getItInst.registerLazySingleton<Tickets>(()=> Tickets(getItInst()));
  getItInst.registerLazySingleton<AccountRemoteDataSource>(
          () =>AccountRemoteDataSourceImpl());
  getItInst.registerLazySingleton<AccountRepository>(
          () => AccountRepositoryImp(getItInst()));
  getItInst.registerLazySingleton<Account>(() => Account(getItInst()));
  getItInst.registerFactoryParam<AccountBloc, Map<String, dynamic>, String>((param1, param2) {
    return AccountBloc(account: getItInst(), newUserData: param1, tickets: getItInst());
  });

  getItInst.registerLazySingleton<BoughtTicket>(() => BoughtTicket(getItInst()));
  getItInst.registerFactoryParam<BuyTicketBloc, BuildContext, void>((param1, param2) =>
      BuyTicketBloc(boughtTicket: getItInst(), context: param1),
  );


}
