import 'package:flutgpt/model/message_model.dart';
import 'package:http/http.dart';

class ConversationModel {
  String? id;
  String? prompt;
  List<MessageModel> messages = [];
  String? summary;
  bool? isSummarized;
  Response? error;

  ConversationModel({
    this.id,
    this.prompt,
    required this.messages,
    this.summary,
    this.isSummarized,
    this.error,
  });

  clearConversation() {
    id = null;
    prompt = "";
    messages = [];
    summary = "";
    isSummarized = false;
  }
}
