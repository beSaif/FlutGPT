import 'dart:convert';
import 'dart:math';
import 'package:flutgpt/api/api_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatController extends GetxController {
  String prompt = "";
  final List<types.Message> _messages = [];
  bool isSummarized = false;
  String _summary = "";
  String get summary => _summary;
  List<types.Message> get messages => _messages;

  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  types.User get user => _user;

  final _chatGPTId = const types.User(
      id: "chatGPTId",
      imageUrl:
          'https://github.com/beSaif/FlutGPT/blob/main/assets/chatgpt_logo.png?raw=true');
  types.User get chatGPTId => _chatGPTId;

  Future postRequestToChatGPT() async {
    final url = Uri.parse("https://api.openai.com/v1/completions");
    // Combine all the messages into a single string with \n as a separator
    var header = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "model": "text-davinci-003",
      "prompt": prompt,
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
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    addToPrompt(textMessage.text);
    postRequestToChatGPT();
  }

  void _addMessage(types.Message message) {
    _messages.insert(0, message);
    update();
  }

  void addChatGPTMessage(String message) {
    final textMessage = types.TextMessage(
        author: chatGPTId,
        text: message,
        id: randomString(),
        createdAt: DateTime.now().millisecondsSinceEpoch);

    addToPrompt(textMessage.text);
    _addMessage(textMessage);
    if (!isSummarized) {
      summarizeThePrompt();
      isSummarized = true;
    }
  }

  void addToPrompt(String message) {
    prompt = "$prompt$message\n";
    debugPrint("prompt: $prompt");
  }

  void clearConversation() {
    prompt = "";
    _messages.clear();
    isSummarized = false;
    _summary = "";
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
      "prompt": "$prompt\nMake it a title",
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
        debugPrint("summary: $summary");
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateSummary(String newSummary) {
    _summary = newSummary;
    update();
  }
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
