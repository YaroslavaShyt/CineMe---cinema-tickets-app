import 'package:cine_me/features/account/domain/repository/account_repository.dart';
import 'package:cine_me/features/account/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';
import '../../data/models/ticket_model.dart';

class Tickets implements UseCaseTickets{
  final AccountRepository _accountRepository;

  Tickets(this._accountRepository);

  @override
  Future<Either<AppError, List<TicketModel>>> call() async=>
      _accountRepository.getUserTickets();
}