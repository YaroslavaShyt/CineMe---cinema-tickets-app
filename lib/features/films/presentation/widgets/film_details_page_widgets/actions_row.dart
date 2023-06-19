import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed:  () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
        PopupMenuButton(
            color: Colors.white,
            itemBuilder: (BuildContext context){
          return {'item 1', 'item2'}.map((String choice){
            return PopupMenuItem(child: Text(choice));
          }).toList();
        })
      ],
    );
  }
}
