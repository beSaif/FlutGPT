import 'package:flutgpt/config/pallete.dart';
import 'package:flutgpt/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appBar() {
  ChatController chatController = Get.put(ChatController());
  return AppBar(
    backgroundColor: primaryColor,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: Container(
        color: activeColor,
        height: 2,
      ),
    ),
    elevation: 0,
    title: GetBuilder<ChatController>(
      builder: (context) => Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          chatController.chats[chatController.chatIndex].summary!.isNotEmpty
              ? chatController.chats[chatController.chatIndex].summary!
              : 'New Chat',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          )),
    ),
    centerTitle: true,
    titleSpacing: 0,
    actions: [
      GestureDetector(
        onTap: () {},
        child: const Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 16),
    ],
  );
}
