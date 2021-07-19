import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

/* 
  This widget is used on the TrackScreen to display the data of a track.
  It shows the title of what the data is, the data's value and optionally
  a CircularPercentIndicator to represent a percentage.
*/
class DataTile extends StatelessWidget {
  final String title;
  final dynamic value;
  final double width;
  final double height;
  final double elevation;
  final bool hasProgressBar;
  final Color progressBarColor;
  final Color backgroundColor;
  final Color textColor;

  DataTile({
    @required this.title,
    @required this.value,
    @required this.height,
    this.width = double.infinity,
    this.elevation = 1.0,
    this.hasProgressBar = false,
    this.progressBarColor = const Color.fromRGBO(30, 215, 96, 1),
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor == null ? Theme.of(context).cardColor : backgroundColor,
      elevation: elevation,
      shape: Border(),
      child: Container(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: textColor == null ? null : TextStyle(color: textColor),
            ),
            hasProgressBar
                ? Center(
                    child: CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: value / 100,
                      center: new Text(
                        value.toString(),
                      ),
                      circularStrokeCap: CircularStrokeCap.square,
                      progressColor: progressBarColor,
                      backgroundColor: Colors.grey[700],
                      animationDuration: 600,
                    ),
                  )
                : Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: textColor == null ? null : TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
