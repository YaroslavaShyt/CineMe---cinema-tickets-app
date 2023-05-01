class FilmSessionModel{
  final String id;
  final String date;
  final String type;
  final String minPrice;
  final Map<String, dynamic> room;

  FilmSessionModel({
    required this.id,
    required this.date,
    required this.type,
    required this.minPrice,
    this.room = const {}
});
}