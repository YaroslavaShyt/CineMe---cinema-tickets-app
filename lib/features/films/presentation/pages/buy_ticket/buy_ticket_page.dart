import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/buy_ticket/buy_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/text_field_widget.dart';
import 'package:cine_me/features/films/presentation/widgets/transparent_button.dart';
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
    buyTicketBloc = getItInst<BuyTicketBloc>();
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
                  return const Text('error');
                } else if (state is BuyTicketSuccess) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Операція: ${state.result.success}'),
                            content: Text('data ${state.result.data}'),
                            actions: [
                              TextButton(
                                  child: const Text("У кабінет"),
                                  onPressed: () {
                                    Beamer.of(context).beamToNamed('/account');
                                  })
                            ]);
                      });
                }
                return SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                      Text(
                        'sessionId: ${widget.filmName}',
                        style: notoSansDisplayBoldSmall,
                      ),
                          Text(
                            'sessionId: ${widget.type}',
                            style: notoSansDisplayBoldSmall,
                          ),
                          Text(
                            'sessionId: ${widget.date}',
                            style: notoSansDisplayBoldSmall,
                          ),
                      Text(
                        'seats: ${widget.cinemaName}',
                        style: notoSansDisplayBoldSmall,
                      ),
                      CustomTextField(
                          controller: _emailController, title: 'Email'),
                      CustomTextField(
                          controller: _cardNumberController,
                          title: 'Номер картки'),
                      CustomTextField(
                          controller: _expirationDate, title: 'Дійсна до'),
                      CustomTextField(controller: _cvvController, title: 'CVV'),
                      Text(
                        'Всього до оплати: ${widget.totalToPay} грн',
                        style: notoSansDisplayBoldSmall,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CustomButton(
                              text: 'Оплатити',
                              onPressed: () {
                                buyTicketBloc.add(BuyTicketInitiateEvent(
                                    seats: widget.seats,
                                    sessionId: widget.sessionId,
                                    email: _emailController.text,
                                    cardNumber: _cardNumberController.text,
                                    expireDate: _expirationDate.text,
                                    cvv: _cvvController.text));
                              })),
                    ]));
              }),
        ));
  }
}
