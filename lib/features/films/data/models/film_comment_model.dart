class FilmCommentModel {
  final String? id;
  final String? author;
  final String? content;
  final String? rating;
  final bool isMy;

  const FilmCommentModel(
      {
        required this.isMy,
        required this.id,
      required this.rating,
      required this.content,
      required this.author});

  factory FilmCommentModel.fromJson(Map<String, dynamic> json) {
    final id = json["id"].toString();
    final author = json["author"];
    final content = json["content"];
    final rating = json["rating"].toString();
    final isMy = json["isMy"];
    return FilmCommentModel(
        id: id, rating: rating, content: content, author: author, isMy: isMy);
  }
}
