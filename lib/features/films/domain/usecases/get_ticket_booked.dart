import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/models/is_success_model.dart';
import 'package:cine_me/features/films/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';

class BookedTicket extends UseCaseTicketBooked<Type>{

  final FilmsRepository _filmsRepository;

  BookedTicket(this._filmsRepository);
  @override
  Future<Either<AppError, IsSuccess>> call({
    int sessionId = 0,
    List<int> seats = const []
  }) async => _filmsRepository.getIsTicketBooked(sessionId, seats);
}