import 'package:cine_me/features/authentification/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_error_entity.dart';
import '../repositories/silent_authentication_repository.dart';


class SilentLogin extends UseCase<bool>{
  final AuthenticationRepository _authenticationRepository;

  SilentLogin(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call() async =>
      _authenticationRepository.loginUser();
}