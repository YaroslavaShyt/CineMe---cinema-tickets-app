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

  factory FilmSessionModel.fromJson(Map<String, dynamic> json) {
    final String id = json['id'].toString();
    final String date = json['date'].toString();
    final String type = json['type'];
    final String minPrice = json['minPrice'].toString();
    final Map<String, dynamic> room = json['room'];
    return FilmSessionModel(
        id: id,
        date: date,
        type: type,
        minPrice: minPrice,
        room: room
    );
  }
}