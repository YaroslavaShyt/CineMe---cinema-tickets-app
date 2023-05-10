import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/account/presentation/widgets/account_location.dart';
import 'package:cine_me/features/films/presentation/bloc/buy_ticket/buy_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/dialog.dart';
import 'package:cine_me/features/films/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyTicketPage extends StatefulWidget {
  final String filmName;
  final String date;
  final String cinemaName;
  final String type;
  final int totalToPay;
  final String detailsPath;
  final int sessionId;
  final List<int> seats;

  const BuyTicketPage(
      {Key? key,
      required this.filmName,
      required this.type,
      required this.date,
      required this.cinemaName,
      required this.totalToPay,
      required this.detailsPath,
      required this.sessionId,
      required this.seats})
      : super(key: key);

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDate = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  late BuyTicketBloc buyTicketBloc;

  @override
  void initState() {
    super.initState();
    buyTicketBloc = getItInst<BuyTicketBloc>(param1: context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => buyTicketBloc)],
        child: Scaffold(
          backgroundColor: lightBlack,
          body: BlocConsumer<BuyTicketBloc, BuyTicketState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is BuyTicketError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              body: 'Кіна не буде :(',
                              success: 'Операція не успішна!',
                              buttonText: "Сумно");
                        });
                  });
                } else if (state is BuyTicketSuccess) {
                  buyTicketBloc.add(const BuyTicketSuccessEvent());
                }
                return PaymentForm(
                    filmName: widget.filmName,
                    type: widget.type,
                    cinemaName: widget.cinemaName,
                    date: widget.date,
                    emailController: _emailController,
                    totalToPay: widget.totalToPay,
                    onPressed: () {
                      if (_emailController.text.isEmpty ||
                          _cardNumberController.text.isEmpty ||
                          _cvvController.text.isEmpty ||
                          _expirationDate.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  body: '',
                                  success: 'Заповніть усі поля!',
                                  buttonText: "Добре");
                            });
                      } else {
                        buyTicketBloc.add(BuyTicketInitiateEvent(
                            seats: widget.seats,
                            sessionId: widget.sessionId,
                            email: _emailController.text,
                            cardNumber:
                                _cardNumberController.text.replaceAll(' ', ''),
                            expireDate: _expirationDate.text,
                            cvv: _cvvController.text));
                      }
                    },
                    expirationDate: _expirationDate,
                    cardNumberController: _cardNumberController,
                    cvvController: _cvvController);
              }),
        ));
  }
}
