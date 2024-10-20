import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/category_selection/cubit/category_cubit.dart';
import 'package:recommender_saver/forget_password.dart';
import 'package:recommender_saver/login/login.dart';
import 'package:recommender_saver/sign_up/sign_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../constants/colors.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure && state.isSubmitted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
          context.read<LoginCubit>().changeSubmittedStatus(isSubmitted: false);
          print("state.isSubmitted");
          print(state.isSubmitted);
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/bloc_logo_small.png',
                height: 120,
              ),
              const SizedBox(height: 16),
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              const SizedBox(height: 8),
              _LoginButton(),
              const SizedBox(height: 8),
              // _GoogleLoginButton(),
              // const SizedBox(height: 4),
              _ForgetPassword(),
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
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.email.displayError,
    );

    // return TextField(
    //   key: const Key('loginForm_emailInput_textField'),
    //   onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
    //   keyboardType: TextInputType.emailAddress,
    //   decoration: InputDecoration(
    //     labelText: 'email',
    //     helperText: '',
    //     errorText: displayError != null ? 'invalid email' : null,
    //   ),
    // );
    return TextField(
      key: const Key('loginForm_emailInput_textField'),
      onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      maxLines: 1,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        labelText: 'email',
        helperText: '',
        errorText: displayError != null ? 'invalid email' : null,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.password.displayError,
    );

    // return TextField(
    //   key: const Key('loginForm_passwordInput_textField'),
    //   onChanged: (password) =>
    //       context.read<LoginCubit>().passwordChanged(password),
    //   obscureText: true,
    //   decoration: InputDecoration(
    //     labelText: 'password',
    //     helperText: '',
    //     errorText: displayError != null ? 'invalid password' : null,
    //   ),
    // );

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) =>
          context.read<LoginCubit>().passwordChanged(password),
      obscureText: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      maxLines: 1,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        labelText: 'password',
        helperText: '',
        errorText: displayError != null ? 'invalid password' : null,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress)
      return const CircularProgressIndicator(
        color: Colors.white,
      );

    final isValid = context.select(
      (LoginCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: () {
        context.read<LoginCubit>().logInWithCredentials();
      },
      child: Text('LOGIN'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(left: 50, right: 50),
        backgroundColor: secondryColor,
        textStyle: TextStyle(color: Colors.white),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4.0,
      ),
    );

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: secondryColor,
          foregroundColor: Colors.amber),
      onPressed: isValid
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
      child: const Text('LOGIN'),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: theme.colorScheme.secondary,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () =>
          Navigator.of(context).push<void>(ForgotPasswordPage.route()),
      child: Text(
        'FORGET PASSWORD',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
