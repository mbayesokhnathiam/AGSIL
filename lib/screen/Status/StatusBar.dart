import 'dart:async';
import 'package:ajiledakarv/models/Status.dart';
import 'package:ajiledakarv/screen/Status/StatusPage.dart';
import 'package:ajiledakarv/screen/Status/statusView.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:flutter/material.dart';


class StatusBar extends StatefulWidget {
  final List<StatusModel> statuses;
  final String regionId;


  StatusBar({required this.statuses, required this.regionId});

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  int _currentIndex = 0;
  double _progress = 0;
  Timer? _timer;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1) {
          _progress = 0;
          _currentIndex++;
          if (_currentIndex >= widget.statuses.length) {
            _currentIndex = 0;
          }
          _showStatus(context, widget.statuses[_currentIndex]);
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
  @override
  void initState() {
    super.initState();
  //  _startTimer();
  }

  @override
  void dispose() {
//    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
      child: Stack(
        children: [
     /*     Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _progress,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),*/
          ListView.builder(
            itemCount: widget.statuses.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>StatusView (statuses: widget.statuses[index],regionId:widget.regionId)));
               //   _showStatus(context, widget.statuses[index]);
             //     _stopTimer();
                },
                child: Container(
                  decoration: BoxDecoration(

                  ),
                  margin: EdgeInsets.all(2),
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor:Colors.orangeAccent,
                            //   border: Border.all(color:Colors.orangeAccent,)
                            radius: 30,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              backgroundImage: NetworkImage(
                                  "${APIConstants.IMG_BASE_URL}${ widget.statuses[index].image}"

                              ),
                              radius: 26.0,
                            ),

                          ),
                         /* Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.statuses[index].titre,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showStatus(BuildContext context, StatusModel status) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
          children: [
          Image.network(
            "${APIConstants.IMG_BASE_URL}${ status.image}"
         ,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.contain,
      ),
    Positioned(
    top: 30,
    left: 10,
    child: GestureDetector(
    onTap: () {
    Navigator.pop(context);
    _startTimer();
    },
    child: CircleAvatar(
    radius: 15,
    backgroundColor: Colors.white,
    child: Icon(
    Icons.arrow_back,
    size: 20,
    color: Colors.black,
    ),
    ),
    ),
    ),

      ])
          );  }));









  }  }
