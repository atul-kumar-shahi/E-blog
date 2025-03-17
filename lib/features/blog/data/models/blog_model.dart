import 'package:blog/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.topics,
    required super.id,
    required super.posterId,
    required super.content,
    required super.title,
    required super.imageUrl,
    required super.updatedAt,
     super.posterName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'content': content,
      'title': title,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson  (Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      content: map['content'] as String,
      title: map['title'] as String,
      imageUrl: map['image_url'] as String,
      topics: List<String>.from(map['topics'] ??[]),
      updatedAt:map['updated_at']==null?DateTime.now(): DateTime.parse(map['updated_at']),
    );
  }

  BlogModel copyWith({
    List<String>? topics,
    String? id,
    String? posterId,
    String? content,
    String? title,
    String? imageUrl,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      topics: topics ?? this.topics,
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      content: content ?? this.content,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
