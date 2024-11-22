import 'dart:math';

import 'package:cat_out_of_the_box/src/widgets/cat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() {
    super.initState();

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

    /// Controller
    catController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    /// Animation
    catAnimation = Tween(begin: -35.0, end: -84.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

    boxController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    boxController.forward();

  }

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

  /// Build box
  Widget buildBox() {
    return Container(width: 200.0, height: 200.0, color: Colors.brown);
  }

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
}
