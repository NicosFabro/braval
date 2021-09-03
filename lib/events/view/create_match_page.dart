import 'package:braval/calendar/events_bloc/events_bloc.dart';
import 'package:braval/profile/bloc/profile_bloc.dart';
import 'package:braval/team/team.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:braval/events/match_cubit/match_cubit.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

class CreateEditMatchPage extends StatefulWidget {
  const CreateEditMatchPage({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  static Route<CreateEditMatchPage> route({required DateTime date}) =>
      MaterialPageRoute<CreateEditMatchPage>(
        builder: (_) => BlocProvider(
          create: (context) => MatchCubit(
            context.read<CalendarRepository>(),
            date: date,
            hour: TimeOfDay.fromDateTime(date),
            rival: const Rival.pure(),
            address: const Address.pure(),
            isLocal: false,
            lineup: [],
          ),
          child: CreateEditMatchPage(date: date),
        ),
      );

  @override
  _CreateEditMatchPageState createState() => _CreateEditMatchPageState();
}

class _CreateEditMatchPageState extends State<CreateEditMatchPage> {
  Future<DateTime?> _showDatePicker(DateTime? date) async {
    return showDatePicker(
      context: context,
      firstDate: DateTime.utc(2021, 8),
      lastDate: DateTime.utc(2022, 8, 31),
      initialDate: date ?? DateTime.now(),
    );
  }

  Future<TimeOfDay?> _showTimePicker() async {
    return showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 00),
    );
  }

  Future<void> _onSave() async {
    final teamId = context.read<ProfileBloc>().state.profile.currentTeam;
    await context.read<MatchCubit>().saveMatch(teamId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear partio')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BravalSpaces.horizontal),
        child: BlocConsumer<MatchCubit, MatchState>(
          listener: (context, state) {
            if (state.status == FormzStatus.submissionSuccess) {
              final teamId =
                  context.read<ProfileBloc>().state.profile.currentTeam;
              context.read<EventsBloc>().add(EventsFetchRequested(teamId));
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final cubit = context.read<MatchCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BravalTextInput(
                  label: 'Rival',
                  hint: 'Ej: Escola Anna Ravell',
                  textInputAction: TextInputAction.next,
                  onChanged: cubit.rivalChanged,
                ),
                BravalSpaces.elementsSeparator,
                BravalTextInput(
                  label: 'Dirección',
                  hint: 'Ej: Carrer de Blasco de Garay, 52, 08004 Barcelona',
                  inputType: TextInputType.streetAddress,
                  onChanged: cubit.addressChanged,
                ),
                BravalSpaces.elementsSeparator,
                Row(
                  children: [
                    Text('Local', style: BravalTextStyle.headline6),
                    Checkbox(
                      value: cubit.state.isLocal,
                      onChanged: cubit.isLocalChanged,
                      activeColor: BravalColors.shark,
                      checkColor: BravalColors.oceanGreen,
                    ),
                  ],
                ),
                BravalSpaces.elementsSeparator,
                Text('Fecha', style: BravalTextStyle.headline6),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    final date = await _showDatePicker(state.date);
                    if (date == null) return;

                    cubit.emit(state.copyWith(date: date));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: BravalColors.shark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      DateFormat('dd MMM yyyy', 'es').format(state.date),
                    ),
                  ),
                ),
                BravalSpaces.elementsSeparator,
                Text('Hora', style: BravalTextStyle.headline6),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    final time = await _showTimePicker();
                    if (time == null) return;

                    cubit.emit(state.copyWith(hour: time));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: BravalColors.shark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(state.hour.format(context)),
                  ),
                ),
                BravalSpaces.elementsSeparator,
                Text('Convocatoria', style: BravalTextStyle.headline6),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: context
                      .read<ProfileBloc>()
                      .state
                      .teamPlayersProfiles
                      .length,
                  itemBuilder: (context, i) {
                    final profile = context
                        .read<ProfileBloc>()
                        .state
                        .teamPlayersProfiles[i];
                    return PlayerAvatar(
                      profile: profile,
                      isSelected: state.lineup.contains(profile.id),
                      onTap: () {
                        setState(() {
                          if (state.lineup.contains(profile.id)) {
                            state.lineup.remove(profile.id);
                          } else {
                            state.lineup.add(profile.id);
                          }
                        });
                      },
                    );
                  },
                ),
                BravalSpaces.elementsSeparator,
                Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: _onSave,
                        child: state.status == FormzStatus.submissionInProgress
                            ? const CircularProgressIndicator()
                            : const Text('GUARDAR'),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
