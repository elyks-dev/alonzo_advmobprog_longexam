import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/screens/newsfeed_screen.dart';
import 'package:alonzo_advmobprog_longexam1/screens/notification_screen.dart';
import 'package:alonzo_advmobprog_longexam1/screens/profile_screen.dart';
import 'package:alonzo_advmobprog_longexam1/screens/friends_screen.dart';
import 'package:alonzo_advmobprog_longexam1/screens/menu_screen.dart';
import 'package:alonzo_advmobprog_longexam1/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<String> _titles = const [
    'CCITBook',
    'Friends',
    'Notifications',
    'Menu',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APP_LIGHT_PRIMARY,
        shadowColor: APP_TEXT_COLOR_WHITE,
        elevation: 2,
        title: CustomFont(
          text: _titles[_selectedIndex],
          fontSize: ScreenUtil().setSp(25),
          color: APP_PRIMARY,
          fontWeight: FontWeight.bold,
        ), // CustomFont
      ), // AppBar
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          NewsfeedScreen(),
          FriendsScreen(),
          NotificationScreen(),
          MenuScreen(),
          ProfileScreen(),
        ], // <Widget>[]
        onPageChanged: (page) {
          setState(() => _selectedIndex = page);
        },
      ), // PageView
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false, // selected item
        showUnselectedLabels: false, // unselected item
        type: BottomNavigationBarType.fixed,
        onTap: _onTappedBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Friends'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ], // []
        selectedItemColor: APP_PRIMARY,
        currentIndex: _currentBarIndex(),
      ), // BottomNavigationBar
    ); // Scaffold
  }

  // Maps the 3 real pages onto the 5 nav items (Friends & Menu are stubs).
  int _currentBarIndex() => _selectedIndex;

  void _onTappedBar(int value) {
    setState(() => _selectedIndex = value);
    _pageController.jumpToPage(value);
  }
}
