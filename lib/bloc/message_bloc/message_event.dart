part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class LoadInboxMessage extends MessageEvent {}
class LoadSentMessage extends MessageEvent{}