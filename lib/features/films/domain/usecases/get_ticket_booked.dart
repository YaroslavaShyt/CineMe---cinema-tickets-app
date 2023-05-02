import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/models/is_ticket_booked.dart';
import 'package:cine_me/features/films/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repository/films_repository.dart';

class BookedTicket extends UseCaseTicketBooked<Type>{

  final FilmsRepository _filmsRepository;

  BookedTicket(this._filmsRepository);
  @override
  Future<Either<AppError, IsTicketBooked>> call({int sessionId = 0, List<int> seats = const []}) async {
    print('in bookedTicket $sessionId, $seats');
    return _filmsRepository.getIsTicketBooked(sessionId, seats);
  }

}