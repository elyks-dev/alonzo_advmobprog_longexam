import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/models.dart';
import 'package:alonzo_advmobprog_longexam1/screens/detail_screen.dart';
import 'package:alonzo_advmobprog_longexam1/services/comment_service.dart';
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
  bool showComments = false;
  bool loadingComments = false;

  late int likeCount;

  final TextEditingController commentController = TextEditingController();

  List<CommentModel> comments = [];

  PostModel get post => widget.post;

  @override
  void initState() {
    super.initState();
    likeCount = post.likeCount;
  }

  Future<void> loadComments() async {
    if (post.apiId == null) return;

    setState(() => loadingComments = true);

    try {
      final data = await CommentService().getCommentsByPost(post.apiId!);

      setState(() {
        comments = data;
      });
    } finally {
      setState(() => loadingComments = false);
    }
  }

  void addComment() {
    if (commentController.text.trim().isEmpty) return;

    setState(() {
      comments.insert(
        0,
        CommentModel(
          id: DateTime.now().millisecondsSinceEpoch,
          postId: post.apiId ?? 0,
          body: commentController.text.trim(),
          likes: 0,
          userName: 'Kyle Alonzo',
        ),
      );

      commentController.clear();
    });
  }

  Widget actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color color = APP_DARK_PRIMARY,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: CustomFont(
        text: label,
        fontSize: 12.sp,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.sp),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(post: post),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // USER INFO
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: post.profileImageUrl.isNotEmpty
                        ? NetworkImage(post.profileImageUrl)
                        : (post.userName == 'Kyle Alonzo'
                                ? const AssetImage(
                                    'lib/assets/images/owl.jpg')
                                : null)
                            as ImageProvider?,
                    child: post.profileImageUrl.isEmpty
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: post.userName,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                      CustomFont(
                        text:
                            "${post.date.month}/${post.date.day}/${post.date.year}",
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              // POST CONTENT
              CustomFont(
                text: post.postContent,
                fontSize: 13.sp,
                color: Colors.black,
              ),

              SizedBox(height: 8.h),

              if (post.hasImage)
                SizedBox(
                  width: double.infinity,
                  height: 180.h,
                  child: post.imagePath.isNotEmpty
                      ? Image.asset(post.imagePath, fit: BoxFit.cover)
                      : const Placeholder(),
                ),

              SizedBox(height: 8.h),

              CustomFont(
                text: "$likeCount Likes",
                fontSize: 12.sp,
                color: Colors.grey,
              ),

              const Divider(),

              // ACTION BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  actionButton(
                    icon:
                        liked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    label: "Like",
                    color: liked ? Colors.blue : APP_DARK_PRIMARY,
                    onPressed: () {
                      setState(() {
                        liked = !liked;
                        likeCount += liked ? 1 : -1;
                        post.likeCount = likeCount;
                      });
                    },
                  ),

                  actionButton(
                    icon: Icons.comment_outlined,
                    label: "Comment",
                    onPressed: () async {
                      setState(() => showComments = !showComments);

                      if (showComments && comments.isEmpty) {
                        await loadComments();
                      }
                    },
                  ),

                  actionButton(
                    icon: Icons.share_outlined,
                    label: "Share",
                    onPressed: () {},
                  ),
                ],
              ),

              // COMMENTS
              if (showComments) ...[
                const Divider(),

                if (loadingComments)
                  const Center(child: CircularProgressIndicator())
                else if (comments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "No comments yet.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (_, index) {
                      final comment = comments[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          comment.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(comment.body),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text("${comment.likes}"),
                          ],
                        ),
                      );
                    },
                  ),

                const Divider(),

                // ADD COMMENT
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: "Write a comment...",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: addComment,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}