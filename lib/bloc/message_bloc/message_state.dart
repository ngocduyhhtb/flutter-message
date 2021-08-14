part of 'message_bloc.dart';

class MessageState {
  final List<Message> listMessage;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  MessageState(
      {required this.listMessage,
      required this.isLoading,
      required this.isSuccess,
      required this.isFailure});

  factory MessageState.Initial() => MessageState(
      listMessage: [], isLoading: false, isSuccess: false, isFailure: false);

  factory MessageState.Loading() => MessageState(
      listMessage: [], isLoading: true, isSuccess: false, isFailure: false);

  factory MessageState.Success({required List<Message> listMessage}) =>
      MessageState(
          listMessage: listMessage,
          isLoading: false,
          isSuccess: true,
          isFailure: false);

  factory MessageState.Failure() => MessageState(
      listMessage: [], isLoading: false, isSuccess: false, isFailure: true);
}
