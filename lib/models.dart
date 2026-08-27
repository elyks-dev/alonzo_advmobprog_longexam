// Data models shared by NewsfeedScreen, NotificationScreen,
// ProfileScreen, and DetailScreen.

class PostModel {
  final int? apiId;
  final String userName;
  final String postContent;
  final DateTime date;
  int likeCount;
  final int commentCount;
  final int shareCount;
  final bool hasImage;

  final String imagePath;
  final String profileImageUrl;

  PostModel({
    this.apiId,
    required this.userName,
    required this.postContent,
    required this.date,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.hasImage = false,
    this.imagePath = '',
    this.profileImageUrl = '',
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        apiId: json['id'] as int?,
        userName: 'User ${json['userId'] ?? ''}',
        postContent: (json['body'] ?? '').toString(),
        date: DateTime.now(),
        likeCount: ((json['reactions'] is Map)
            ? (json['reactions']['likes'] ?? 0)
            : (json['likes'] ?? 0)) as int,
        commentCount:
            (json['comments'] ?? 0) is int ? json['comments'] as int : 0,
        hasImage: false,
      );
}

class CommentModel {
  final int id;
  final String body;
  final String userName;
  CommentModel({required this.id, required this.body, required this.userName});
  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      userName: (json['user']?['username'] ?? 'User').toString());
}

class NotificationModel {
  final String name;
  final String post;
  final String description;
  final DateTime date;
  final String profileImageUrl;

  NotificationModel({
    required this.name,
    required this.post,
    required this.description,
    required this.date,
    this.profileImageUrl = '',
  });
}
