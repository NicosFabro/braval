import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';

enum StatsType { study, football, basket }

class PlayerStatsButton extends StatelessWidget {
  const PlayerStatsButton({
    Key? key,
    required this.type,
    required this.score,
    required this.onTap,
  }) : super(key: key);

  final StatsType type;
  final double score;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth * 0.45;

    final imagePath = type == StatsType.study
        ? 'assets/img/study.png'
        : type == StatsType.football
            ? 'assets/img/football.png'
            : 'assets/img/basket.png';

    final title = type == StatsType.study
        ? 'Estudio'
        : type == StatsType.football
            ? 'Fútbol'
            : 'Basket';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          color: BravalColors.shark,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imagePath, package: 'braval_ui'),
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: width,
              height: width,
              decoration: const BoxDecoration(
                color: BravalColors.shark,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    BravalColors.black,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(title, style: BravalTextStyle.headline6),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text('Nota:', style: BravalTextStyle.bodyText1),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Text('⭐$score', style: BravalTextStyle.headline5),
            ),
          ],
        ),
      ),
    );
  }
}
