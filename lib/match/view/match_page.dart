import 'package:braval/team/team.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key, required this.match}) : super(key: key);

  final Match match;

  static Route<MatchPage> route({required Match match}) =>
      MaterialPageRoute<MatchPage>(builder: (_) => MatchPage(match: match));

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<Widget> _buildFootballButtons() {
    return [
      const _StatRow(label: 'Goles'),
      BravalSpaces.mediumSeparator,
      const _StatRow(label: 'Faltas'),
      BravalSpaces.mediumSeparator,
      const _StatRow(label: 'Tarjetas amarillas'),
      BravalSpaces.mediumSeparator,
      const _StatRow(label: 'Tarjetas rojas'),
    ];
  }

  List<Widget> _buildBasketballButtons() {
    return [
      const _StatRow(label: 'Tiros libres (1p)'),
      BravalSpaces.mediumSeparator,
      const _StatRow(label: 'Canastas (2p)'),
      BravalSpaces.mediumSeparator,
      const _StatRow(label: 'Triples (3p)'),
      BravalSpaces.mediumSeparator,
      const _StatRow(label: 'Faltas'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 38, left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: BravalTextStyle.headline1.copyWith(
                              color: BravalColors.oceanGreen,
                            ),
                          ),
                          Text(
                            'Braval',
                            style: BravalTextStyle.headline3.copyWith(
                              color: BravalColors.oceanGreen,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '00:00',
                        style: BravalTextStyle.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              '0',
                              style: BravalTextStyle.headline1.copyWith(
                                color: BravalColors.defeat,
                              ),
                            ),
                            Text(
                              'Escola Anna Ravell',
                              style: BravalTextStyle.headline3.copyWith(
                                color: BravalColors.defeat,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BravalSpaces.bigSeparator,
              if (context.read<TeamBloc>().state.team.sport == 'football')
                ..._buildFootballButtons()
              else
                ..._buildBasketballButtons(),
              BravalSpaces.bigSeparator,
              const _EndPartButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatButton(color: BravalColors.oceanGreen, onTap: () => null),
        Flexible(flex: 2, child: Text('0', style: BravalTextStyle.headline2)),
        Flexible(
          flex: 4,
          child: Text(
            label,
            style: BravalTextStyle.headline3,
            textAlign: TextAlign.center,
          ),
        ),
        Flexible(flex: 2, child: Text('0', style: BravalTextStyle.headline2)),
        StatButton(color: BravalColors.defeat, onTap: () => null),
      ],
    );
  }
}

class _EndPartButton extends StatelessWidget {
  const _EndPartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: OutlinedButton(
        onPressed: () => null,
        child: Text(
          'Finalizar 1er cuarto',
          style: BravalTextStyle.button.copyWith(
            color: BravalColors.oceanGreen,
          ),
        ),
      ),
    );
  }
}
