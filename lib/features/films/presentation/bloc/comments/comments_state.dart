part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class CommentsSuccess extends CommentsState {
  final List<FilmCommentModel> comments;

  const CommentsSuccess(this.comments);

  @override
  List<Object> get props => [comments];
}


class CommentDeletedSuccess extends CommentsState {
  final IsSuccess isSuccess;

  const CommentDeletedSuccess(this.isSuccess);

  @override
  List<Object> get props => [isSuccess];
}

class CommentsError extends CommentsState {
  final String message;

  const CommentsError(this.message);

  @override
  List<Object> get props => [message];
}

class AddCommentInitial extends CommentsState {}

class AddCommentSuccess extends CommentsState {
  final IsSuccess isSuccess;

  const AddCommentSuccess(this.isSuccess);

  @override
  List<Object> get props => [isSuccess];
}

class AddCommentError extends CommentsState {
  final String message;

  const AddCommentError(this.message);

  @override
  List<Object> get props => [message];
}