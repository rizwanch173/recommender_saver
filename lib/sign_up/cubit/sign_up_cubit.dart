import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:recommender_saver/common/firebase_lib.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    //  await FirebaseFirestore.instance.clearPersistence();
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      UserCredential? userCredential = await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      await copyDefaultCategoriesToUser(userCredential!.user!.uid);

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

// Function to copy default categories
  Future<void> copyDefaultCategoriesToUser(String userId) async {
    // Reference to the default categories collection
    CollectionReference defaultCategories =
        FirebaseFirestore.instance.collection('default_category');

    // Reference to the user's categories collection
    CollectionReference userCategories = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('categories');

    // Get all documents from the default categories
    QuerySnapshot querySnapshot = await defaultCategories.get();

    // Batch to write all categories at once
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      // Create a new document reference for the user categories
      DocumentReference newDocRef = userCategories.doc();

      // Set data from default category to user's categories collection
      batch.set(newDocRef, doc.data());
    }

    print("new catcrated");

    // Commit the batch
    await batch.commit();
  }
}
