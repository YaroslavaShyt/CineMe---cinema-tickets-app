import 'package:cine_me/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/authentification/domain/repositories/silent_authentication_repository.dart';


class SilentLogin extends UseCase<bool>{
  final AuthenticationRepository _authenticationRepository;

  SilentLogin(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call() async =>
      _authenticationRepository.loginUser();
}