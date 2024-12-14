
class Message {
  const Message({
    required this.text,
  });
  final String text;
  factory Message.fromJson(json){
    return Message(text: json['message']);
  }
}