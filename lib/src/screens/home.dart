import 'dart:math';

import 'package:cat_out_of_the_box/src/widgets/cat.dart';
import 'package:flutter/material.dart';

/// The home screen of the application.
///
/// This screen features an interactive animation where a cat pops out
/// of a box when tapped. The box flaps move while idle, and tapping
/// stops the flaps and animates the cat.
///
/// The animations use [AnimationController], [Animation], and [Tween].
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

/// The state for the [Home] widget.
///
/// Manages animations for the cat and the box flaps.
class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() {
    super.initState();

    // Initialize box flap animation
    boxController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.linear,
      ),
    );

    // Initialize cat animation
    catController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    /// Animation
    catAnimation = Tween(begin: -35.0, end: -84.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

    // Add status listener to box controller for continuous animation
    boxController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    // Start box animation
    boxController.forward();
  }

  /// Handles user tap events.
  ///
  /// - If the cat is fully visible, reverse the cat animation and restart the box flaps.
  /// - Otherwise, animate the cat and stop the box flaps.
  void onTap() {
    if (catAnimation.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
      return;
    }

    catController.forward();
    boxController.stop();

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Out of the Box'),
      ),
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              buildAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the animated cat widget.
  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          left: 0.0,
          right: 0.0,
          top: catAnimation.value,
          child: child!,
        );
      },
      child: Cat(),
    );
  }

  /// Builds the stationary box widget.
  Widget buildBox() {
    return Container(width: 200.0, height: 200.0, color: Colors.brown);
  }

  /// Builds the left flap of the box with animation.
  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
              alignment: Alignment.topLeft,
              angle: boxAnimation.value,
              child: Container(
                height: 10.0,
                width: 125.0,
                color: Colors.brown,
              ));
        },
      ),
    );
  }

  /// Builds the right flap of the box with animation.
  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
              alignment: Alignment.topRight,
              angle: -boxAnimation.value,
              child: Container(
                height: 10.0,
                width: 125.0,
                color: Colors.brown,
              ));
        },
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of animation controllers to free resources
    catController.dispose();
    boxController.dispose();
    super.dispose();
  }
}
