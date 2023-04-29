import 'package:dartz/dartz.dart';
import '../../features/authentification/domain/entities/app_error_entity.dart';

abstract class UseCase<Type> {
  Future<Either<AppError, Type>> call();
}