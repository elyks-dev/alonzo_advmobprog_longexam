import 'package:facebook_replication/constants.dart';
import 'package:facebook_replication/models.dart';
import 'package:facebook_replication/widgets/custom_button.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:facebook_replication/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Activity 3 - Enhancement 3: reuse PostCard (formerly newsfeed_card) for wall posts
  List<PostModel> _profilePosts() {
    final now = DateTime.now();
    return [
      PostModel(
        userName: 'Kyle Alonzo',
        postContent: 'Testing my CCITBook profile wall post! #CCITBook',
        date: now.subtract(const Duration(hours: 1)),
        likeCount: 42,
        commentCount: 5,
        shareCount: 1,
        hasImage: true,
        imagePath: 'assets/images/minion.png',
      ),
    ];
  }

  Widget _aboutTab() {
    // Activity 3 - Enhancement 4: About tab
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFont(
            text: 'About',
            fontSize: ScreenUtil().setSp(16),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ), // CustomFont
          const Divider(),
          _aboutRow(Icons.info_outline, 'Mobile developer | Flutter learner | Building CCITBook'),
          _aboutRow(Icons.school_outlined, 'Studying Mobile Programming'),
          _aboutRow(Icons.work_outline, 'Student Developer'),
          _aboutRow(Icons.location_on_outlined, 'Philippines'),
          _aboutRow(Icons.email_outlined, 'student@example.com'),
        ],
      ), // Column
    ); // Padding
  }

  Widget _aboutRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(6)),
      child: Row(
        children: [
          Icon(icon, size: ScreenUtil().setSp(18), color: APP_DARK_PRIMARY),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Expanded(
            child: CustomFont(
              text: text,
              fontSize: ScreenUtil().setSp(13),
              color: Colors.black87,
            ), // CustomFont
          ), // Expanded
        ],
      ), // Row
    ); // Padding
  }

  Widget _photosTab() {
    // Activity 3 - Enhancement 5: GridView class for the photos tab
    return GridView.builder(
      padding: EdgeInsets.all(ScreenUtil().setSp(5)),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ), // SliverGridDelegateWithFixedCrossAxisCount
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(Icons.image_outlined, color: Colors.grey),
        ); // Container
      },
    ); // GridView.builder
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(180),
                    decoration: BoxDecoration(color: Colors.grey[300]),
                  ), // Container - cover photo placeholder
                  Positioned(
                    bottom: -ScreenUtil().setHeight(45),
                    left: ScreenUtil().setWidth(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: ScreenUtil().setSp(45),
                          backgroundColor: Colors.grey[400],
                          child: Icon(Icons.person,
                              size: ScreenUtil().setSp(50), color: Colors.white),
                        ), // CircleAvatar
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: ScreenUtil().setSp(13),
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.camera_alt,
                                size: ScreenUtil().setSp(14), color: Colors.black),
                          ), // CircleAvatar
                        ), // Positioned
                      ],
                    ), // Stack
                  ), // Positioned
                ],
              ), // Stack
              SizedBox(height: ScreenUtil().setHeight(55)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Activity 3 - Enhancement 1: customize profile name
                    CustomFont(
                      text: 'Kyle Alonzo',
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(20),
                      color: Colors.black,
                    ), // CustomFont
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    // Activity 3 - Enhancement 2: customize followers/following count
                    Row(
                      children: [
                        CustomFont(
                          text: '2.3K',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ), // CustomFont
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'followers',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.grey,
                        ), // CustomFont
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Icon(Icons.circle, size: ScreenUtil().setSp(5), color: Colors.grey),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        CustomFont(
                          text: '180',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ), // CustomFont
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'following',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.grey,
                        ), // CustomFont
                      ],
                    ), // Row
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Row(
                      children: [
                        CustomButton(buttonName: 'Follow', onPressed: () {}),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        CustomButton(
                          buttonName: 'Message',
                          buttonType: 'outlined',
                          onPressed: () {},
                        ), // CustomButton
                      ],
                    ), // Row
                  ],
                ), // Column
              ), // Padding
              SizedBox(height: ScreenUtil().setHeight(10)),
              TabBar(
                indicatorColor: APP_DARK_PRIMARY,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    child: CustomFont(
                      text: 'Posts',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ), // CustomFont
                  ), // Tab
                  Tab(
                    child: CustomFont(
                      text: 'About',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ), // CustomFont
                  ), // Tab
                  Tab(
                    child: CustomFont(
                      text: 'Photos',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ), // CustomFont
                  ), // Tab
                ],
              ), // TabBar
              SizedBox(
                height: ScreenUtil().setHeight(2000),
                child: TabBarView(
                  children: [
                    // Enhancement 3: Wall posts (reuse PostCard)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _profilePosts().length,
                      itemBuilder: (context, index) {
                        return PostCard(post: _profilePosts()[index]);
                      },
                    ), // ListView.builder
                    _aboutTab(), // Enhancement 4
                    _photosTab(), // Enhancement 5
                  ],
                ), // TabBarView
              ), // SizedBox
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Container
    ); // DefaultTabController
  }
}
