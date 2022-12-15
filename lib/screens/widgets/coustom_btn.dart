import 'package:flutter/material.dart';

class CoustomButton extends StatelessWidget {
  const CoustomButton({
    Key? key,
    required this.btnName,
    required this.onPressed,
    required this.btnColor,
  }) : super(key: key);
  final String btnName;
  final Function()? onPressed;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: btnColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            // 'Log In',
            btnName,
          ),
        ),
      ),
    );
  }
}
