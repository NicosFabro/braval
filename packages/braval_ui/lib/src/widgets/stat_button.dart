import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';

class StatButton extends StatelessWidget {
  const StatButton({
    Key? key,
    required this.color,
    required this.onTap,
    required this.enabled,
  }) : super(key: key);

  final Color color;
  final Function() onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: enabled ? color : color.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: const Icon(Icons.add, color: BravalColors.black, size: 50),
      ),
    );
  }
}
