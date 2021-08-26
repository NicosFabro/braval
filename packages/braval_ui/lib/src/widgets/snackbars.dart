import 'package:flutter/material.dart';
import 'package:braval_ui/braval_ui.dart';

abstract class BravalSnackBars {
  static SnackBar successSnackBar(
    String title, {
    String? description,
    required TextStyle titleStyle,
    required TextStyle descriptionStyle,
  }) =>
      SnackBar(
        content: SizedBox(
          height: 55,
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: BravalColors.win),
              BravalSpaces.elementsSeparator,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: titleStyle),
                  if (description != null)
                    Text(
                      description,
                      style: descriptionStyle,
                      maxLines: 2,
                      softWrap: true,
                    ),
                ],
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: BravalColors.charcoal,
      );

  static SnackBar errorSnackBar(
    String title,
    String description, {
    required TextStyle titleStyle,
    required TextStyle descriptionStyle,
  }) =>
      SnackBar(
        content: SizedBox(
          height: 55,
          child: Row(
            children: [
              const Icon(Icons.warning, color: BravalColors.defeat),
              BravalSpaces.elementsSeparator,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleStyle),
                  Text(
                    description,
                    style: descriptionStyle,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: BravalColors.charcoal,
      );
}
