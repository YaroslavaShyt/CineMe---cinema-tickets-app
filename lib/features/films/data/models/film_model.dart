class FilmModel{
  final int id;
  final String name;
  final int allowedAge;
  final String trailer;
  final String image;
  final String smallImage;
  final String originalName;
  final int duration;
  final String language;
  final String rating;
  final int year;
  final String country;
  final String genre;
  final String plot;
  final String starring;
  final String director;
  final String screenwriter;
  final String studio;
  FilmModel({
    required this.id,
    required this.name,
    this.allowedAge = 0,
    this.trailer = '',
    required this.image,
    this.smallImage = '',
    this.originalName = '',
    this.duration = 0,
    this.language ='',
    this.rating = '',
    this.year = 2023,
    this.country = '',
    this.genre = '',
    this.plot = '',
    this.starring = '',
    this.director = '',
    this.screenwriter = '',
    this.studio = ''
  });
}

