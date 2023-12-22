import 'dart:async';
import 'package:ajiledakarv/models/Status.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class Status {
  final String title;
  final String photoUrl;


  Status( {required this.title, required this.photoUrl});
}

class StatusView extends StatefulWidget {
  final StatusModel statuses;
  final String  regionId;

  StatusView({required this.statuses,required this.regionId});

  @override
  _StatusViewSState createState() => _StatusViewSState();
}

class _StatusViewSState extends State<StatusView> {
  int _currentIndex = 0;
  Timer? _timer;
  List<StatusModel> statuses=[];

  getStories() async{
    var response;
    await  ApiService().getData("story/list/${widget.regionId}").then((value) =>{
      response=value
    });

    print(response);
    setState(() {
      statuses=StatusModel.fromJsonList(response["data"]);

    });

  }

  @override
  void initState() {
    getStories();
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    getStories();
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
            itemCount: statuses.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _stopTimer();
                  _nextStatus();
                },
                child: Image.network(
                  "${APIConstants.IMG_BASE_URL}${statuses[_currentIndex].image}",
                  fit: BoxFit.contain,
                  height: double.infinity,
                  width: double.infinity,
                ),
              );
            },
          ),
          Positioned(
            top: 50,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.close,color: Colors.red,),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < statuses.length; i++)
                  if (i == _currentIndex)
                    _buildPageIndicator(true)
                  else
                    _buildPageIndicator(false)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 6.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _nextStatus() {
    int nextIndex = (_currentIndex + 1) % statuses.length;
    setState(() {
      _currentIndex = nextIndex;
    });
    _startTimer();
  }

  void _startTimer() {
    const statusDuration = Duration(seconds: 5);
    _timer = Timer.periodic(statusDuration, (timer) {
      _nextStatus();
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null; // clear the reference to the timer
    }
  }
}
