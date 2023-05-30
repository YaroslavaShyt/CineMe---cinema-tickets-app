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

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    final int id = json['id'];
    final String name = json['name'];
    final int allowedAge = json['age'];
    final String trailer = json['trailer'];
    final String image = json['image'];
    final String smallImage = json['smallImage'];
    final String originalName = json['originalName'];
    final int duration = json['duration'];
    final String language = json['language'];
    final String rating = json['rating'];
    final int year = json['year'];
    final String country = json['country'];
    final String genre = json['genre'];
    final String plot = json['plot'];
    final String starring = json['starring'];
    final String director = json['director'];
    final String screenwriter = json['screenwriter'];
    final String studio = json['studio'];
    return FilmModel(
      id: id,
      name: name,
      image: image,
      allowedAge: allowedAge,
      trailer: trailer,
      smallImage: smallImage,
      originalName: originalName,
      duration: duration,
      language: language,
      rating: rating,
      year: year,
      country: country,
      genre: genre,
      plot: plot,
      starring: starring,
      director: director,
      screenwriter: screenwriter,
      studio: studio
    );
  }
}

