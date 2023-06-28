import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/films/presentation/bloc/comments/comments_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/get_it/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/films/films_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/film_details_widget.dart';
import 'package:provider/provider.dart';
import 'package:cine_me/core/constants/theme.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/comments/film_comments.dart';

class FilmDetails extends StatefulWidget {
  final String filmName;
  final String detailsPath;
  const FilmDetails(
      {Key? key, required this.filmName, required this.detailsPath})
      : super(key: key);

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> with SingleTickerProviderStateMixin {
  late FilmsBloc filmsBloc;
  late CommentsBloc commentsBloc;
  late YoutubePlayerController controller;
  late TabController _tabController;
  String localization = 'en';
  late List<FilmModel> films;

  void playVideo(String videoUrl) {
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
        flags: const YoutubePlayerFlags(autoPlay: false, enableCaption: false)
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    filmsBloc = getItInst<FilmsBloc>(param1: '', param2: widget.filmName);
    commentsBloc = getItInst<CommentsBloc>();
    films = [];
    _tabController.addListener(_handleTabChange);
  }

  @override
  void didChangeDependencies() {
    localization = context.locale.languageCode == 'uk' &&
        context.locale.countryCode == 'UA'
        ? 'uk'
        : 'en';
    filmsBloc.add(FilmsInitiateEvent(
        search: widget.filmName, localization: localization));

    super.didChangeDependencies();
  }

  void _handleTabChange() {
    if (_tabController.index == 1) {
      if (films.isNotEmpty) {
        commentsBloc.add(CommentsInitiateEvent(localization: localization, filmId: films[0].id.toString()));
      }
    }
  }

  @override
  void dispose() {
    filmsBloc.close();
    commentsBloc.close();
    controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => filmsBloc),
          BlocProvider(create: (context) => commentsBloc),
        ],
        child: Scaffold(
            body: BlocConsumer<FilmsBloc, FilmsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is FilmsError) {
                    return const ErrorPage();
                  } else if (state is FilmsSuccess) {
                    films = state.films;
                    if (films.isEmpty) {
                      return const ErrorPage();
                    }
                    playVideo(films[0].trailer);
                    return DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            indicatorColor: Provider.of<ThemeProvider>(context).getTheme == light
                                ? const Color.fromRGBO(73, 71, 167, 100)
                                : const Color.fromRGBO(236, 237, 246, 10),
                            labelColor: Colors.black,
                            tabs: [
                              Tab(
                                child: Text(
                                  "about".tr().toString(),
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).getTheme == light
                                        ? Colors.black
                                        : Colors.white
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "reviews".tr().toString(),
                                   style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).getTheme == light
                                        ? Colors.black
                                        : Colors.white
                                ),
                              ),),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                YoutubePlayerBuilder(
                                  player: YoutubePlayer(
                                    controller: controller,
                                  ),
                                  builder: (context, player) {
                                    return FilmDetailsWidget(
                                      controller: controller,
                                      films: films,
                                      detailsPath: widget.detailsPath,
                                      player: player,
                                    );
                                  },
                                ),
                                FilmComments(
                                  filmId: films[0].id.toString(),
                                  onDelete: (String commentId) {
                                    commentsBloc.add(CommentDeleteInitiateEvent(commentId: commentId));
                                  },),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(color: white),
                  );
                }
            )
        )
    );
  }
}
