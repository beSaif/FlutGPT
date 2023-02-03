import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutgpt/config/pallete.dart';
import 'package:flutgpt/views/home_view/components/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final chatGPTId = const types.User(
      id: "chatGPTId",
      imageUrl:
          'https://brandlogovector.com/wp-content/uploads/2023/01/ChatGPT-Icon-Logo-PNG.png');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () {
        addChatGPTMessage("Hi, I'm ChatGPT. How can I help you?");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      theme: defaultChatTheme(),
      showUserAvatars: true,
      showUserNames: true,
      inputOptions: inputOptions(),
      customBottomWidget: customChatInput(),
      messages: _messages,
      emptyState: const EmptyState(),
      onSendPressed: _handleSendPressed,
      user: _user,
    );
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
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        //   child: Text(
        //     "FlutGPT is not endorsed by OpenAI or ChatGPT in any way. Our use of the API is governed by the OpenAI Terms of Service and Privacy Policy. We are not responsible for any misuse of the API.",
        //     textAlign: TextAlign.center,
        //     style: GoogleFonts.roboto(
        //       color: Colors.white70,
        //       fontSize: 12,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // )
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

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void addChatGPTMessage(String message) {
    final textMessage = types.TextMessage(
        author: chatGPTId,
        text: message,
        id: randomString(),
        createdAt: DateTime.now().millisecondsSinceEpoch);

    _addMessage(textMessage);
  }
}

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
