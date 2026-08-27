class Post {
  final int id;
  final int postId;
  final int userId;
  final String body;
  final int likes;
  final int dislikes;
  final String createdAt;
  final String updatedAt;

  const Post(
      {required this.id,
      required this.postId,
      required this.userId,
      required this.body,
      required this.likes,
      required this.dislikes,
      required this.createdAt,
      required this.updatedAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    final reactions = json['reactions'] is Map
        ? json['reactions'] as Map
        : const <String, dynamic>{};
    int number(dynamic value) =>
        value is num ? value.toInt() : int.tryParse('$value') ?? 0;
    return Post(
        id: number(json['id']),
        postId: number(json['postId'] ?? json['id']),
        userId: number(json['userId']),
        body: '${json['body'] ?? ''}',
        likes: number(reactions['likes'] ?? json['likes']),
        dislikes: number(reactions['dislikes'] ?? json['dislikes']),
        createdAt: '${json['createdAt'] ?? json['created_at'] ?? ''}',
        updatedAt: '${json['updatedAt'] ?? json['updated_at'] ?? ''}');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'userId': userId,
        'body': body,
        'reactions': {'likes': likes, 'dislikes': dislikes},
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}
