import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/models.dart';
import 'package:alonzo_advmobprog_longexam1/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alonzo_advmobprog_longexam1/services/post_service.dart';

class DetailScreen extends StatefulWidget {
  final PostModel post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late int _likeCount;
  final _commentController = TextEditingController();
  final List<String> _comments = ['Great post!', 'Thanks for sharing this.'];

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.likeCount;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Comments',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      FutureBuilder<List<CommentModel>>(
                        future: post.apiId == null
                            ? Future.value(const <CommentModel>[])
                            : PostService().getComments(post.apiId!),
                        builder: (_, snapshot) {
                          final apiComments =
                              snapshot.data ?? const <CommentModel>[];
                          final comments = [
                            ...apiComments
                                .map((c) => '${c.userName}: ${c.body}'),
                            ..._comments
                          ];
                          return Column(
                              children: comments
                                  .map((comment) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const CircleAvatar(
                                          radius: 16,
                                          child: Icon(Icons.person, size: 18)),
                                      title: Text(comment),
                                      subtitle: const Text('Just now')))
                                  .toList());
                        },
                      ),
                      Row(children: [
                        Expanded(
                            child: TextField(
                                controller: _commentController,
                                decoration: const InputDecoration(
                                    hintText: 'Write a comment...',
                                    isDense: true))),
                        IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (_commentController.text.trim().isEmpty)
                                return;
                              setState(() {
                                _comments.add(_commentController.text.trim());
                                _commentController.clear();
                              });
                            })
                      ]),
                    ]),
              ),
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Container
    ); // Scaffold
  }
}
