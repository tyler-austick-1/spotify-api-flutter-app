import 'package:flutter/material.dart';

/* 
  This widget is a button with a CircularProgressIndicator as the 'icon'
  to indicate loading.
*/
class LoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      margin: EdgeInsets.only(
        right: 4.0,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 215, 96, 1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
