import 'package:dartz/dartz.dart';
import 'package:cine_me/features/films/domain/usecases/usecase.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';
import '../../data/models/film_model.dart';
import '../../data/models/is_payment_success_model.dart';
import '../repository/films_repository.dart';

class BoughtTicket implements UseCaseTicketBought<IsPaymentSuccess>{
  final FilmsRepository _filmsRepository;

  BoughtTicket(this._filmsRepository);

  @override
  Future<Either<AppError, IsPaymentSuccess>>
  call({int sessionId=0, List<int> seats=const [0],
    String email='', String cvv='',
    String cardNumber='', String expirationDate='',
  }) async =>
      _filmsRepository.getIsPaymentSuccess(sessionId, seats, email, cvv, cardNumber, expirationDate);
}