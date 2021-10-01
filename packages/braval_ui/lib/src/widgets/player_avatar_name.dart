import 'package:braval_ui/braval_ui.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:profile_repository/profile_repository.dart';

class PlayerAvatarName extends StatelessWidget {
  const PlayerAvatarName({
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
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? BravalColors.oceanGreen
                    : BravalColors.transparent,
                width: 4,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: BravalColors.whiteBackground,
              backgroundImage: profile.avatarURL == ''
                  ? null
                  : FirebaseImage(profile.avatarURL),
              child: Text(
                profile.name.substring(0, 1).toUpperCase(),
                style: BravalTextStyle.headline4.copyWith(
                  color: BravalColors.black,
                ),
              ),
            ),
          ),
          Text(profile.name, style: BravalTextStyle.bodyText1),
          Text(profile.surname, style: BravalTextStyle.bodyText1),
        ],
      ),
    );
  }
}
