import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/models.dart';
import 'package:alonzo_advmobprog_longexam1/models/user.dart';
import 'package:alonzo_advmobprog_longexam1/services/user_service.dart';
import 'package:alonzo_advmobprog_longexam1/services/post_service.dart';
import 'package:alonzo_advmobprog_longexam1/widgets/custom_button.dart';
import 'package:alonzo_advmobprog_longexam1/widgets/custom_font.dart';
import 'package:alonzo_advmobprog_longexam1/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();

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
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutTab(UserModel user) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
        vertical: ScreenUtil().setHeight(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFont(
            text: 'About',
            fontSize: ScreenUtil().setSp(16),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          const Divider(),

          _aboutRow(Icons.person_outline, user.username),
          _aboutRow(Icons.work_outline, user.companyTitle),
          _aboutRow(Icons.location_on_outlined, user.city),
          _aboutRow(Icons.email_outlined, user.email),
          _aboutRow(Icons.phone_outlined, user.phone),
          _aboutRow(Icons.info_outline, user.gender),
        ],
      ),
    );
  }

  Widget _photosTab() {
    return GridView.builder(
      padding: EdgeInsets.all(ScreenUtil().setSp(5)),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(Icons.image_outlined, color: Colors.grey),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: UserService().userId,
      builder: (context, idSnapshot) {
        if (!idSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return FutureBuilder<UserModel>(
          future: _userService.getUser(idSnapshot.data!),
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = userSnapshot.data!;

            return DefaultTabController(
              length: 3,
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cover + Profile Picture
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: ScreenUtil().setHeight(180),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/holiday.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -ScreenUtil().setHeight(45),
                            left: ScreenUtil().setWidth(20),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: ScreenUtil().setSp(45),
                                  backgroundImage: NetworkImage(user.image),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: ScreenUtil().setSp(13),
                                    backgroundColor: Colors.grey[300],
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: ScreenUtil().setSp(14),
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: ScreenUtil().setHeight(55)),

                      // Name and Stats
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFont(
                              text: user.name,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(20),
                              color: Colors.black,
                            ),

                            SizedBox(height: ScreenUtil().setHeight(5)),

                            Row(
                              children: [
                                CustomFont(
                                  text: '${user.id * 230}',
                                  fontSize: ScreenUtil().setSp(15),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(width: ScreenUtil().setWidth(5)),
                                CustomFont(
                                  text: 'followers',
                                  fontSize: ScreenUtil().setSp(15),
                                  color: Colors.grey,
                                ),
                                SizedBox(width: ScreenUtil().setWidth(10)),
                                Icon(
                                  Icons.circle,
                                  size: ScreenUtil().setSp(5),
                                  color: Colors.grey,
                                ),
                                SizedBox(width: ScreenUtil().setWidth(10)),
                                CustomFont(
                                  text: '${user.id * 18}',
                                  fontSize: ScreenUtil().setSp(15),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(width: ScreenUtil().setWidth(5)),
                                CustomFont(
                                  text: 'following',
                                  fontSize: ScreenUtil().setSp(15),
                                  color: Colors.grey,
                                ),
                              ],
                            ),

                            SizedBox(height: ScreenUtil().setHeight(10)),

                            Row(
                              children: [
                                CustomButton(
                                  buttonName: 'Follow',
                                  onPressed: () {},
                                ),
                                SizedBox(width: ScreenUtil().setWidth(10)),
                                CustomButton(
                                  buttonName: 'Message',
                                  buttonType: 'outlined',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: ScreenUtil().setHeight(10)),

                      // Tabs
                      TabBar(
                        indicatorColor: APP_DARK_PRIMARY,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            child: CustomFont(
                              text: 'Posts',
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.black,
                            ),
                          ),
                          Tab(
                            child: CustomFont(
                              text: 'About',
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.black,
                            ),
                          ),
                          Tab(
                            child: CustomFont(
                              text: 'Photos',
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: ScreenUtil().setHeight(2000),
                        child: TabBarView(
                          children: [
                            // POSTS
                            FutureBuilder<List<PostModel>>(
                              future: PostService().getPostsByUser(user.id),
                              builder: (context, postsSnapshot) {
                                if (postsSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                final posts = postsSnapshot.data ?? [];

                                if (posts.isEmpty) {
                                  return const Center(
                                    child: Text('No posts yet.'),
                                  );
                                }

                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: posts.length,
                                  itemBuilder: (_, index) =>
                                      PostCard(post: posts[index]),
                                );
                              },
                            ),

                            // ABOUT
                            _aboutTab(user),

                            // PHOTOS
                            _photosTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}