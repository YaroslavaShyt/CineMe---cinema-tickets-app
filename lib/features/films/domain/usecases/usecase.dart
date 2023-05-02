import 'package:cine_me/features/films/data/models/is_ticket_booked.dart';
import 'package:dartz/dartz.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';
import '../../data/models/film_model.dart';

abstract class UseCase<Type> {
  Future<Either<AppError, List>> call();
}

abstract class UseCaseTicketBooked<Type>{
  Future<Either<AppError, IsTicketBooked>> call();
}