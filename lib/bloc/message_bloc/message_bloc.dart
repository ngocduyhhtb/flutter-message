import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/repository/message/message_repository.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageState.Initial());
  final _messageRepository = MessageRepository();
  final _logger = Logger();

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadInboxMessage) {
      yield* _mapLoadInboxMessageToState();
    }else if(event is LoadSentMessage){
      yield* _mapLoadSentMessageToState();
    }
  }

  Stream<MessageState> _mapLoadInboxMessageToState() async* {
    yield MessageState.Loading();
    try {
      MessageList messageList = await _messageRepository.loadAllInboxMessage();
      yield MessageState.Success(listMessage: messageList.listMessage);
    } catch (error) {
      MessageState.Failure();
      _logger.e(error);
    }
  }
  Stream<MessageState> _mapLoadSentMessageToState() async*{
    yield MessageState.Loading();
    try{
      MessageList messageList = await _messageRepository.loadAllSentMessage();
      yield MessageState.Success(listMessage: messageList.listMessage);
    }catch (error) {
      MessageState.Failure();
      _logger.e(error);
    }
  }
}
