import 'package:braval_ui/braval_ui.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:profile_repository/profile_repository.dart';

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({
    Key? key,
    required this.profile,
    required this.onTap,
  }) : super(key: key);

  final Profile profile;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: BravalColors.oceanGreen,
            backgroundImage: profile.avatarURL == ''
                ? null
                : FirebaseImage(profile.avatarURL),
            child: Text(
              profile.name.substring(0, 1).toUpperCase(),
              style: BravalTextStyle.headline4,
            ),
          ),
          Text(
            '${profile.name} ${profile.surname}',
            style: BravalTextStyle.bodyText1,
          ),
        ],
      ),
    );
  }
}
