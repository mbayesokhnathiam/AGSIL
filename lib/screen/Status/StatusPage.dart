import 'dart:async';
import 'package:ajiledakarv/models/Status.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:flutter/material.dart';


class StatusPage extends StatefulWidget {
  final List<StatusModel> statuses;

  StatusPage ({required this.statuses});

  @override
  _StatusPageState createState() => _StatusPageState();
}
class _StatusPageState extends State<StatusPage > {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentIndex = 0;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.statuses.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                _progress = 0;
                _startTimer();
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Image.network(
                    "${APIConstants.IMG_BASE_URL}${widget.statuses[index].image}"
                    ,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 30,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
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
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.more_horiz,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1) {
          _progress = 0;
          if (_currentIndex < widget.statuses.length - 1) {
            _currentIndex++;
            _pageController.animateToPage(
              _currentIndex,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            _currentIndex = 0;
            _pageController.animateToPage(
              _currentIndex,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
