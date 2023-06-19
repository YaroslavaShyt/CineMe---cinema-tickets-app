import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/search_category_item.dart';
import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/search_film_tail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/theme.dart';
import '../../../data/models/film_model.dart';
import '../../../data/models/time_model.dart';

class CustomCard extends StatelessWidget {
  final FilmModel film;
  const CustomCard({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ]),
      child: SizedBox(
        height: 50,
        width: 70,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 170,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(film.smallImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
           SizedBox(
             height: 170,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                        child: Text(
                      film.name,
                          style: TextStyle(
                              color: Provider.of<ThemeProvider>(context).getTheme == light
                                  ? const Color.fromRGBO(73, 71, 157, 10)
                                  : const Color.fromRGBO(236, 237, 246, 10),
                              fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(children: [
                        const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.deepOrangeAccent,
                        ),
                        Text(
                          '${film.rating.toString()}/5 IMDb',
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).getTheme == light
                                ? const Color.fromRGBO(73, 71, 167, 100)
                                : const Color.fromRGBO(236, 237, 246, 10),
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                            HourMinute(time: film.duration).hourMinute,
                          style: TextStyle(
                              color: Provider.of<ThemeProvider>(context).getTheme == light
                                  ? const Color.fromRGBO(73, 71, 167, 100)
                                  : const Color.fromRGBO(236, 237, 246, 10),
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      width: 230,
                      child: Wrap(
                        children: [
                          for (var i in film.genre.split(','))
                            SearchCategoryItem(text: i)
                        ],
                      ),
                    ),
                  ],
                ),
           ),
          ],
        ),
      ),
    );
  }
}
