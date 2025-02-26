import 'package:flutter/material.dart';
import 'package:navigation_screens/provider/screen2_provider.dart';
import 'package:navigation_screens/screens/chat_scren.dart';
import 'package:provider/provider.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatListProvider(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'HALODEK',
              style: TextStyle(
                color: Color.fromARGB(255, 238, 110, 36),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.grey[700], size: 24),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.grey[700], size: 24),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 220, 209),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: const Color(0xFFFF6F2E),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFFFF6F2E),
                  indicatorPadding: const EdgeInsets.symmetric(
                    horizontal: -48,
                    vertical: 2,
                  ),
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 3,
                  ),
                  tabs: const [
                    Tab(text: 'Chat'),
                    Tab(text: 'Status'),
                    Tab(text: 'Calls'),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              buildChatList(context),
              buildStatusView(),
              buildCallsView(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add, color: Colors.white),
            hoverColor: Colors.orangeAccent,
            elevation: 6,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }

  Widget buildChatList(BuildContext context) {
    return Consumer<ChatListProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: ListView.separated(
            itemCount: provider.chatItems.length,
            separatorBuilder: (context, index) => const Column(
              children: [
                Divider(
                  color: Color.fromARGB(255, 200, 200, 200),
                  thickness: 1.0,
                  indent: 80,
                  endIndent: 20,
                ),
                SizedBox(height: 8),
              ],
            ),
            itemBuilder: (context, index) {
              final item = provider.chatItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(item.avatar),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    item.isTyping ? "Typing..." : item.message,
                    style: TextStyle(
                      color: item.isTyping ? Colors.orange : Colors.grey[600],
                      fontStyle:
                          item.isTyping ? FontStyle.italic : FontStyle.normal,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.time,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (item.unreadCount > 0)
                        Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            item.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      else if (item.isRead)
                        const Icon(
                          Icons.done_all,
                          color: Colors.orange,
                          size: 20,
                        ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(contactName: item.name),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildStatusView() => const Center(child: Text("No status updates"));

  Widget buildCallsView() => const Center(child: Text("No recent calls"));
}