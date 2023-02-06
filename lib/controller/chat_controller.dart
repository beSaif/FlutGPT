import 'dart:convert';
import 'dart:math';
import 'package:flutgpt/api/api_key.dart';
import 'package:flutgpt/controller/user_controller.dart';
import 'package:flutgpt/model/conversation_model.dart';
import 'package:flutgpt/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ChatController extends GetxController {
  int _chatIndex = 0;

  // Adds a message to the current chat even if it's not the active one
  int promptIndex = 0;

  int get chatIndex => _chatIndex;
  late String chatId;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    update();
  }

  final List<ConversationModel> _chats = [];
  List<ConversationModel> get chats => _chats;

  final ConversationModel _conversation = ConversationModel(
      isSummarized: false, summary: "", prompt: "", messages: []);
  ConversationModel get conversation => _conversation;

  @override
  void onInit() {
    super.onInit();
    debugPrint("ChatController oninit");
    _chats.add(_conversation);
  }

  Future postRequestToChatGPT() async {
    final url = Uri.parse("https://api.openai.com/v1/completions");
    // Combine all the messages into a single string with \n as a separator
    var header = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "model": "text-davinci-003",
      "prompt": chats[chatIndex].prompt,
      "temperature": 0,
      "max_tokens": 500
    });
    try {
      // post request using dio
      final response = await http.post(url, headers: header, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data["choices"][0]["text"] =
            data["choices"][0]["text"].toString().trim();
        addChatGPTMessage(data["choices"][0]["text"]);
      } else {
        addErrorMessage(response);
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Error: ${response.body}");
      }
    } catch (e) {
      debugPrint("Catch Error: $e");
    }

    setLoading(false);
  }

  void handleSendPressed(String message) async {
    if (message.isEmpty) return;
    addErrorMessage(null);
    promptIndex = chatIndex;
    setLoading(true);

    final textMessage = MessageModel(
      author: UserController.user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      message: message,
    );

    _addMessage(textMessage);
    addToPrompt(textMessage.message!);
    postRequestToChatGPT();
  }

  void _addMessage(MessageModel messageBlock) {
    _chats[promptIndex].messages.insert(0, messageBlock);
    update();
  }

  void addChatGPTMessage(String message) async {
    final textMessage = MessageModel(
        author: UserController.chatGPTId,
        message: message,
        id: randomString(),
        createdAt: DateTime.now().millisecondsSinceEpoch);

    addToPrompt(textMessage.message!);
    _addMessage(textMessage);
    if (!chats[promptIndex].isSummarized!) {
      summarizeThePrompt();
      chats[promptIndex].isSummarized = true;
    }
  }

  void addToPrompt(String message) {
    chats[promptIndex].prompt = "${chats[promptIndex].prompt}$message\n";
    debugPrint("prompt: ${chats[promptIndex].prompt}");
  }

  void clearConversation() {
    if (_chats.length <= 1) {
      _chats[0].clearConversation();
    } else {
      _chats.removeAt(chatIndex);
      if (chatIndex > 1) {
        changeConversation(chatIndex - 1);
      } else {
        changeConversation(0);
      }
    }

    debugPrint("Conversation Cleared");
    update();
  }

  Future summarizeThePrompt() async {
    final url = Uri.parse("https://api.openai.com/v1/completions");
    // Combine all the messages into a single string with \n as a separator
    var header = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "model": "text-davinci-003",
      "prompt": "${chats[promptIndex].prompt}\nMake it a title",
      "temperature": 0,
      "max_tokens": 150
    });
    try {
      // post request using dio
      final response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data["choices"][0]["text"] =
            data["choices"][0]["text"].toString().trim();
        updateSummary(data["choices"][0]["text"]);
        debugPrint("summary: ${chats[promptIndex].summary}");
      } else {
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Error: ${response.body}");
      }
    } catch (e) {
      debugPrint("Catch Error: $e");
    }
  }

  void updateSummary(String newSummary) {
    _chats[promptIndex].summary = newSummary;
    update();
  }

  addChat() {
    if (chats.isNotEmpty && chats[chats.length - 1].prompt!.isNotEmpty) {
      _chats.add(ConversationModel(
          isSummarized: false, summary: "", prompt: "", messages: []));
      _chatIndex = _chats.length - 1;
      update();
    }
  }

  void changeConversation(int index) {
    _chatIndex = index;
    update();
  }

  void addErrorMessage(http.Response? response) {
    _chats[promptIndex].error = response;
    update();
  }
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
