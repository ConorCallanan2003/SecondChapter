import 'package:flutter/material.dart';
import 'package:replay_books/widgets/small/bottom_nav_bar_item.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(this.selectedIndex, this.onItemTapped, {super.key});

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);

    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  onItemTapped(int i) {
    controller.reset();
    widget.onItemTapped(i);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, blurRadius: 10, offset: Offset(0, -5))
          ]),
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavBarItem(Icons.trending_up, 0, (0 == widget.selectedIndex),
              onItemTapped, 'Popular', animation.value),
          BottomNavBarItem(Icons.search, 1, (1 == widget.selectedIndex),
              onItemTapped, 'Search', animation.value),
          BottomNavBarItem(Icons.person, 2, (2 == widget.selectedIndex),
              onItemTapped, 'My Profile', animation.value),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
