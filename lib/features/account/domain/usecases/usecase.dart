import 'package:dartz/dartz.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';
import '../../data/models/user_model.dart';

abstract class UseCaseAccount<Type>{
  Future<Either<AppError, UserModel>> call();
}