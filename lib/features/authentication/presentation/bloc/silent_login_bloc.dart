import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/features/authentication/domain/usecases/silent_login.dart';
part 'silent_login_state.dart';
part 'silent_login_event.dart';


class SilentLoginBloc extends Bloc<SilentLoginEvent, SilentLoginState>{
  final SilentLogin silentLogin;

  SilentLoginBloc({required this.silentLogin}):super(SilentLoginInitial());

  @override
  Stream<SilentLoginState> mapEventToState(SilentLoginEvent event) async*{
    if(event is SilentLoginInitiateEvent){
      final Either<AppError, bool> eitherResponse = await silentLogin();
      yield eitherResponse.fold((l){
        var message = l.appErrorType.toString();
        return SilentLoginError(message);
      }, (r) => SilentLoginSuccess());
    }
  }
}