import 'package:carousel_slider/carousel_slider.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';

class FilmsSlider extends StatelessWidget {
  final String detailsPath;
  final List<FilmModel> films;
  const FilmsSlider({Key? key, required this.detailsPath, required this.films})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 650,
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          pauseAutoPlayOnTouch: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 3000)),
      items: films.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: MySliderItem(
                filmModel: image,
                detailsPath: detailsPath,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
