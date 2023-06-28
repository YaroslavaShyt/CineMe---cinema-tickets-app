import 'package:dartz/dartz.dart';
import 'package:cine_me/features/films/domain/usecases/usecase.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';
import 'package:cine_me/features/films/data/models/is_success_model.dart';

class BoughtTicket implements UseCaseTicketBought<IsSuccess> {
  final FilmsRepository _filmsRepository;

  BoughtTicket(this._filmsRepository);

  @override
  Future<Either<AppError, IsSuccess>> call({
    int sessionId = 0,
    List<int> seats = const [0],
    String email = '',
    String cvv = '',
    String cardNumber = '',
    String expirationDate = '',
  }) async =>
      _filmsRepository.getIsPaymentSuccess(
          sessionId, seats, email, cvv, cardNumber, expirationDate);
}
