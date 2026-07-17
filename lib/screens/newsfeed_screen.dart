import 'package:facebook_replication/models.dart';
import 'package:facebook_replication/widgets/post_card.dart';
import 'package:flutter/material.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  // Activity 2 - General Enhancement: 5-10 posts, each with number of likes,
  // a date, and whether it has a placeholder image or none.
  List<PostModel> _samplePosts() {
    final now = DateTime.now();
    return [
      PostModel(
        userName: 'Cyrus Robles',
        postContent: 'Kamusta, first day using CCITBook!',
        date: now.subtract(const Duration(hours: 2)),
        likeCount: 128,
        commentCount: 15,
        shareCount: 12,
        hasImage: false,
      ),
      PostModel(
        userName: 'Kyle Alonzo'
        ,
        postContent: 'Holiday vibes! Enjoying the time with family and friends.',
        date: now.subtract(const Duration(hours: 5)),
        likeCount: 67,
        commentCount: 12,
        shareCount: 3,
        hasImage: true,
        imagePath: 'assets/images/holiday.png',
      ),
      PostModel(
        userName: 'Bruce Wayne',
        postContent: 'It\'s what you do that defines you.',
        date: now.subtract(const Duration(hours: 8)),
        likeCount: 54,
        commentCount: 9,
        shareCount: 2,
        hasImage: true,
        imagePath: 'assets/images/batman.png',
      ),
      PostModel(
        userName: 'Clark Kent',
        postContent: 'Coding session done, finally shipped the feature.',
        date: now.subtract(const Duration(days: 1)),
        likeCount: 41,
        commentCount: 6,
        shareCount: 1,
        hasImage: false,
      ),
      PostModel(
        userName: 'Diana Prince',
        postContent: 'Excited for the upcoming hackathon!',
        date: now.subtract(const Duration(days: 1, hours: 4)),
        likeCount: 88,
        commentCount: 20,
        shareCount: 5,
        hasImage: true,
        imagePath: 'assets/images/hackathon.png',
      ),
      PostModel(
        userName: 'Steve Rogers',
        postContent: 'Passing the shield to the next generation of devs.',
        date: now.subtract(const Duration(days: 2)),
        likeCount: 76,
        commentCount: 11,
        shareCount: 4,
        hasImage: false,
      ),
      PostModel(
        userName: 'Tony Stark',
        postContent: 'Just deployed to prod, what could go wrong.',
        date: now.subtract(const Duration(days: 3)),
        likeCount: 210,
        commentCount: 33,
        shareCount: 18,
        hasImage: true,
        imagePath: 'assets/images/deployment.png',
      ),
      PostModel(
        userName: 'Natasha Romanoff',
        postContent: 'Debugging is 90% patience, 10% luck.',
        date: now.subtract(const Duration(days: 4)),
        likeCount: 59,
        commentCount: 7,
        shareCount: 2,
        hasImage: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final posts = _samplePosts();
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index]);
      },
    ); // ListView.builder
  }
}
