import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/buy_ticket/buy_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyTicketPage extends StatefulWidget {
  final int totalToPay;
  final String detailsPath;
  final int sessionId;
  final List<int> seats;

  const BuyTicketPage(
      {Key? key,
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
    print(
        'in page: ${widget.sessionId} ${widget.seats} ${widget.totalToPay} ${widget.detailsPath}');
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => buyTicketBloc)],
        child: Scaffold(
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
                                    Beamer.of(context)
                                        .beamToNamed('/account');
                                  })
                            ]);
                      });
                }
                return SafeArea(
                    child: Column(children: [
                  Text('sessionId: ${widget.sessionId}'),
                  Text('seats: ${widget.seats}'),
                  Text('Всього до оплати: ${widget.totalToPay}'),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email', fillColor: white),
                    controller: _emailController,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Номер картки'),
                    controller: _cardNumberController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Дійсна до'),
                    controller: _expirationDate,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'CVV'),
                    controller: _cvvController,
                  ),
                  CustomButton(
                      text: 'Оплатити',
                      onPressed: () {
                        buyTicketBloc.add(BuyTicketInitiateEvent(
                            seats: widget.seats,
                            sessionId: widget.sessionId,
                            email: _emailController.text,
                            cardNumber: _cardNumberController.text,
                            expireDate: _expirationDate.text,
                            cvv: _cvvController.text));
                      }),
                ]));
              }),
        ));
  }
}
