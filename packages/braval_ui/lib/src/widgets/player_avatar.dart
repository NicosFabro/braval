import 'package:braval_ui/braval_ui.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:profile_repository/profile_repository.dart';

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({
    Key? key,
    required this.profile,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final Profile profile;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 60,
        backgroundColor: BravalColors.whiteBackground,
        backgroundImage:
            profile.avatarURL == '' ? null : FirebaseImage(profile.avatarURL),
        child: Text(
          profile.name.substring(0, 1).toUpperCase(),
          style: BravalTextStyle.headline1.copyWith(
            color: BravalColors.black,
          ),
        ),
      ),
    );
  }
}
