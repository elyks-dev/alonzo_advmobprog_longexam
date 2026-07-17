import 'package:facebook_replication/constants.dart';
import 'package:facebook_replication/models.dart';
import 'package:facebook_replication/screens/detail_screen.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Formerly "NewsfeedCard" (Activity 1) -> renamed to "PostCard" (Activity 3)
class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  // Activity 1 - Enhancement 3: like/comment/share as reusable widget-based buttons
  Widget _actionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: APP_DARK_PRIMARY),
      label: CustomFont(
        text: label,
        fontSize: ScreenUtil().setSp(12),
        color: APP_DARK_PRIMARY,
      ), // CustomFont
    ); // TextButton.icon
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ScreenUtil().setSp(10)),
      // Lab Activity 4 - Enhancement 1: PostCard is clickable (same as Notification)
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(post: post),
            ), // MaterialPageRoute
          ); // Navigator.push
        },
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setSp(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Activity 1 - Enhancement 2: avatar for user profile image
                  CircleAvatar(
                    radius: ScreenUtil().setSp(20),
                    backgroundColor: Colors.grey[300],
                    backgroundImage: post.profileImageUrl.isNotEmpty
                        ? NetworkImage(post.profileImageUrl)
                        : null,
                    child: post.profileImageUrl.isEmpty
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ), // CircleAvatar
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: post.userName,
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ), // CustomFont
                      CustomFont(
                        text:
                            '${post.date.month}/${post.date.day}/${post.date.year}',
                        fontSize: ScreenUtil().setSp(12),
                        color: Colors.grey,
                      ), // CustomFont
                    ],
                  ), // Column
                ],
              ), // Row
              SizedBox(height: ScreenUtil().setSp(5)),
              CustomFont(
                text: post.postContent,
                fontSize: ScreenUtil().setSp(12),
                color: Colors.black,
              ), // CustomFont
              SizedBox(height: ScreenUtil().setSp(5)),
              // Activity 1 - Enhancement 1: placeholder/widget for the image area
              (post.hasImage)
                  ? SizedBox(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(180),
                      child: post.imagePath.isNotEmpty
                          ? Image.asset(post.imagePath, fit: BoxFit.cover)
                          : const Placeholder(),
                    )
                  : const SizedBox(height: 0),
              SizedBox(height: ScreenUtil().setSp(5)),
              CustomFont(
                text: '${post.likeCount} Likes',
                fontSize: ScreenUtil().setSp(12),
                color: Colors.grey,
              ), // CustomFont - Activity 1 Enhancement 3: disregard reaction, show like count only
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(
                    icon: Icons.thumb_up_outlined,
                    label: 'Like',
                    onPressed: () {},
                  ),
                  _actionButton(
                    icon: Icons.comment_outlined,
                    label: 'Comment',
                    onPressed: () {},
                  ),
                  _actionButton(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onPressed: () {},
                  ),
                ],
              ), // Row
            ],
          ), // Column
        ), // Padding
      ), // InkWell
    ); // Card
  }
}
