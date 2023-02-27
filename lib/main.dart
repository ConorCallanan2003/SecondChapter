import 'package:flutter/material.dart';
import 'package:replay_books/pages/homepage.dart';
import 'package:replay_books/pages/new/new_homepage.dart';
import 'package:replay_books/pages/profile_page.dart';
import 'package:replay_books/pages/search_page.dart';
import 'package:replay_books/widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: const NewHomePage());
  }
}

class AppSkeleton extends StatefulWidget {
  const AppSkeleton({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    ProfilePage()
  ];

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(selectedIndex, onItemTapped),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: AppSkeleton._widgetOptions[selectedIndex]);
  }
}
