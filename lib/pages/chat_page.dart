import 'package:chatapplaction/constants.dart';
import 'package:chatapplaction/models/message.dart';
import 'package:chatapplaction/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static String id = "ChatPage";

  final _conroller = ScrollController();
  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kprimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            Text(' Chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                reverse: true,
                controller: _conroller,
                itemCount: messagesList.length,
                itemBuilder: (context, index) {
                  return messagesList[index].id == email
                      ? ChatBuble(
                          message: messagesList[index],
                        )
                      : ChatBubleForFriend(message: messagesList[index]);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                controller.clear();
                _conroller.animateTo(0,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(
                  Icons.send,
                  color: kprimaryColor,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: kprimaryColor,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
