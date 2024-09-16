import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            _ConfirmPasswordInput(),
            const SizedBox(height: 8),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.email.displayError,
    );

    return TextField(
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
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
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.password.displayError,
    );

    return TextField(
      key: const Key('signUpForm_passwordInput_textField'),
      onChanged: (password) =>
          context.read<SignUpCubit>().passwordChanged(password),
      obscureText: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
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
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.confirmedPassword.displayError,
    );

    return TextField(
      key: const Key('signUpForm_confirmedPasswordInput_textField'),
      onChanged: (confirmPassword) =>
          context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
      obscureText: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
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
        labelText: 'confirm password',
        helperText: '',
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        errorText: displayError != null ? 'passwords do not match' : null,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (SignUpCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (SignUpCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('signUpForm_continue_raisedButton'),
      onPressed: () {
        if (isValid) {
          context.read<SignUpCubit>().signUpFormSubmitted();
        } else {
          return null;
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(left: 50, right: 50),
        backgroundColor: secondryColor,
        textStyle: TextStyle(color: Colors.white),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4.0,
      ),
      // onPressed: isValid
      //     ? () => context.read<SignUpCubit>().signUpFormSubmitted()
      //     : null,
      child: const Text('SIGN UP'),
    );
  }
}
