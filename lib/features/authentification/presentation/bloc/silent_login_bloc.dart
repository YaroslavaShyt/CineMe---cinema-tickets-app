import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import '../../domain/usecases/silent_login.dart';
part 'silent_login_state.dart';
part 'silent_login_event.dart';


class SilentLoginBloc extends Bloc<SilentLoginEvent, SilentLoginState>{
  final SilentLogin silentLogin;

  SilentLoginBloc({required this.silentLogin}):super(SilentLoginInitial());

  @override
  Stream<SilentLoginState> mapEventToState(SilentLoginEvent event) async*{
    if(event is SilentLoginInitiateEvent){
      print('in bloc before login');
      final Either<AppError, bool> eitherResponse = await silentLogin();
      print('in bloc after login');
      yield eitherResponse.fold((l){
        var message = l.appErrorType.toString();
        print(message);
        return SilentLoginError(message);
      }, (r) => SilentLoginSuccess());
    }else{
      print('it is not initial');
    }
  }
}