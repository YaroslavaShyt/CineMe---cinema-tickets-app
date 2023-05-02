import 'package:cine_me/features/account/data/models/ticket_model.dart';
import 'package:cine_me/features/account/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';

abstract class AccountRepository{
  Future<Either<AppError, UserModel>>
  getAccountData({Map<String, dynamic> newUserData=const {'name': '', 'phoneNumber': ''}});
  Future<Either<AppError, List<TicketModel>>>
  getUserTickets();
}