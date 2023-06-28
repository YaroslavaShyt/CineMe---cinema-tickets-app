import 'package:cine_me/features/films/presentation/bloc/buy_ticket/buy_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/film_session_page_widgets/session_details_widgets.dart';
import 'package:cine_me/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masked_text/masked_text.dart';
import 'package:provider/provider.dart';
import 'package:cine_me/core/constants/theme.dart';

class PaymentForm extends StatefulWidget {
  final int sessionId;
  final List<int> seats;
  final String filmName;
  final String date;
  final String cinemaName;
  final String type;
  final int totalToPay;

  const PaymentForm({
    Key? key,
    required this.seats,
    required this.sessionId,
    required this.filmName,
    required this.type,
    required this.cinemaName,
    required this.date,
    required this.totalToPay,
  }) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDate = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _cvvController.dispose();
    _cardNumberController.dispose();
    _expirationDate.dispose();
    super.dispose();
  }

  void onPressed(String cardNumber, String cvv, String email, String expireDate) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<BuyTicketBloc>().add(
        BuyTicketInitiateEvent(
          sessionId: widget.sessionId,
          seats: widget.seats,
          cardNumber: cardNumber.split(' ').join(),
          cvv: cvv,
          email: email,
          expireDate: expireDate,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 16),
            Text(
              widget.filmName,
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).getTheme == light
                    ? const Color.fromRGBO(73, 71, 157, 10)
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16),
            SessionDetailsHead(
              date: widget.date,
              name: widget.cinemaName,
              type: widget.type,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                style: const TextStyle(fontSize: 12),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Provider.of<ThemeProvider>(context).getTheme == light
                            ? const Color.fromRGBO(73, 71, 157, 10)
                            : Colors.white,
                    ),
                  ),
                ),
                controller: _emailController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MaskedTextField(
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  labelText: "card number".tr().toString(),
                  labelStyle: const TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Provider.of<ThemeProvider>(context).getTheme == light
                            ? const Color.fromRGBO(73, 71, 157, 10)
                            : Colors.white,
                    ),
                  ),
                ),
                mask: "#### #### #### ####",
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Card number is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MaskedTextField(
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  labelText: "expire".tr().toString(),
                  labelStyle: const TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Provider.of<ThemeProvider>(context).getTheme == light
                            ? const Color.fromRGBO(73, 71, 157, 10)
                            : Colors.white,
                    ),
                  ),
                ),
                mask: "##/##",
                controller: _expirationDate,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Expiration date is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MaskedTextField(
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  labelText: 'CVV',
                  labelStyle: const TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Provider.of<ThemeProvider>(context).getTheme == light
                            ? const Color.fromRGBO(73, 71, 157, 10)
                            : Colors.white,
                    ),
                  ),
                ),
                mask: "###",
                controller: _cvvController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'CVV is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${"to pay".tr().toString()}: ${widget.totalToPay} ${"money".tr().toString()}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Provider.of<ThemeProvider>(context).getTheme == light
                    ? const Color.fromRGBO(73, 71, 157, 10)
                    : Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: "pay".tr().toString(),
                onPressed: () {
                  onPressed(
                    _cardNumberController.text,
                    _cvvController.text,
                    _emailController.text,
                    _expirationDate.text,
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}
