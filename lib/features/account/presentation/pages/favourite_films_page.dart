import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/core/widgets/films_app_bar.dart';
import 'package:flutter/material.dart';

class FavouriteFilmsPage extends StatefulWidget {
  const FavouriteFilmsPage({Key? key}) : super(key: key);

  @override
  State<FavouriteFilmsPage> createState() => _FavouriteFilmsPageState();
}

class _FavouriteFilmsPageState extends State<FavouriteFilmsPage> {
  Color heartColor = red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FilmsAppBar(title: 'Улюблене',),
      body: ListView(
        children: [
          Row(children: [
            IconButton(onPressed: (){
              setState(() {
                heartColor == red ? heartColor = Colors.transparent : heartColor = red;
              });
            }, icon: Icon(Icons.favorite, color: heartColor,)),
            Text('favourite movie', style: notoSansDisplayRegularMedium,)])
        ],
      ),
    );
  }
}
