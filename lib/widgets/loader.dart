
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';



class Loader extends StatefulWidget {
  Loader({required this.loadIng,required this.child,required this.color,required this.opacity});
  final bool loadIng;
  final Color color;
  final double opacity;
  final Widget child;
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin{
  late AnimationController controller;
  late  Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;

  final double initialRadius = 30.0;

  double radius = 0.0;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation_radius_in = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));
    animation_radius_out = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));
    animation_rotation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    controller.addListener(() {
      if(this.mounted){
        setState(() {
          if(controller.value >= 0.75 && controller.value <= 1.0){
            radius = animation_radius_in.value * initialRadius;
          }
          else if(controller.value >= 0.0 && controller.value <= 0.25){
            radius = animation_radius_out.value * initialRadius;
          }
        });
      }

    });

    controller.repeat();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loadIng) return widget.child;
    return IgnorePointer(
    ignoring: true,

    child:


      Stack(
      children: <Widget>[
        widget.child,
        Opacity(
          child: new ModalBarrier(color: widget.color),
          opacity: widget.opacity,
        ),
        Container(
         // color: widget.color,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            //top: MediaQuery.of(context).size.height/2,
            //left: MediaQuery.of(context).size.height/5,
            child: Container(
              width: 200.0,
              height: 200.0 *1.61803398875,
              child:
              
             // LoadingIndicator(indicatorType: Indicator.ballScaleMultiple,colors: [Colors.white],)
              RotationTransition(
                turns: animation_rotation,
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Dot(radius: 30.0, color: Colors.white,),
                      Transform.translate(
                          offset: Offset(radius * cos(pi/4), radius * sin(pi/4)),
                          child: Dot(radius: 6.0, color: Colors.black87,)
                      ),
                      Transform.translate(
                          offset: Offset(radius * cos(2 * pi/4), radius * sin(2 * pi/4)),
                          child: Dot(radius: 6.0, color: Colors.orange,)
                      ),
                      Transform.translate(
                          offset: Offset(radius * cos(3 * pi/4), radius * sin(3 * pi/4)),
                          child: Dot(radius: 6.0, color: Colors.yellow,)
                      ),
                      Transform.translate(
                          offset: Offset(radius * cos(4 * pi/4), radius * sin(4 * pi/4)),
                          child: Dot(radius: 6.0, color: Colors.white,)
                      ),
                      Transform.translate(
                          offset: Offset(radius * cos(5 * pi/4), radius * sin(5 * pi/4)),
                          child: Dot(radius: 6.0, color: Colors.cyanAccent,)
                      ),
                      Transform.translate(
                          offset: Offset(radius * cos(6 * pi/4), radius * sin(6 * pi/4)),
                          child: Dot(radius: 6.0, color: Colors.purpleAccent,)
                      ),
                      Transform.translate(
                          offset: Offset(radius * cos(7 * pi/4), radius * sin(7 * pi/4)),
                          child: Dot(radius: 6.0, color: Colors.pink,)
                      ),
                      Transform.translate(
                          offset: Offset(radius * cos(8 * pi/4), radius * sin(8 * pi/4)),
                          child: Dot(radius: 6.0, color: Colors.deepPurple,)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({required this.radius,required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
            color: this.color,
            shape: BoxShape.circle
        ),
      ),
    );
  }
}

