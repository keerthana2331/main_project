import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;

  const ChatScreen({
    Key? key,
    required this.contactName,
  }) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<File> getChatFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/chat_history.json');
  }

  Future<void> loadMessages() async {
    try {
      final file = await getChatFile();
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonData = jsonDecode(jsonString);
        setState(() {
          messages = jsonData.map((json) => Message.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print("Error loading messages: $e");
    }
  }

  Future<void> saveMessages() async {
    try {
      final file = await getChatFile();
      final jsonString =
          jsonEncode(messages.map((msg) => msg.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      print("Error saving messages: $e");
    }
  }

  void sendMessage(String text) {
    final newMessage = Message(
      text: text,
      time: "Now",
      isMe: true,
    );

    setState(() {
      messages.add(newMessage);
      messageController.clear();
    });

    saveMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBar(),
            Expanded(
              child: buildMessageList(),
            ),
            buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Colors.black54, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/avatar1.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.contactName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Typing...',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 232, 96, 32),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: messages.length,
      itemBuilder: (context, index) => buildMessageItem(messages[index]),
    );
  }

  Widget buildMessageItem(Message message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          buildMessageBubble(message),
        ],
      ),
    );
  }

  Widget buildMessageBubble(Message message) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: message.isMe ? const Color(0xFFFF6F2E) : Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(message.isMe ? 20 : 0),
          bottomRight: Radius.circular(message.isMe ? 0 : 20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          message.text ?? '',
          style: TextStyle(
            color: message.isMe ? Colors.white : Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.grey.shade600,
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                sendMessage(messageController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}

class Message {
  final String? text;
  final String time;
  final bool isMe;

  Message({this.text, required this.time, required this.isMe});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      time: json['time'],
      isMe: json['isMe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time,
      'isMe': isMe,
    };
  }
}
