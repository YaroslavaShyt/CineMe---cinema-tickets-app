import 'package:cine_me/features/account/data/models/ticket_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/account/data/models/user_model.dart';

abstract class UseCaseAccount<Type>{
  Future<Either<AppError, UserModel>> call();
}

abstract class UseCaseTickets<Type>{
  Future<Either<AppError, List<TicketModel>>> call();
}