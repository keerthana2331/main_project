// Assuming you have a ThemeProvider similar to what's used in SignupPage
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme = ThemeData(
    primaryColor: const Color(0xFF6A11CB),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF2575FC)),
  );
}

class ChatItem {
  final String name;
  final String message;
  final String avatar;
  final String time;
  final int unreadCount;
  final bool isTyping;
  final bool isRead;

  ChatItem({
    required this.name,
    required this.message,
    required this.avatar,
    required this.time,
    this.unreadCount = 0,
    this.isTyping = false,
    this.isRead = false,
  });
}

class ChatListProvider extends ChangeNotifier {
  final List<ChatItem> _chatItems = [
    ChatItem(
      name: "John Doe",
      message: "Hey, how are you doing?",
      avatar: "assets/images/avatar1.png",
      time: "12:30 PM",
      unreadCount: 2,
    ),
    ChatItem(
      name: "Jane Smith",
      message: "Can we meet tomorrow?",
      avatar: "assets/images/avatar2.png",
      time: "11:45 AM",
      isTyping: true,
    ),
    ChatItem(
      name: "Mike Johnson",
      message: "I've sent you the files",
      avatar: "assets/images/avatar3.png",
      time: "10:20 AM",
      isRead: true,
    ),
    ChatItem(
      name: "Sara Wilson",
      message: "Let's catch up soon!",
      avatar: "assets/images/avatar4.png",
      time: "Yesterday",
      unreadCount: 1,
    ),
    ChatItem(
      name: "David Brown",
      message: "Thanks for your help",
      avatar: "assets/images/avatar5.png",
      time: "Yesterday",
      isRead: true,
    ),
  ];

  List<ChatItem> get chatItems => _chatItems;
}