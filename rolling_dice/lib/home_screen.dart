import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var leftdicenum = 1;
  var rightdicenum = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;
  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void roll() {
    _controller.forward();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftdicenum = Random().nextInt(6) + 1;
          rightdicenum = Random().nextInt(6) + 1;
        });
        print("completed!!");
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Dicee",
          style: TextStyle(
              color: Colors.blueGrey.shade700,
              fontSize: 50,
              fontStyle: FontStyle.italic),
        )),
        backgroundColor: Colors.black26,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:
            BoxDecoration(gradient: LinearGradient(//can also use lineargradient
                colors: [Color(0xff868f96), Color(0xff868f96)])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 170,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onDoubleTap: roll,
                    child: Image(
                        height: 200 - (animation.value * 200),
                        image: AssetImage('images/dice-$leftdicenum.png')),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onDoubleTap: roll,
                    child: Image(
                        height: 200 - (animation.value * 200),
                        image: AssetImage('images/dice-$rightdicenum.png')),
                  )),
                  SizedBox(
                    width: 170,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () {
                    roll();
                  },
                  child: Text(
                    'Roll',
                    style: TextStyle(color: Colors.black, fontSize: 50),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
