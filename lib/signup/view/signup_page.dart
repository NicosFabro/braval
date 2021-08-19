import 'package:authentication_repository/authentication_repository.dart';
import 'package:braval/signup/cubit/signup_cubit.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:team_repository/team_repository.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => SignUpCubit(
            context.read<AuthenticationRepository>(),
            context.read<ProfileRepository>(),
            context.read<TeamRepository>(),
          ),
          child: const SignUpView(),
        ),
      ),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Error al crear el usuario')),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              BravalSnackBars.successSnackBar(
                'Se ha creado el usuario',
                titleStyle: Theme.of(context).textTheme.subtitle1!,
                descriptionStyle: Theme.of(context).textTheme.subtitle2!,
              ),
            );
          Navigator.of(context).pop();
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Registro', style: theme.textTheme.headline1),
              BravalSpaces.elementsSeparator,
              _EmailInput(),
              BravalSpaces.elementsSeparator,
              _NameInput(),
              BravalSpaces.elementsSeparator,
              _SurnameInput(),
              BravalSpaces.elementsSeparator,
              _PasswordInput(),
              BravalSpaces.elementsSeparator,
              _ConfirmPasswordInput(),
              BravalSpaces.elementsSeparator,
              _SportInput(),
              BravalSpaces.elementsSeparator,
              _TeamInput(),
              BravalSpaces.elementsSeparator,
              _RoleInput(),
              BravalSpaces.elementsSeparator,
              _LoginButton(),
              BravalSpaces.elementsSeparator,
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return BravalTextInput(
          label: 'Email',
          hint: 'nicos@example.com',
          inputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          errorText: state.email.invalid ? 'Email inválido' : null,
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return BravalTextInput(
          label: 'Nombre',
          hint: 'Nicos',
          inputType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
          errorText: state.email.invalid ? 'Nombre inválido' : null,
        );
      },
    );
  }
}

class _SurnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return BravalTextInput(
          label: 'Apellido',
          hint: 'Fabro',
          inputType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: (surname) =>
              context.read<SignUpCubit>().surnameChanged(surname),
          errorText: state.email.invalid ? 'Apellido inválido' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return BravalTextInput(
          label: 'Contraseña',
          hint: '*********',
          inputType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          obscureText: true,
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          errorText: state.password.invalid ? 'Contraseña inválida' : null,
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return BravalTextInput(
          label: 'Confirmar contraseña',
          hint: '*********',
          inputType: TextInputType.visiblePassword,
          obscureText: true,
          onChanged: (password) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(password),
          errorText: state.confirmedPassword.invalid
              ? 'Las contraseñas no coinciden'
              : null,
        );
      },
    );
  }
}

class _SportInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.sport != current.sport,
      builder: (context, state) {
        return BravalDropdownButton(
          label: 'Deporte',
          value: context.read<SignUpCubit>().state.sport,
          onChanged: (sport) => context.read<SignUpCubit>().sportChanged(sport),
          items: ['football', 'basket']
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e.translateSport()),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _TeamInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.team != current.team,
      builder: (context, state) {
        return BravalDropdownButton(
          label: 'Categoria',
          value: context.read<SignUpCubit>().state.team,
          onChanged: (team) => context.read<SignUpCubit>().teamChanged(team),
          items: ['juv', 'cad', 'inf']
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e.team()),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _RoleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.role != current.role,
      builder: (context, state) {
        return BravalDropdownButton(
          label: 'Rol',
          value: context.read<SignUpCubit>().state.role,
          onChanged: (role) => context.read<SignUpCubit>().roleChanged(role),
          items: ['coach', 'delegate']
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e.role()),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        '¿Ya tienes cuenta? Haz clic aquí para iniciar sesión',
        style: theme.textTheme.subtitle2,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: state.status.isValidated
                ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                : null,
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator()
                : const Text('REGISTRARSE'),
          ),
        );
      },
    );
  }
}

extension StringExtension on String {
  String translateSport() {
    switch (this) {
      case 'football':
        return 'Fútbol';
      case 'basket':
        return 'Básquet';
      default:
        return '';
    }
  }

  String team() {
    switch (this) {
      case 'juv':
        return 'Juvenil';
      case 'cad':
        return 'Cadete';
      case 'inf':
        return 'Infantil';
      default:
        return '';
    }
  }

  String role() {
    switch (this) {
      case 'coach':
        return 'Entrenador';
      case 'delegate':
        return 'Delegado';
      default:
        return '';
    }
  }
}
