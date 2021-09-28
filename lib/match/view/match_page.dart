import 'package:braval/match/match_bloc/match_bloc.dart';
import 'package:braval/team/team.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_repository/team_repository.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key, required this.match}) : super(key: key);

  final Match match;

  static Route<MatchPage> route({required Match match}) {
    return MaterialPageRoute<MatchPage>(
      builder: (_) => BlocProvider(
        create: (context) => MatchBloc(
          context.read<TeamBloc>().state.team.sport,
        ),
        child: MatchPage(match: match),
      ),
    );
  }

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<Widget> _buildFootballButtons() {
    return [
      const _EventRow(label: 'Goles'),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Faltas'),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Tarjetas amarillas'),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Tarjetas rojas'),
    ];
  }

  List<Widget> _buildBasketballButtons() {
    return [
      const _EventRow(label: 'Tiros libres (1p)'),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Canastas (2p)'),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Triples (3p)'),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Faltas'),
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
              if (context.read<TeamBloc>().state.team.sport ==
                  Team.sportFootball)
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

class _EventRow extends StatelessWidget {
  const _EventRow({Key? key, required this.label}) : super(key: key);

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
      child: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          return OutlinedButton(
            onPressed: () {
              final bloc = context.read<MatchBloc>();
              if (state.status == MatchStatus.notStarted) {
                bloc.add(StartGameRequested());
              } else {
                switch (state.status) {
                  case MatchStatus.notStarted:
                    break;
                  case MatchStatus.first:
                    bloc.add(NextStageRequested());
                    break;
                  case MatchStatus.second:
                    if (state.matchSport == Team.sportFootball) {
                      bloc.add(FinishGameRequested());
                    } else {
                      bloc.add(NextStageRequested());
                    }
                    break;
                  case MatchStatus.third:
                    bloc.add(NextStageRequested());
                    break;
                  case MatchStatus.fourth:
                    bloc.add(FinishGameRequested());
                    break;
                  case MatchStatus.finished:
                    break;
                }
              }
            },
            child: Text(
              state.status == MatchStatus.notStarted
                  ? 'Empezar partido'
                  : state.status == MatchStatus.first
                      ? 'Finalizar 1a parte'
                      : state.status == MatchStatus.second
                          ? 'Finalizar 2a parte'
                          : state.status == MatchStatus.third
                              ? 'Finalizar 3a parte'
                              : state.status == MatchStatus.fourth
                                  ? 'Finalizar 4a parte'
                                  : 'Finalizar partido',
              style: BravalTextStyle.button.copyWith(
                color: BravalColors.oceanGreen,
              ),
            ),
          );
        },
      ),
    );
  }
}
