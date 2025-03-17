class Blog {
  final String id;
  final String posterId;
  final String content;
  final String title;
  final String imageUrl;
  final DateTime updatedAt;
  final List<String> topics;
  final String? posterName;


  Blog( {
    required this.topics,
    required this.id,
    required this.posterId,
    required this.content,
    required this.title,
    required this.imageUrl,
    required this.updatedAt,
     this.posterName,
  });

}


