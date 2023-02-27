import 'package:flutter/material.dart';

class BottomNavBarItem extends StatefulWidget {
  BottomNavBarItem(this.icon, this.index, this.selected, this.onItemTapped,
      this.name, this.animationValue,
      {super.key});

  final IconData icon;
  final int index;
  final bool selected;
  final Function(int) onItemTapped;
  final String name;
  double animationValue;

  @override
  State<BottomNavBarItem> createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<BottomNavBarItem> {
  @override
  Widget build(BuildContext context) {
    if (!widget.selected) {
      widget.animationValue = widget.animationValue * 0;
    }
    return GestureDetector(
      onTap: () {
        widget.onItemTapped(widget.index);
      },
      child: SizedBox(
        height: 80,
        width: 80,
        child: Column(
          children: [
            Icon(
              widget.icon,
              size: 32 + 12 * widget.animationValue,
              color: widget.selected ? Colors.cyan : Colors.black,
            ),
            Text(
              widget.name,
              style: TextStyle(
                  color: widget.selected ? Colors.cyan : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
