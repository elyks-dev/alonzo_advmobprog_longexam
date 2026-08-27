class Comment {
  final int id;
  final int postId;
  final String body;
  final int likes;
  final String userName;

  const Comment(
      {required this.id,
      required this.postId,
      required this.body,
      required this.likes,
      required this.userName});

  factory Comment.fromJson(Map<String, dynamic> json) {
    final user =
        json['user'] is Map ? json['user'] as Map : const <String, dynamic>{};
    final rawLikes = json['likes'];
    return Comment(
        id: json['id'] is num ? (json['id'] as num).toInt() : 0,
        postId: json['postId'] is num ? (json['postId'] as num).toInt() : 0,
        body: '${json['body'] ?? ''}',
        likes: rawLikes is num ? rawLikes.toInt() : 0,
        userName: '${user['username'] ?? json['userName'] ?? 'User'}');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'body': body,
        'likes': likes,
        'user': {'username': userName}
      };
}
