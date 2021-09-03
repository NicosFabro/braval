import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'match_state.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(
    this._calendarRepository, {
    required DateTime date,
    required TimeOfDay hour,
    required Rival rival,
    required Address address,
    required bool isLocal,
    required List<String> lineup,
  }) : super(MatchState(
          date: date,
          hour: hour,
          rival: rival,
          address: address,
          isLocal: isLocal,
          lineup: lineup,
        ));

  final CalendarRepository _calendarRepository;

  Future<void> saveMatch(String teamId) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final match = Match(
        id: '',
        date: state.date,
        rival: state.rival.value,
        address: state.address.value,
        isLocal: state.isLocal,
        lineup: state.lineup,
      );
      await _calendarRepository.postMatch(teamId: teamId, match: match);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void rivalChanged(String value) {
    final rival = Rival.dirty(value);
    emit(state.copyWith(
      rival: rival,
      status: Formz.validate([rival, state.address]),
    ));
  }

  void addressChanged(String value) {
    final address = Address.dirty(value);
    emit(state.copyWith(
      address: address,
      status: Formz.validate([state.rival, address]),
    ));
  }

  void isLocalChanged(bool? value) {
    emit(state.copyWith(isLocal: value ?? false));
  }
}
