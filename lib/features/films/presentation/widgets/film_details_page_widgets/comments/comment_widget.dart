import 'package:cine_me/features/films/data/models/film_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/theme.dart';

class CommentWidget extends StatelessWidget {
  final FilmCommentModel filmCommentModel;
  const CommentWidget({super.key, required this.filmCommentModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.person, color: filmCommentModel.isMy
            ? Provider.of<ThemeProvider>(context).getTheme == light
            ? const Color.fromRGBO(73, 71, 157, 10)
            : const Color.fromRGBO(236, 237, 246, 10)
            : Colors.grey,),
      title: Text(filmCommentModel.author ?? 'Anonymous'),
      subtitle: Text(filmCommentModel.content ?? 'Like!'),
      trailing: IconButton(icon: const Icon(Icons.thumb_up_alt_rounded), onPressed: (){},),
    );
  }
}
