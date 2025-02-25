import 'package:flutter/material.dart';

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
  final List<Message> messages = [
    const Message(
      text: "Hi adhitya please give me feedback about my new shot?",
      time: "14:00",
      isMe: false,
    ),
    const Message(
      text: "My pleasure, please send me the link or image",
      time: "14:15",
      isMe: true,
    ),
    const Message(
      image: "assets/images/third screen.image.png",
      time: "14:25",
      isMe: false,
    ),
    const Message(
      text: "Great work! lets schedule it tomorrow",
      time: "14:28",
      isMe: true,
    ),
    const Message(
      text: "okay, got it!",
      time: "14:30",
      isMe: false,
      showReactions: true,
    ),
  ];

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
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.phone_outlined, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEDE1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Today',
              style: TextStyle(
                color: Color.fromARGB(255, 232, 87, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...messages.map((message) => buildMessageItem(message)).toList(),
      ],
    );
  }

  Widget buildMessageItem(Message message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!message.isMe) ...[
                buildMessageBubble(message),
                const SizedBox(width: 8),
                Text(
                  message.time,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ] else ...[
                Text(
                  message.time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                buildMessageBubble(message),
              ],
            ],
          ),
          if (message.showReactions) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: message.isMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (!message.isMe) const SizedBox(width: 48),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16),
                  child: buildReactionBar(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget buildMessageBubble(Message message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color:
                message.isMe ? const Color(0xFFFF6F2E) : Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(message.isMe ? 20 : 0),
              bottomRight: Radius.circular(message.isMe ? 0 : 20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.text != null)
                  Text(
                    message.text!,
                    style: TextStyle(
                      color: message.isMe ? Colors.white : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                if (message.image != null) ...[
                  if (message.text != null) const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      message.image!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReactionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 82, 12),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildReactionButton('👍'),
          const SizedBox(width: 12),
          buildReactionButton('❤️'),
          const SizedBox(width: 12),
          buildReactionButton('🔥'),
          const SizedBox(width: 12),
          buildReactionButton('+', isText: true),
        ],
      ),
    );
  }

  Widget buildReactionButton(String emoji, {bool isText = false}) {
    return GestureDetector(
      onTap: () {
        // Handle reaction
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 4),
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(
              fontSize: isText ? 18 : 20,
              color: isText ? Colors.black : Colors.black,
            ),
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
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    color: Colors.grey.shade600,
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.image_outlined),
                    color: Colors.grey.shade600,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.grey.shade600,
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        setState(() {
                          messages.add(Message(
                            text: messageController.text,
                            time: "Now",
                            isMe: true,
                          ));
                          messageController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String? text;
  final String? image;
  final String time;
  final bool isMe;
  final bool showReactions;

  const Message({
    this.text,
    this.image,
    required this.time,
    required this.isMe,
    this.showReactions = false,
  });
}
