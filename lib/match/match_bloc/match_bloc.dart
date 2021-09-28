import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:team_repository/team_repository.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc(String sport) : super(MatchState(matchSport: sport));

  @override
  Stream<MatchState> mapEventToState(
    MatchEvent event,
  ) async* {
    if (event is StartGameRequested) {
      yield* _mapStartGameRequestedToState(event);
    } else if (event is FinishGameRequested) {
      yield* _mapFinishGameRequestedToState(event);
    } else if (event is NextStageRequested) {
      yield* _mapNextStageRequestedToState(event);
    } else if (event is AddBravalStatRequested) {
      yield* _mapAddBravalStatRequestedToState(event);
    } else if (event is AddRivalStatRequested) {
      yield* _mapAddRivalStatRequestedToState(event);
    }
  }

  Stream<MatchState> _mapStartGameRequestedToState(
    StartGameRequested event,
  ) async* {
    yield state.copyWith(status: MatchStatus.first);
  }

  Stream<MatchState> _mapFinishGameRequestedToState(
    FinishGameRequested event,
  ) async* {
    yield state.copyWith(status: MatchStatus.finished);
  }

  Stream<MatchState> _mapNextStageRequestedToState(
    NextStageRequested event,
  ) async* {
    MatchStatus status;

    switch (state.status) {
      case MatchStatus.notStarted:
        status = MatchStatus.first;
        break;
      case MatchStatus.first:
        status = MatchStatus.second;
        break;
      case MatchStatus.second:
        status = MatchStatus.third;
        break;
      case MatchStatus.third:
        status = MatchStatus.fourth;
        break;
      case MatchStatus.fourth:
        status = MatchStatus.finished;
        break;
      case MatchStatus.finished:
        status = MatchStatus.finished;
        break;
    }

    yield state.copyWith(status: status);
  }

  Stream<MatchState> _mapAddBravalStatRequestedToState(
    AddBravalStatRequested event,
  ) async* {
    if (state.matchSport == Team.sportFootball) {
      var events = state.footballMatchEvents.braval;
      switch (event.event) {
        case FootballMatchEvents.goals:
          final goals = List.of(events.goals);
          goals.add(<String, dynamic>{
            'minute': event.minute,
            'player': event.playerId,
          });
          events = events.copyWith(goals: goals);
          break;
        case FootballMatchEvents.fouls:
          final fouls = List.of(events.fouls);
          fouls.add(<String, dynamic>{
            'minute': event.minute,
            'player': event.playerId,
          });
          events = events.copyWith(fouls: fouls);
          break;
        case FootballMatchEvents.yellowCards:
          final yellowCards = List.of(events.yellowCards);
          yellowCards.add(<String, dynamic>{
            'minute': event.minute,
            'player': event.playerId,
          });
          events = events.copyWith(yellowCards: yellowCards);
          break;
        case FootballMatchEvents.redCards:
          final redCards = List.of(events.redCards);
          redCards.add(<String, dynamic>{
            'minute': event.minute,
            'player': event.playerId,
          });
          events = events.copyWith(redCards: redCards);
          break;
      }

      yield state.copyWith(
        footballMatchEvents: state.footballMatchEvents.copyWith(braval: events),
      );
    } else {
      var events = state.basketMatchEvents.braval;
      switch (event.event) {
        case BasketMatchEvents.freeShot:
          final freeShot = List.of(events.freeShot);
          freeShot.add(<String, dynamic>{
            'minute': event.minute,
            'player': event.playerId,
          });
          events = events.copyWith(freeShot: freeShot);
          break;
        case BasketMatchEvents.shot:
          final shot = List.of(events.shot);
          shot.add(<String, dynamic>{
            'minute': event.minute,
            'player': event.playerId,
          });
          events = events.copyWith(shot: shot);
          break;
        case BasketMatchEvents.triple:
          final triple = List.of(events.triple);
          triple.add(<String, dynamic>{
            'minute': event.minute,
            'player': event.playerId,
          });
          events = events.copyWith(triple: triple);
          break;
        case BasketMatchEvents.fouls:
          final fouls = List.of(events.fouls);
          fouls.add(<String, dynamic>{
            'minute': event.minute,
            'player': event.playerId,
          });
          events = events.copyWith(fouls: fouls);
          break;
      }

      yield state.copyWith(
        basketMatchEvents: state.basketMatchEvents.copyWith(braval: events),
      );
    }
  }

  Stream<MatchState> _mapAddRivalStatRequestedToState(
    AddRivalStatRequested event,
  ) async* {
    if (state.matchSport == Team.sportFootball) {
      var events = state.footballMatchEvents.rival;
      switch (event.event) {
        case FootballMatchEvents.goals:
          final goals = List.of(events.goals);
          goals.add(event.minute);
          events = events.copyWith(goals: goals);
          break;
        case FootballMatchEvents.fouls:
          final fouls = List.of(events.fouls);
          fouls.add(event.minute);
          events = events.copyWith(fouls: fouls);
          break;
        case FootballMatchEvents.yellowCards:
          final yellowCards = List.of(events.yellowCards);
          yellowCards.add(event.minute);
          events = events.copyWith(yellowCards: yellowCards);
          break;
        case FootballMatchEvents.redCards:
          final redCards = List.of(events.redCards);
          redCards.add(event.minute);
          events = events.copyWith(redCards: redCards);
          break;
      }

      yield state.copyWith(
        footballMatchEvents: state.footballMatchEvents.copyWith(rival: events),
      );
    } else {
      var events = state.basketMatchEvents.rival;
      switch (event.event) {
        case BasketMatchEvents.freeShot:
          final freeShot = List.of(events.freeShot);
          freeShot.add(event.minute);
          events = events.copyWith(freeShot: freeShot);
          break;
        case BasketMatchEvents.shot:
          final shot = List.of(events.shot);
          shot.add(event.minute);
          events = events.copyWith(shot: shot);
          break;
        case BasketMatchEvents.triple:
          final triple = List.of(events.triple);
          triple.add(event.minute);
          events = events.copyWith(triple: triple);
          break;
        case BasketMatchEvents.fouls:
          final fouls = List.of(events.fouls);
          fouls.add(event.minute);
          events = events.copyWith(fouls: fouls);
          break;
      }

      yield state.copyWith(
        basketMatchEvents: state.basketMatchEvents.copyWith(rival: events),
      );
    }
  }
}
