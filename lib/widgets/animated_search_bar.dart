import 'package:flutter/material.dart';

class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar(this.handleSearch, this.toggleCompleted, {super.key});

  final Function(String) handleSearch;
  final VoidCallback toggleCompleted;

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 120), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addListener(() {
        setState(() {});
      });
    // Tween<double>(begin: 0, end: 1).animate(controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
  }

  void handleTap() {
    setState(() {
      if (controller.isCompleted) {
        controller.reverse();
      } else {
        controller.forward();
      }
    });
    widget.toggleCompleted();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Transform.translate(
      offset: Offset(0, controller.value * -height * .43),
      child: Center(
        child: GestureDetector(
          onTap: () => handleTap(),
          child: Container(
            height: 60,
            width: width * .5 + (width * .4 * controller.value),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 8)
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                border: Border.all(color: Colors.black, width: .1)),
            child: Center(
              child: animation.isCompleted
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 6),
                      child: TextField(
                        cursorColor: Colors.black,
                        autofocus: true,
                        onChanged: (value) => widget.handleSearch(value),
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Search',
                            hintStyle:
                                TextStyle(fontSize: 24, color: Colors.black)),
                        style:
                            const TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
