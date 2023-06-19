import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/film_comment_model.dart';
import '../../../domain/usecases/get_comments.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent,CommentsState>{
  final Comments comments;


  CommentsBloc({
    required this.comments,
  }) : super(CommentsInitial());


  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async*{
    if(event is CommentsInitiateEvent){
      print('bloc initiate');
      final response = await comments(event.localization, event.filmId);
      yield response.fold(
              (l) => CommentsError(l.appErrorType),
              (r)=> CommentsSuccess(r));
    }
  }

}