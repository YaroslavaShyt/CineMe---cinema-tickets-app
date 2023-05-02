import 'package:flutter/material.dart';

class BuyTicketPage extends StatefulWidget {
  final String detailsPath;
  final int sessionId;
  final List<int> seats;

  const BuyTicketPage({Key? key,
    required this.detailsPath,
    required this.sessionId,
    required this.seats
  }) : super(key: key);

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDate = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
          TextFormField(
            controller: _emailController,
          ),
          TextFormField(
            controller: _cardNumberController,
          ),
          TextFormField(
            controller: _expirationDate,
          ),
          TextFormField(
            controller: _cvvController,
          ),
      ],),
    );
  }
}
