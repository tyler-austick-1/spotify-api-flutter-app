import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DataTile extends StatelessWidget {
  final String title;
  final dynamic value;
  final double height;
  final bool hasProgressBar;

  DataTile({
    @required this.title,
    @required this.value,
    @required this.height,
    this.hasProgressBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black38,
          ),
        ),
      ),
      // ...squaresMap.entries.map((e) => null).toList();
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 15,
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
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    circularStrokeCap: CircularStrokeCap.square,
                    progressColor: Theme.of(context).primaryColor,
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.08),
                    animationDuration: 800,
                  ),
                )
              : Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
        ],
      ),
    );
  }
}
