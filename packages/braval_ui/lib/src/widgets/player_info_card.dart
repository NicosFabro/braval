import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';

class PlayerInfoCard extends StatelessWidget {
  const PlayerInfoCard({
    Key? key,
    required this.team,
    required this.position,
    required this.schoolYear,
    required this.backNumber,
  }) : super(key: key);

  final String team;
  final String position;
  final String schoolYear;
  final String backNumber;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = (screenWidth - 80) * .5;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: BravalColors.shark,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: BravalColors.tuna,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(team, style: BravalTextStyle.bodyText1),
                    Text('Equipo', style: BravalTextStyle.bodyText2),
                  ],
                ),
              ),
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: BravalColors.tuna,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(position, style: BravalTextStyle.bodyText1),
                    Text('Posición', style: BravalTextStyle.bodyText2),
                  ],
                ),
              ),
            ],
          ),
          BravalSpaces.elementsSeparator,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: BravalColors.tuna,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(schoolYear, style: BravalTextStyle.bodyText1),
                    Text('Curso', style: BravalTextStyle.bodyText2),
                  ],
                ),
              ),
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: BravalColors.tuna,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(backNumber, style: BravalTextStyle.bodyText1),
                    Text('Dorsal', style: BravalTextStyle.bodyText2),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
