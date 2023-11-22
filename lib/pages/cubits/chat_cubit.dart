import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';
import '../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  void sendMessage({required String message, required String email}) {
    try {
      messages
          .add({kMessage: message, kCreatedAt: DateTime.now(), 'id': email});
    } on Exception catch (e) {}

    void getMessages() {
      messages
          .orderBy(kCreatedAt, descending: true)
          .snapshots()
          .listen((event) {
        List<Message> messagesList = [];
        for (var doc in event.docs) {
          messagesList.add(Message.fromJson(doc));
        }
        emit(ChatSuccess(messages: messagesList));
      });
    }
  }
}
