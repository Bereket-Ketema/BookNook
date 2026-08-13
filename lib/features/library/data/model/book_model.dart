import 'package:flutter_first/features/library/domain/entities/book.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImageUrl;
  final String category;
  final int publishedYear;
  final bool isFavorite;
  final bool isRead;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImageUrl,
    required this.category,
    required this.publishedYear,
    required this.isFavorite,
    required this.isRead,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      coverImageUrl: json['coverImageUrl'],
      category: json['category'],
      publishedYear: json['publishedYear'],
      isFavorite: json['isFavorite'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'category': category,
      'publishedYear': publishedYear,
      'isFavorite': isFavorite,
      'isRead': isRead,
    };
  }

  Book toEntity(){
    return Book(
      id: id,
      title: title,
      author: author,
      description: description,
      coverImageUrl: coverImageUrl,
      category: category,
      publishedYear: publishedYear,
      isFavorite: isFavorite,
      isRead: isRead,
    );
  }

  factory BookModel.fromEntity(Book book) {
  return BookModel(
    id: book.id,
    title: book.title,
    author: book.author,
    description: book.description,
    coverImageUrl: book.coverImageUrl,
    category: book.category,
    publishedYear: book.publishedYear,
    isFavorite: book.isFavorite,
    isRead: book.isRead,
  );
  }
}
