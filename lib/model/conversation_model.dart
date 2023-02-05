import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ConversationModel {
  String? id;
  String? prompt;
  List<types.Message> messages = [];
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
