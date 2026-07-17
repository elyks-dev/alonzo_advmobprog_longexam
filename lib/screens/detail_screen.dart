import 'package:facebook_replication/constants.dart';
import 'package:facebook_replication/models.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  final PostModel post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomFont(
          text: post.userName,
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black,
        ), // CustomFont
      ), // AppBar
      body: Container(
        color: Colors.white,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              (post.hasImage)
                  ? SizedBox(
                      height: ScreenUtil().setHeight(220),
                      width: double.infinity,
                      child: post.imagePath.isNotEmpty
                          ? Image.asset(post.imagePath, fit: BoxFit.cover)
                          : const Placeholder(),
                    )
                  : SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: ScreenUtil().setSp(25),
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
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ), // CustomFont
                        CustomFont(
                          text:
                              '${post.date.month}/${post.date.day}/${post.date.year}',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.grey,
                        ), // CustomFont
                      ],
                    ), // Column
                  ],
                ), // Row
              ), // Container
              SizedBox(height: ScreenUtil().setHeight(15)),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                alignment: Alignment.centerLeft,
                child: CustomFont(
                  text: post.postContent,
                  fontSize: ScreenUtil().setSp(16),
                  color: Colors.black,
                ), // CustomFont
              ), // Container
              SizedBox(height: ScreenUtil().setHeight(20)),
              const Divider(),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Lab Activity 4 - Enhancement 3: like count increments on click
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _likeCount++;
                        });
                      },
                      icon: const Icon(Icons.thumb_up, color: APP_DARK_PRIMARY),
                      label: CustomFont(
                        text: '$_likeCount',
                        fontSize: ScreenUtil().setSp(12),
                        color: APP_DARK_PRIMARY,
                      ), // CustomFont
                    ), // TextButton.icon
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.comment, color: APP_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Comment',
                        fontSize: ScreenUtil().setSp(12),
                        color: APP_DARK_PRIMARY,
                      ), // CustomFont
                    ), // TextButton.icon
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, color: APP_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Share',
                        fontSize: ScreenUtil().setSp(12),
                        color: APP_DARK_PRIMARY,
                      ), // CustomFont
                    ), // TextButton.icon
                  ],
                ), // Row
              ), // Container
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Container
    ); // Scaffold
  }
}
