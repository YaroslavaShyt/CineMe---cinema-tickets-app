class TicketModel{
  final int id;
  final int movieId;
  final String name;
  final int date;
  final String image;
  final String smallImage;

  const TicketModel({
    required this.id,
    required this.name,
    required this.movieId,
    required this.date,
    required this.image,
    required this.smallImage});
}