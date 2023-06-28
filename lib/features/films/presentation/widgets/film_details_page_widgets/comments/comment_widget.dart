import 'package:cine_me/features/films/data/models/film_comment_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/theme.dart';

class CommentWidget extends StatelessWidget {
  final filmId;
  final onPressed;
  final FilmCommentModel filmCommentModel;
  const CommentWidget({super.key, required this.filmCommentModel, required this.filmId, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.person,
        color: filmCommentModel.isMy
            ? Provider.of<ThemeProvider>(context).getTheme == light
                ? const Color.fromRGBO(73, 71, 157, 10)
                : const Color.fromRGBO(236, 237, 246, 10)
            : Colors.grey,
      ),
      title: Text(filmCommentModel.author ?? 'Anonymous',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Provider.of<ThemeProvider>(context).getTheme == light
                ? const Color.fromRGBO(73, 71, 157, 10)
                : const Color.fromRGBO(236, 237, 246, 10),
          )),
      subtitle: Text(filmCommentModel.content ?? 'Like!'),
      trailing: SizedBox(
        width: 110,
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    filmCommentModel.rating ?? '5.0',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Provider.of<ThemeProvider>(context).getTheme == light
                          ? const Color.fromRGBO(73, 71, 157, 10)
                          : const Color.fromRGBO(236, 237, 246, 10),
                    ),
                  ),
                  Text(
                    "rating".tr().toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Provider.of<ThemeProvider>(context).getTheme == light
                          ? const Color.fromRGBO(73, 71, 157, 10)
                          : const Color.fromRGBO(236, 237, 246, 10),
                    ),
                  ),
                ],
              ),
            ),
            if(filmCommentModel.isMy)
              SizedBox(
                width: 20,
                  child: IconButton(
                      onPressed: onPressed,
                      icon: const Icon(FontAwesome.trash, size: 20,)
                  )
              )
          ],
        ),
      ),
    );
  }
}


