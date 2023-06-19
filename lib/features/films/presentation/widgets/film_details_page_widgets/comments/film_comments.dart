import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/comments/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/get_comments/comments_bloc.dart';

class FilmComments extends StatefulWidget {
  const FilmComments({Key? key}) : super(key: key);

  @override
  State<FilmComments> createState() => _FilmCommentsState();
}

class _FilmCommentsState extends State<FilmComments> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {
        // Опрацьовуйте стан, якщо необхідно
      },
      builder: (context, state) {
        if (state is CommentsInitial) {
          return const CircularProgressIndicator();
        } else if (state is CommentsSuccess) {
          final comments = state.comments;

          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return CommentWidget(filmCommentModel: comments[index]);
            },
          );
        } else if (state is CommentsError) {
          return Text('Error: ${state.message}');
        }
        return const SizedBox.shrink();
      },
    );
  }
}
