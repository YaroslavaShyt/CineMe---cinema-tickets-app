import 'package:cine_me/features/films/data/models/is_success_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cine_me/features/films/data/models/film_comment_model.dart';
import 'package:cine_me/features/films/domain/usecases/add_comment.dart';
import 'package:cine_me/features/films/domain/usecases/delete_comment.dart';
import 'package:cine_me/features/films/domain/usecases/get_comments.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final Comments comments;
  final CommentAdded commentAdded;
  final CommentDeleted commentDeleted;

  CommentsBloc({
    required this.commentAdded,
    required this.commentDeleted,
    required this.comments,
  }) : super(CommentsInitial());

  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {
    if (event is CommentsInitiateEvent) {
      final response = await comments(event.localization, event.filmId);
      yield response.fold(
          (l) => CommentsError(l.appErrorType), (r) => CommentsSuccess(r));
    } else if (event is AddCommentInitiateEvent) {
      final response = await commentAdded(
          event.comment, event.filmId, event.localization, event.rating);
      yield response.fold(
          (l) => AddCommentError(l.appErrorType), (r) => AddCommentSuccess(r));
    } else if (event is CommentDeleteInitiateEvent) {
      final response =
          await commentDeleted(event.commentId, event.localization);
      yield response.fold((l) => CommentsError(l.appErrorType),
          (r) => CommentDeletedSuccess(r));
    }
  }
}
