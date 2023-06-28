import 'package:cine_me/core/get_it/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/buy_ticket/buy_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/dialog.dart';
import 'package:cine_me/features/films/presentation/widgets/film_buy_ticket_widgets/form_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
  late BuyTicketBloc buyTicketBloc;

  @override
  void initState() {
    super.initState();
    buyTicketBloc = getItInst<BuyTicketBloc>(param1: context, param2: 'en');
  }

  @override
  void dispose() {
    buyTicketBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => buyTicketBloc)],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(73, 71, 167, 100),
            shadowColor: Colors.transparent,
          ),
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
                              body: "no film".tr().toString(),
                              success: "operation error".tr().toString(),
                              buttonText: "sad".tr().toString());
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
                    totalToPay: widget.totalToPay,
                    seats: widget.seats,
                  sessionId: widget.sessionId,
                );}
              )
        ));
  }
}
