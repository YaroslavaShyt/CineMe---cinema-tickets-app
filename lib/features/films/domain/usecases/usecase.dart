import 'package:cine_me/features/films/data/models/is_payment_success_model.dart';
import 'package:cine_me/features/films/data/models/is_ticket_booked.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';

abstract class UseCase<Type> {
  Future<Either<AppError, List>> call();
}

abstract class UseCaseTicketBooked<Type>{
  Future<Either<AppError, IsTicketBooked>> call();
}

abstract class UseCaseTicketBought<Type>{
  Future<Either<AppError, IsPaymentSuccess>> call();
}