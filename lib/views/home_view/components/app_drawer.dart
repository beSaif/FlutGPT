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
                    leading: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    title: GetBuilder<ChatController>(
                        builder: (context) => Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              chatController.summary.isNotEmpty
                                  ? chatController.summary
                                  : 'New Chat',
                              style: fixedStyle,
                            )),
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
      ),
    ),
  );
}
