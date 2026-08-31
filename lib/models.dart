// Data models shared by NewsfeedScreen, NotificationScreen,
// ProfileScreen, and DetailScreen.

class PostModel {
  final int? apiId;
  final int? userId;
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
    this.userId,
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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final reactions = json['reactions'] is Map<String, dynamic>
        ? json['reactions'] as Map<String, dynamic>
        : <String, dynamic>{};

    int number(dynamic value) {
      if (value is num) return value.toInt();
      return int.tryParse(value?.toString() ?? '0') ?? 0;
    }

    return PostModel(
      apiId: number(json['id']),
      userId: number(json['userId']),
      userName: '',
      postContent: (json['body'] ?? '').toString(),
      date: DateTime.now(),
      likeCount: number(reactions['likes'] ?? json['likes']),
      commentCount: number(json['comments']),
      shareCount: 0,
      hasImage: false,
      imagePath: '',
      profileImageUrl: '',
    );
  }

  PostModel copyWith({
    String? userName,
  }) {
    return PostModel(
      apiId: apiId,
      userId: userId,
      userName: userName ?? this.userName,
      postContent: postContent,
      date: date,
      likeCount: likeCount,
      commentCount: commentCount,
      shareCount: shareCount,
      hasImage: hasImage,
      imagePath: imagePath,
      profileImageUrl: profileImageUrl,
    );
  }
}

// ---------------- COMMENTS ----------------

class CommentModel {
  final int id;
  final int postId;
  final String body;
  final int likes;
  final String userName;

  CommentModel({
    required this.id,
    required this.postId,
    required this.body,
    required this.likes,
    required this.userName,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      postId: json['postId'] ?? 0,
      body: json['body'] ?? '',
      likes: json['likes'] ?? 0,
      userName: (json['user']?['fullName'] ??
              json['user']?['username'] ??
              'User')
          .toString(),
    );
  }
}

// ---------------- NOTIFICATIONS ----------------

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