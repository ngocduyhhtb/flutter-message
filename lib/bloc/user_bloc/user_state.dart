part of 'user_bloc.dart';

class UserState {
  final String userEmail;
  final String userPhotoUrl;
  final String displayName;
  final bool isLoading;
  final bool isSuccess;
  final bool isHasEmail;
  final bool isFailure;

  UserState(
      {required this.userEmail,
      required this.isHasEmail,
      required this.isLoading,
      required this.isSuccess,
      required this.isFailure,
      required this.userPhotoUrl,
      required this.displayName});

  factory UserState.initial() => UserState(
      userEmail: "",
      userPhotoUrl: "",
      isHasEmail: false,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      displayName: "");

  factory UserState.isLoading() => UserState(
      userEmail: "",
      userPhotoUrl: "",
      isHasEmail: false,
      isLoading: true,
      isSuccess: false,
      isFailure: false,
      displayName: "");

  factory UserState.isSuccess(
          {required String displayName,
          required String userEmail,
          required String userPhotoUrl}) =>
      UserState(
          userEmail: userEmail,
          userPhotoUrl: userPhotoUrl,
          isHasEmail: true,
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          displayName: displayName);

  factory UserState.isFailure() => UserState(
      userEmail: "",
      userPhotoUrl: "",
      isHasEmail: false,
      isLoading: false,
      isSuccess: false,
      isFailure: true,
      displayName: "");
}
