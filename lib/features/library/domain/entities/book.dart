
class Book{
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImageUrl;
  final String category;
  final int publishedYear;
  final bool isFavorite;
  final bool isRead;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImageUrl,
    required this.category,
    required this.publishedYear,
    required this.isFavorite,
    required this.isRead
  });

}