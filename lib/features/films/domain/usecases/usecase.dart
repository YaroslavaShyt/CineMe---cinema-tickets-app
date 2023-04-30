import 'package:dartz/dartz.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';
import '../../data/models/film_model.dart';

abstract class UseCase<Type> {
  Future<Either<AppError, List>> call();
}