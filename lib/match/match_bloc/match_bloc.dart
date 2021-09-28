import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:equatable/equatable.dart';

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
    } else if (event is AddStatRequested) {
      yield* _mapAddStatRequestedToState(event);
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

  Stream<MatchState> _mapAddStatRequestedToState(
    AddStatRequested event,
  ) async* {}
}
