import 'package:flutter/material.dart';
import 'package:scholar_chat/constraints/app_constraints.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';
import 'package:scholar_chat/widgets/chat_text_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});
  static String id = 'ChatView';

  final TextEditingController controller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference messages = FirebaseFirestore.instance
      .collection(AppConstraints.messagesCollectionReference);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', height: 50),
            Text('Chat', style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messages
                  .orderBy(AppConstraints.createdAtC, descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong: ${snapshot.error}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No messages found.',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  );
                }
                final List<Message> messagesList = snapshot.data!.docs.map((doc) => Message.fromJson(doc)).toList();
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data!.docs[index][AppConstraints.appUserIdC] ==
                        AppConstraints.appUserId) {
                      return ChatBuble(
                        message: snapshot.data!.docs[index]
                            [AppConstraints.messageC],
                      );
                    } else {
                      return ChatBubleFromFriend(
                        message: snapshot.data!.docs[index]
                            [AppConstraints.messageC],
                      );
                    }
                  },
                );
              },
            ),
          ),
          ChatTextFeild(
            controller: controller,
            onSubmitted: (String data) {
              if (data.trim().isNotEmpty) {
                messages.add({
                  AppConstraints.messageC: data.trim(),
                  AppConstraints.createdAtC: DateTime.now(),
                  AppConstraints.appUserIdC: AppConstraints.appUserId,
                }).then((_) {
                  controller.clear();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollingMethod();
                  });
                });
              }
            },
          ),
        ],
      ),
    );
  }

  void scrollingMethod() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 1),
      curve: Curves.ease,
    );
  }
}


/*
WidgetsBinding.instance.addPostFrameCallback((_) {
  startigScrollingMethod();
});

void startigScrollingMethod() {
  scrollController.animateTo(
    scrollController.position.maxScrollExtent, 
    duration: Duration(microseconds: 1), 
    curve: Curves.ease,
  );
}
*/