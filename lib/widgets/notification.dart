import 'package:facebook_replication/models.dart';
import 'package:facebook_replication/screens/detail_screen.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notif});

  final NotificationModel notif;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Lab Activity 4 - Enhancement 1: clickable, same behavior as PostCard
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              post: PostModel(
                userName: notif.name,
                postContent: notif.description,
                date: notif.date,
                profileImageUrl: notif.profileImageUrl,
              ),
            ), // DetailScreen
          ), // MaterialPageRoute
        ); // Navigator.push
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(15)),
        child: Row(
          children: [
            // Lab Activity 4 - Enhancement 2: image if available, person icon if not
            CircleAvatar(
              radius: ScreenUtil().setSp(25),
              backgroundColor: Colors.grey[300],
              backgroundImage: notif.profileImageUrl.isNotEmpty
                  ? NetworkImage(notif.profileImageUrl)
                  : null,
              child: notif.profileImageUrl.isEmpty
                  ? Icon(Icons.person, size: ScreenUtil().setSp(28), color: Colors.white)
                  : null,
            ), // CircleAvatar
            SizedBox(width: ScreenUtil().setWidth(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFont(
                    text: notif.name,
                    fontSize: ScreenUtil().setSp(15),
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ), // CustomFont
                  CustomFont(
                    text: 'Posted: ${notif.post}',
                    fontSize: ScreenUtil().setSp(13),
                    color: Colors.black,
                  ), // CustomFont
                  CustomFont(
                    text: notif.description,
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ), // CustomFont
                  SizedBox(height: ScreenUtil().setSp(5)),
                  CustomFont(
                    text: '${notif.date.month}/${notif.date.day}/${notif.date.year}',
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.grey.shade400,
                  ), // CustomFont
                ],
              ), // Column
            ), // Expanded
            const Icon(Icons.more_horiz),
          ],
        ), // Row
      ), // Container
    ); // InkWell
  }
}
