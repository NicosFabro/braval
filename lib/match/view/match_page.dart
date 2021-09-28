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
      const _EventRow(label: 'Goles', event: FootballMatchEvents.goals),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Faltas', event: FootballMatchEvents.fouls),
      BravalSpaces.mediumSeparator,
      const _EventRow(
        label: 'Tarjetas amarillas',
        event: FootballMatchEvents.yellowCards,
      ),
      BravalSpaces.mediumSeparator,
      const _EventRow(
        label: 'Tarjetas rojas',
        event: FootballMatchEvents.redCards,
      ),
    ];
  }

  List<Widget> _buildBasketballButtons() {
    return [
      const _EventRow(
        label: 'Tiros libres (1p)',
        event: BasketMatchEvents.freeShot,
      ),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Canastas (2p)', event: BasketMatchEvents.shot),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Triples (3p)', event: BasketMatchEvents.triple),
      BravalSpaces.mediumSeparator,
      const _EventRow(label: 'Faltas', event: BasketMatchEvents.fouls),
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
                child: BlocBuilder<MatchBloc, MatchState>(
                  builder: (context, state) {
                    final braval = state.matchSport == Team.sportFootball
                        ? state.footballMatchEvents.braval.goals.length
                        : state.basketMatchEvents.braval.freeShot.length +
                            state.basketMatchEvents.braval.shot.length * 2 +
                            state.basketMatchEvents.braval.triple.length * 3;

                    final rival = state.matchSport == Team.sportFootball
                        ? state.footballMatchEvents.rival.goals.length
                        : state.basketMatchEvents.rival.freeShot.length +
                            state.basketMatchEvents.rival.shot.length * 2 +
                            state.basketMatchEvents.rival.triple.length * 3;
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                '$braval',
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
                                  '$rival',
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
                    );
                  },
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
  const _EventRow({
    Key? key,
    required this.label,
    required this.event,
  }) : super(key: key);

  final String label;
  final String event;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MatchBloc>();
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatButton(
              color: BravalColors.oceanGreen,
              onTap: () => bloc.add(AddBravalStatRequested(event, 0, '')),
              enabled: state.status != MatchStatus.notStarted &&
                  state.status != MatchStatus.finishedFirst &&
                  state.status != MatchStatus.finishedSecond &&
                  state.status != MatchStatus.finishedThird &&
                  state.status != MatchStatus.finished,
            ),
            Flexible(
              flex: 2,
              child: Text(
                state.matchSport == Team.sportFootball
                    ? event == FootballMatchEvents.goals
                        ? '${state.footballMatchEvents.braval.goals.length}'
                        : event == FootballMatchEvents.fouls
                            ? '${state.footballMatchEvents.braval.fouls.length}'
                            : event == FootballMatchEvents.yellowCards
                                ? '${state.footballMatchEvents.braval.yellowCards.length}'
                                : '${state.footballMatchEvents.braval.redCards.length}'
                    : event == BasketMatchEvents.freeShot
                        ? '${state.basketMatchEvents.braval.freeShot.length}'
                        : event == BasketMatchEvents.shot
                            ? '${state.basketMatchEvents.braval.shot.length}'
                            : event == BasketMatchEvents.triple
                                ? '${state.basketMatchEvents.braval.triple.length}'
                                : '${state.basketMatchEvents.braval.fouls.length}',
                style: BravalTextStyle.headline2,
              ),
            ),
            Flexible(
              flex: 4,
              child: Text(
                label,
                style: BravalTextStyle.headline3,
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              flex: 2,
              child: Text(
                state.matchSport == Team.sportFootball
                    ? event == FootballMatchEvents.goals
                        ? '${state.footballMatchEvents.rival.goals.length}'
                        : event == FootballMatchEvents.fouls
                            ? '${state.footballMatchEvents.rival.fouls.length}'
                            : event == FootballMatchEvents.yellowCards
                                ? '${state.footballMatchEvents.rival.yellowCards.length}'
                                : '${state.footballMatchEvents.rival.redCards.length}'
                    : event == BasketMatchEvents.freeShot
                        ? '${state.basketMatchEvents.rival.freeShot.length}'
                        : event == BasketMatchEvents.shot
                            ? '${state.basketMatchEvents.rival.shot.length}'
                            : event == BasketMatchEvents.triple
                                ? '${state.basketMatchEvents.rival.triple.length}'
                                : '${state.basketMatchEvents.rival.fouls.length}',
                style: BravalTextStyle.headline2,
              ),
            ),
            StatButton(
              color: BravalColors.defeat,
              onTap: () => bloc.add(AddRivalStatRequested(event, 0)),
              enabled: state.status != MatchStatus.notStarted &&
                  state.status != MatchStatus.finishedFirst &&
                  state.status != MatchStatus.finishedSecond &&
                  state.status != MatchStatus.finishedThird &&
                  state.status != MatchStatus.finished,
            ),
          ],
        );
      },
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
          String text;
          switch (state.status) {
            case MatchStatus.notStarted:
              text = 'Empezar partido';
              break;
            case MatchStatus.first:
              text = 'Finalizar 1a parte';
              break;
            case MatchStatus.finishedFirst:
              text = 'Empezar 2a parte';
              break;
            case MatchStatus.second:
              text = 'Finalizar 2a parte';
              break;
            case MatchStatus.finishedSecond:
              text = 'Empezar 3a parte';
              break;
            case MatchStatus.third:
              text = 'Finalizar 3a parte';
              break;
            case MatchStatus.finishedThird:
              text = 'Empezar 4a parte';
              break;
            case MatchStatus.fourth:
              text = 'Finalizar 4a parte';
              break;
            case MatchStatus.finished:
              text = 'Finalizar partido';
              break;
          }
          return OutlinedButton(
            onPressed: () {
              final bloc = context.read<MatchBloc>();
              if (state.status == MatchStatus.second) {
                if (state.matchSport == Team.sportFootball) {
                  bloc.add(FinishGameRequested());
                } else {
                  bloc.add(NextStageRequested());
                }
              } else {
                bloc.add(NextStageRequested());
              }
            },
            child: Text(
              text,
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
