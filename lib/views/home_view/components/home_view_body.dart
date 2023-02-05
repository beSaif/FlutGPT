import 'package:flutgpt/controller/chat_controller.dart';
import 'package:flutgpt/views/home_view/components/chat_card.dart';
import 'package:flutgpt/views/home_view/components/empty_state.dart';
import 'package:flutter/material.dart';
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

  final ScrollController _controller = ScrollController(keepScrollOffset: true);

// This is what you're looking for!
  void scrollDown() {
    if (_controller.position.maxScrollExtent > 0) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: chatController
                    .chats[chatController.chatIndex].messages.isEmpty
                ? const EmptyState()
                : SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: [
                        ListView.builder(
                            // controller: _controller,
                            primary: false,
                            shrinkWrap: true,
                            itemCount: chatController
                                .chats[chatController.chatIndex]
                                .messages
                                .length,
                            itemBuilder: (context, index) {
                              final message = chatController
                                  .chats[chatController.chatIndex]
                                  .messages
                                  .reversed
                                  .toList();

                              // To scroll down to the bottom of the list after the list is built
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) => scrollDown());

                              return ChatCard(
                                messageBlock: message[index],
                              );
                            }),
                        Visibility(
                          visible: chatController.isLoading,
                          child: const LoadingCard(),
                        ),
                      ],
                    ),
                  ),
          ),
          customChatInput()
        ],
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
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 0.5,
                  blurRadius: 7,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
              color: Theme.of(context).inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: TextField(
                      enabled: !chatController.isLoading,
                      onSubmitted: (value) {
                        _handleSendPressed(controller.text);
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
                      _handleSendPressed(controller.text);
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
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 12,
              ),
            ),
            Text(
              "codeSaif",
              style: GoogleFonts.roboto(
                color: Theme.of(context).textTheme.bodyLarge!.color,
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
            style: Theme.of(context).textTheme.bodyMedium,
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //  inputBackgroundColor: Colors.red,
      sendButtonIcon: Image.asset('assets/send.png'),
    );
  }

  void _handleSendPressed(String message) {
    chatController.handleSendPressed(message);
  }
}
