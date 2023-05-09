import 'package:dartz/dartz.dart';
import 'package:cine_me/core/entities/app_error_entity.dart';

abstract class UseCase<Type> {
  Future<Either<AppError, Type>> call();
}