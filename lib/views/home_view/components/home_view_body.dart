import 'package:flutgpt/config/pallete.dart';
import 'package:flutgpt/controller/chat_controller.dart';
import 'package:flutgpt/views/home_view/components/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (context) {
      return Chat(
        theme: defaultChatTheme(),
        showUserAvatars: true,
        showUserNames: true,
        inputOptions: inputOptions(),
        customBottomWidget: customChatInput(),
        messages: chatController.messages,
        emptyState: const EmptyState(),
        onSendPressed: _handleSendPressed,
        user: chatController.user,
      );
    });
  }

  Column customChatInput() {
    TextEditingController controller = TextEditingController();
    return Column(
      children: [
        const Divider(
          height: 1,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: TextField(
                      onSubmitted: (value) {
                        _handleSendPressed(types.PartialText(text: value));
                      },
                      controller: controller,
                      cursorColor: Colors.white,
                      cursorRadius: const Radius.circular(5),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      _handleSendPressed(
                          types.PartialText(text: controller.text));
                    }
                  },
                  child: SizedBox(
                      height: 15,
                      width: 15,
                      child: Image.asset(
                        'assets/send.png',
                        fit: BoxFit.fitHeight,
                      )),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Powered by ",
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            Text(
              "codeSaif",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(
            "FlutGPT is not endorsed by OpenAI or ChatGPT in any way. Our use of the API is governed by the OpenAI Terms of Service and Privacy Policy. We are not responsible for any misuse of the API.",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.white70,
              fontSize: 8,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  InputOptions inputOptions() {
    return const InputOptions(
        sendButtonVisibilityMode: SendButtonVisibilityMode.always);
  }

  DefaultChatTheme defaultChatTheme() {
    return DefaultChatTheme(
      userAvatarImageBackgroundColor: Colors.white,
      backgroundColor: primaryColor,
      inputBackgroundColor: activeColor,
      sendButtonIcon: Image.asset('assets/send.png'),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    chatController.handleSendPressed(message);
  }
}
