import 'package:flutgpt/config/pallete.dart';
import 'package:flutgpt/controller/chat_controller.dart';
import 'package:flutgpt/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Drawer appDrawer() {
  ThemeController themeController = Get.put(ThemeController());
  TextStyle fixedStyle = GoogleFonts.roboto(
    color: Colors.white,
  );
  ChatController chatController = Get.put(ChatController());
  return Drawer(
    backgroundColor: const Color(0xff202123),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: GetBuilder<ChatController>(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: chatController.chats[0].summary!.isNotEmpty,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: chatController.chats.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: activeColor),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    chatController.changeConversation(index);
                                    Get.back();
                                  },
                                  leading: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    chatController
                                            .chats[index].summary!.isNotEmpty
                                        ? chatController.chats[index].summary!
                                        : 'New Chat',
                                    style: fixedStyle,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Visibility(
                      visible: chatController
                              .chats[chatController.chats.length - 1]
                              .summary!
                              .isNotEmpty ||
                          chatController.chats.length == 1,
                      child: GestureDetector(
                        onTap: () {
                          if (chatController.chats.isNotEmpty &&
                              chatController
                                  .chats[chatController.chats.length - 1]
                                  .summary!
                                  .isNotEmpty) {
                            chatController.addChat();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: activeColor),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            title: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              'New Chat',
                              style: fixedStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    color: Colors.white,
                  ),
                  title: Text('Clear Conversation', style: fixedStyle),
                ),
                Obx(
                  () {
                    return ListTile(
                      onTap: () => themeController.changeThemeMode(),
                      leading: Icon(
                        themeController.isDarkMode.value
                            ? Icons.wb_sunny_outlined
                            : Icons.nightlight_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        themeController.isDarkMode.value
                            ? 'Light Mode'
                            : 'Dark Mode',
                        style: fixedStyle,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.discord,
                    color: Colors.white,
                  ),
                  title: Text('OpenAI Discord', style: fixedStyle),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                  ),
                  title: Text('Updates and FAQ', style: fixedStyle),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  title: Text('Log out', style: fixedStyle),
                ),
              ],
            )
          ],
        );
      }),
    ),
  );
}
