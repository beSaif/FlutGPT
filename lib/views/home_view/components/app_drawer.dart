import 'package:flutgpt/config/pallete.dart';
import 'package:flutgpt/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Drawer appDrawer() {
  ChatController chatController = Get.put(ChatController());
  return Drawer(
    backgroundColor: const Color(0xff202123),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: activeColor),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.add),
                    title: GetBuilder<ChatController>(builder: (context) {
                      print("prompt: ${chatController.prompt}");
                      if (chatController.summary.isNotEmpty) {
                        return Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            chatController.summary);
                      }
                      return const Text('New Chat');
                    }),
                  ),
                ),
              ),
              // const ListTile(
              //   leading: Icon(
              //     Icons.message_outlined,
              //   ),
              //   title: Text('New Chat'),
              // ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 1,
                color: activeColor,
              ),
              ListTile(
                onTap: () => chatController.clearConversation(),
                leading: const Icon(
                  Icons.delete_outline,
                ),
                title: const Text('Clear Conversation'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.wb_sunny_outlined,
                ),
                title: Text('Light Mode'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.discord,
                ),
                title: Text('OpenAI Discord'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.open_in_new,
                ),
                title: Text('Updates and FAQ'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                ),
                title: Text('Log out'),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
