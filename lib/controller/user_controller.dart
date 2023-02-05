import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserController {
  static const _user = types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  static types.User get user => _user;

  static const _chatGPTId = types.User(
      id: "chatGPTId",
      imageUrl:
          'https://github.com/beSaif/FlutGPT/blob/develop/assets/chatgpt_logo.png?raw=true');
  static types.User get chatGPTId => _chatGPTId;
}
