import 'package:flutter/material.dart';

class DataTile extends StatelessWidget {
  final String title;
  final dynamic value;
  final double height;

  DataTile({
    @required this.title,
    @required this.value,
    @required this.height,
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
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
