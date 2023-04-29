import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/films_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/films_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';


class FilmsPage extends StatefulWidget {
  final String detailsPath;
  const FilmsPage({Key? key, required this.detailsPath}) : super(key: key);

  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  late FilmsBloc filmsBloc;
  TextEditingController controller = TextEditingController();
  List<String> images = [
    'http://images2.fanpop.com/images/photos/8400000/Movie-Posters-movies-8405245-1224-1773.jpg',
    'http://www.graphicdesignjunction.com/wp-content/uploads/2013/03/large/Olympus+Has+Fallen+movie+posters.jpg',
    'https://larryfire.files.wordpress.com/2017/10/39.jpg',
    'http://www.filmeducation.org/startrek/images/posters/main.jpg'
  ];
  int activePage = 1;
  @override
  void initState() {
    super.initState();
    filmsBloc = getItInst<FilmsBloc>();
    filmsBloc.add(const FilmsInitiateEvent());
  }

  @override
  void dispose() {
    super.dispose();
    filmsBloc.close();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => filmsBloc)],
        child: Scaffold(
            appBar: const FilmsAppBar(),
            body: BlocConsumer<FilmsBloc, FilmsState>(
                listener: (context, state) {},
              builder: (context, state) {
                if (state is FilmsError) {
                  return const Text('error');
                }
                else if (state is FilmsSuccess){
                  final films = state.films;
                  if (films.isEmpty){
                    return Text('Отакої, виникла помилка!');
                  }
                  return Column(children: [
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('29 квітня'),
                      Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Text('Посмiхаємося i махаємо, хлопцi,\nпосмiхаємося i махаємо…\n«Мадагаскар»',
                                softWrap: true,
                                maxLines: 3,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    ))
                      )]),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Сьогодні на екранах', style: TextStyle(color: white),),
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 500,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          pauseAutoPlayOnTouch: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 3000)),
                      items: films.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: MySliderItem(filmModel: image, detailsPath: widget.detailsPath),
                            );
                          },
                        );
                      }).toList(),
                    )
                  ]);
              }
                return const CircularProgressIndicator();
                },
            ),
        backgroundColor: lightBlack,
        ));
  }
}
