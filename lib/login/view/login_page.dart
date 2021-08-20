import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

// Login
import 'package:braval/login/login.dart';

// SignUp
import 'package:braval/signup/signup.dart';

// Packages
import 'package:authentication_repository/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: const LoginView(),
        ),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              BravalSnackBars.errorSnackBar(
                'Error al crear el usuario',
                'Revisa los datos introducidos o '
                    '\nvuelve a intentarlo más tarde',
                titleStyle: Theme.of(context).textTheme.subtitle1!,
                descriptionStyle: Theme.of(context).textTheme.subtitle2!,
              ),
            );
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Login', style: theme.textTheme.headline1),
              BravalSpaces.elementsSeparator,
              _EmailInput(),
              BravalSpaces.elementsSeparator,
              _PasswordInput(),
              BravalSpaces.elementsSeparator,
              _SignUpButton(),
              BravalSpaces.elementsSeparator,
              _LoginButton(),
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return BravalTextInput(
          label: 'Email',
          hint: 'nicos@example.com',
          inputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          errorText: state.email.invalid ? 'Email inválido' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return BravalTextInput(
          label: 'Contraseña',
          hint: '*********',
          inputType: TextInputType.visiblePassword,
          obscureText: true,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: state.status.isValidated
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : null,
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator()
                : const Text('INICIAR SESIÓN'),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(
        '¿Aún no tienes cuenta? Haz clic aquí para registrarte',
        style: theme.textTheme.subtitle2,
      ),
    );
  }
}
