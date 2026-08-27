import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/models.dart';
import 'package:alonzo_advmobprog_longexam1/screens/detail_screen.dart';
import 'package:alonzo_advmobprog_longexam1/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatefulWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;
  PostModel get post => widget.post;

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
                  CircleAvatar(
                    radius: ScreenUtil().setSp(20),
                    backgroundColor: Colors.grey[300],
                    backgroundImage: post.profileImageUrl.isNotEmpty
                        ? NetworkImage(post.profileImageUrl)
                        : (post.userName == 'Kyle Alonzo'
                            ? const AssetImage('lib/assets/images/owl.jpg')
                            : null) as ImageProvider?,
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
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(
                    icon: Icons.thumb_up_outlined,
                    label: 'Like',
                    onPressed: () => setState(() {
                      liked = !liked;
                      post.likeCount += liked ? 1 : -1;
                    }),
                  ),
                  _actionButton(
                    icon: Icons.comment_outlined,
                    label: 'Comment',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailScreen(post: post))),
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
