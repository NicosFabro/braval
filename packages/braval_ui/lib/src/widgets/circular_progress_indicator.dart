import 'package:flutter/material.dart';
import 'package:braval_ui/braval_ui.dart';

class BravalCircularProgressIndicator extends StatelessWidget {
  const BravalCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: BravalColors.oceanGreen,
    );
  }
}
