import 'package:flutgpt/model/message_model.dart';

class ConversationModel {
  String? id;
  String? prompt;
  List<MessageModel> messages = [];
  String? summary;
  bool? isSummarized;

  ConversationModel({
    this.id,
    this.prompt,
    required this.messages,
    this.summary,
    this.isSummarized,
  });

  clearConversation() {
    id = null;
    prompt = "";
    messages = [];
    summary = "";
    isSummarized = false;
  }
}
