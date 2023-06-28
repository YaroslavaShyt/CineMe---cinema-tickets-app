import 'package:cine_me/core/constants/font_styling.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';

import '../../../../core/constants/theme.dart';
import '../../../../core/usecases/date_formatting.dart';
import 'package:provider/provider.dart';

class AccountPageHead extends StatelessWidget {
  final String username;
  final String phoneNumber;
  final VoidCallback onPressed;
  final VoidCallback onPressed2;
  const AccountPageHead(
      {Key? key,
        required this.onPressed2,
      required this.onPressed,
      required this.phoneNumber,
      required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Padding(padding: const EdgeInsets.only(left: 10), child:
        Row(children: [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: notoSansDisplayBoldSmall,
            ),
            Text(
              phoneNumber,
              style: notoSansDisplayRegularTiny,
            ),
          ],
        ),
        IconButton(onPressed: onPressed, icon: const Icon(Icons.edit, color: white, size: 20,))])),
      ],
    );
  }
}


class TicketCard extends StatelessWidget {
  final int id;
  final String image;
  final String title;
  final int date;

  const TicketCard(
      {Key? key,
        required this.id,
        required this.date,
        required this.image,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Provider.of<ThemeProvider>(context).getTheme == light
                  ? Colors.black54
                  : const Color.fromRGBO(236, 237, 246, 10),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            height: 500,
            width: 300,
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.fromLTRB(5, 5, 5, 5), child:
             Image(image: NetworkImage(image),)),
              Container(
                  color:  const Color.fromRGBO(73, 71, 157, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              formatUnixTime(date.toString()),
                              style: notoSansDisplayRegularTiny),
                          Text(
                            formatUnixDate(date.toString()),
                            style: notoSansDisplayBoldLarge,
                          ),
                        ],
                      ),
                      Text(title, style: notoSansDisplayBoldTiny,)
              ],)),
                const SizedBox(height: 10,),
                QRCodeWidget(data: id.toString())
            ],)));
  }
}

class QRCodeWidget extends StatelessWidget {
  final String data;

  const QRCodeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: white,
        width: 200,
        height: 70,
        child: BarcodeWidget(
          barcode: Barcode.code93(),
          data: data,
          width: 100,
          height: 50,
        ),
    );
  }
}
