import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';

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
