import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/theme.dart';
class RatingRow extends StatelessWidget {
  final String rating;
  final VoidCallback onPressed;
  const RatingRow({Key? key, required this.rating, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$rating/10',
              style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.w600,
                color:  Provider.of<ThemeProvider>(context).getTheme == light
                    ? const Color.fromRGBO(73, 71, 157, 10)
                    : const Color.fromRGBO(236, 237, 246, 10),),),
             Text('IMDb',
              style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Provider.of<ThemeProvider>(context).getTheme == light
                    ? const Color.fromRGBO(73, 71, 157, 10)
                    : const Color.fromRGBO(236, 237, 246, 10)),)
          ],
        ),
        IconButton(onPressed: onPressed, icon: const Icon(Icons.share))
      ],
    );
  }
}
