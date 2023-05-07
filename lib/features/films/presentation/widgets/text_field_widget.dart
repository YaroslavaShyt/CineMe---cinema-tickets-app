import 'package:cine_me/features/films/presentation/widgets/session_details_widgets.dart';
import 'package:cine_me/features/films/presentation/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:flutter/services.dart';
import 'package:masked_text/masked_text.dart';

class PaymentForm extends StatelessWidget {
  final String filmName;
  final String date;
  final String cinemaName;
  final String type;
  final TextEditingController emailController;
  final TextEditingController cvvController;
  final TextEditingController cardNumberController;
  final TextEditingController expirationDate;
  final int totalToPay;
  final VoidCallback onPressed;
  const PaymentForm({Key? key,
  required this.filmName,
    required this.type,
    required this.cinemaName,
    required this.date,
    required this.emailController,
    required this.totalToPay,
    required this.onPressed,
    required this.expirationDate,
    required this.cardNumberController,
    required this.cvvController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                filmName,
                style: notoSansDisplayBoldMedium,
              ),
              SessionDetailsHead(
                date: date,
                name: cinemaName,
                type: type,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                      style: notoSansDisplayRegularTiny,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: notoSansDisplayRegularTiny,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:white))
                      ),
                      controller: emailController,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaskedTextField(
                    style: notoSansDisplayRegularTiny,
                    decoration: const InputDecoration(
                        labelText: 'Номер картки',
                        labelStyle: notoSansDisplayRegularTiny,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:white))
                    ),
                    mask: "#### #### #### ####",
                    controller: cardNumberController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),],
                ),),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child:  MaskedTextField(
                    style: notoSansDisplayRegularTiny,
                    decoration: const InputDecoration(
                        labelText: 'Дійсна до',
                        labelStyle: notoSansDisplayRegularTiny,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:white))
                    ),
                    mask: "##/##",
                    controller: expirationDate,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),],
                ),),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child:  MaskedTextField(
                    style: notoSansDisplayRegularTiny,
                    decoration: const InputDecoration(
                        labelText: 'CVV',
                        labelStyle: notoSansDisplayRegularTiny,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:white))
                    ),
                    mask: "###",
                    controller: cvvController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),],
                ),),
              Text(
                'Всього до оплати: $totalToPay грн',
                style: notoSansDisplayBoldSmall,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: CustomButton(
                      text: 'Оплатити',
                      onPressed: onPressed)),
            ]));
  }
}
