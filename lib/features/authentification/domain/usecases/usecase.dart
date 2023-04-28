import 'package:dartz/dartz.dart';
import '../entities/app_error_entity.dart';

abstract class UseCase<Type> {
  Future<Either<AppError, Type>> call();
}