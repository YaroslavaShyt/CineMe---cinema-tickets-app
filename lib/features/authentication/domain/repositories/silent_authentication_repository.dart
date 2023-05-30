import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';

abstract class AuthenticationRepository{
  Future<Either<AppError, bool>> loginUser();
  Future<Either<AppError, bool>> checkUserExists();
}