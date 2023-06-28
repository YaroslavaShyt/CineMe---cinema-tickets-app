import 'package:carousel_slider/carousel_slider.dart';
import 'package:cine_me/core/usecases/date_formatting.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/presentation/widgets/film_session_page_widgets/slider_element.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class Carousel extends StatefulWidget {
  final List<FilmSessionModel> filmSessionModels;
  final Function(int index) onRocketChanged;

  const Carousel({Key? key, required this.filmSessionModels, required this.onRocketChanged})
      : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 100.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.4,
            initialPage: currentPage,
            onPageChanged: (index, reason) {
              widget.onRocketChanged(index);
              setState(() {
                currentPage = index;
              });
            },
          ),
          items: widget.filmSessionModels.map<Widget>((i) => Builder(
            builder: (BuildContext context) {
              return SliderElement(
                  date: formatUnixDate(i.date),
                  time: formatUnixTime(i.date),
                  day: formatUnixWeekDay(i.date, locale:  context.locale.languageCode == 'uk' && context.locale.countryCode == 'UA'? 'uk' : 'en')
              );
            },
          )).toList(),
        ),
      ],
    );
  }
}