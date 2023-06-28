import 'get_it_exports.dart';

final getItInst = GetIt.I;

Future init() async {
  getItInst.registerLazySingleton<AuthenticationRemoteDatasource>(
          () => AuthenticationRemoteDatasourceImpl());
  getItInst.registerLazySingleton<SilentLogin>(() => SilentLogin(getItInst()));
  getItInst.registerLazySingleton<AuthenticationRepository>(
          () => AuthenticationRepositoryImp(getItInst()));
  getItInst.registerFactory<SilentLoginBloc>(() =>
      SilentLoginBloc(
        silentLogin: getItInst(),
      ));


  getItInst.registerLazySingleton<FilmsRemoteDataSource>(
          () => FilmsRemoteDataSourceImpl());
  getItInst.registerLazySingleton<Films>(() => Films(getItInst()));
  getItInst.registerLazySingleton<FilmsRepository>(
          () => FilmsRepositoryImpl(getItInst()));

  getItInst.registerFactoryParam<FilmsBloc, String, String>((param1, param2, ) {
    return FilmsBloc(films: getItInst(), date: param1, search: param2);
  });

  getItInst.registerFactoryParam<FilmsSearchBloc, String,  String>((param1, param2) {
    return FilmsSearchBloc(films: getItInst(), date: param1, search: param2);
  });



  getItInst.registerLazySingleton<FilmSessions>(() => FilmSessions(getItInst()));
  getItInst.registerFactory<SessionsBloc>(() => SessionsBloc(filmSessions: getItInst())
  );

  getItInst.registerLazySingleton<BookedTicket>(() => BookedTicket(getItInst()));
  getItInst.registerFactory<BookTicketBloc>((){
    return BookTicketBloc(bookedTicket: getItInst());
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
      BuyTicketBloc(boughtTicket: getItInst(), context: param1,),
  );

  getItInst.registerLazySingleton<Comments>(()=> Comments(getItInst()));
  getItInst.registerLazySingleton<CommentAdded>(()=> CommentAdded(getItInst()));
  getItInst.registerLazySingleton<CommentDeleted>(()=> CommentDeleted(getItInst()));
  getItInst.registerFactory<CommentsBloc>(() =>
      CommentsBloc(
          comments: getItInst<Comments>(),
          commentDeleted: getItInst<CommentDeleted>(),
          commentAdded: getItInst<CommentAdded>()
      ));

}
