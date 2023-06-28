import 'package:cine_me/core/get_it/get_it.dart';
import 'package:cine_me/core/widgets/app_title.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/account/presentation/bloc/account_bloc.dart';
import 'package:cine_me/features/account/presentation/widgets/account_app_bar.dart';
import 'package:cine_me/features/account/presentation/widgets/account_page_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/theme.dart';
import '../../../films/presentation/bloc/films/films_bloc.dart';
import '../../../films/presentation/bloc/films_search_bloc/films_search_bloc.dart';
import '../../../films/presentation/widgets/films_page_widgets/drawer/drawer.dart';

class AccountPage extends StatefulWidget {
  final String detailsPath;
  const AccountPage({Key? key, required this.detailsPath}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late AccountBloc accountBloc;

  @override
  void initState() {
    super.initState();
    accountBloc = getItInst<AccountBloc>(
        param1: {'name': '', 'phoneNumber': ''}, param2: '');
    accountBloc.add(const AccountInitiateEvent());
  }

  @override
  void dispose() {
    accountBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => accountBloc)],
        child: Scaffold(
          drawer: CustomDrawer(
            function: (locale) {
              context
                  .read<FilmsBloc>()
                  .add(FilmsInitiateEvent(localization: locale));
              context
                  .read<FilmsSearchBloc>()
                  .add(FilmsSearchInitiateEvent(localization: locale));
              context
                  .read<AccountBloc>()
                  .add(AccountInitiateEvent(localization: locale));
            },
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                const AccountAppbar(
                  widget: AppTitle(),
                ),
                BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
                  if (state is AccountError) {
                    return const ErrorPage();
                  } else if (state is AccountSuccess) {
                    final tickets = state.ticketsResponse.map((value) => value);
                    final ticketsList = tickets.getOrElse(() => []);
                    return Positioned(
                      top: 100,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (ticketsList.isNotEmpty)
                              SizedBox(
                                width: MediaQuery.of(context).size.width, // Set a specific width
                                height: 600, // Set a fixed height
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (var i = ticketsList.length - 1; i >= 0; i--)
                                      TicketCard(
                                        id: ticketsList[i].id,
                                        date: ticketsList[i].date,
                                        image: ticketsList[i].image,
                                        title: ticketsList[i].name,
                                      ),
                                  ],
                                ),
                              )
                            else if (ticketsList.isEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 200,
                                  ),
                                  Text(
                                    "no tickets".tr().toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Provider.of<ThemeProvider>(context).getTheme == light
                                          ? const Color.fromRGBO(73, 71, 157, 10)
                                          : const Color.fromRGBO(236, 237, 246, 10),
                                    ),
                                  ),
                                  Text(
                                    "go to poster".tr().toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Provider.of<ThemeProvider>(context).getTheme == light
                                          ? const Color.fromRGBO(73, 71, 157, 10)
                                          : const Color.fromRGBO(236, 237, 246, 10),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
              ],
            ),
          ),
        ));
  }
}
