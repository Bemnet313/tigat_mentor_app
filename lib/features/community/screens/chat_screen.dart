import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/mock_data.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/mentor_command_bar.dart';

class ChatScreen extends StatelessWidget {
  final String roomId;

  const ChatScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: _buildLogo(context),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showPermissionsModal(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingMd, vertical: AppTokens.spacingLg),
              itemCount: MockData.chatMessages.length,
              itemBuilder: (context, index) {
                final message = MockData.chatMessages[index];
                return ChatMessageBubble(message: message);
              },
            ),
          ),
          const MentorCommandBar(),
        ],
      ),
    );
  }

  void _showPermissionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTokens.spacingMd),
              child: Text('Thread Permissions', style: Theme.of(context).textTheme.titleLarge),
            ),
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Everyone'),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.star, color: AppTokens.statusWarning),
              title: const Text('Premium Only'),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.shield, color: AppTokens.primaryOlive),
              title: const Text('Mentor Only'),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.visibility_off),
              title: const Text('Read-Only'),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDark 
            ? AppTokens.primaryOliveDark 
            : AppTokens.backgroundLight,
        borderRadius: BorderRadius.circular(AppTokens.radiusPill),
        border: Border.all(
          color: AppTokens.primaryOlive.withValues(alpha: isDark ? 0.4 : 0.1),
        ),
      ),
      child: Image.asset(
        'assets/images/tigat_logo.png',
        height: 20,
        fit: BoxFit.contain,
        color: isDark ? AppTokens.backgroundLight : AppTokens.primaryOlive,
        errorBuilder: (context, error, stackTrace) => Text(
          'TIGU',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: isDark ? AppTokens.backgroundLight : AppTokens.primaryOlive,
          ),
        ),
      ),
    );
  }
}
