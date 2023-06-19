import 'package:cine_me/features/films/data/models/is_success_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';

abstract class UseCase<Type> {
  Future<Either<AppError, List>> call();
}

abstract class UseCaseTicketBooked<Type>{
  Future<Either<AppError, IsSuccess>> call();
}

abstract class UseCaseTicketBought<Type>{
  Future<Either<AppError, IsSuccess>> call();
}

abstract class UseCaseFilmComment<Type>{
  Future<Either<AppError, Type>> call(String localization, String filmId);
}