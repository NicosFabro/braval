import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';

class StatButton extends StatelessWidget {
  const StatButton({
    Key? key,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: const Icon(Icons.add, color: BravalColors.black, size: 50),
    );
  }
}
