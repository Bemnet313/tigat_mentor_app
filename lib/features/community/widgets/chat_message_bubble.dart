import 'package:flutter/material.dart';
import '../../../core/design/tokens.dart';

class ChatMessageBubble extends StatefulWidget {
  final Map<String, dynamic> message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  State<ChatMessageBubble> createState() => _ChatMessageBubbleState();
}

class _ChatMessageBubbleState extends State<ChatMessageBubble> with SingleTickerProviderStateMixin {
  bool _isHearted = false;
  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
       vsync: this, 
       duration: const Duration(milliseconds: 300)
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    setState(() {
      _isHearted = !_isHearted;
    });
    if (_isHearted) {
      _heartController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMentor = widget.message['isMentor'];

    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      onLongPress: () {
        if (!isMentor) {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.delete, color: AppTokens.statusRed),
                    title: const Text('Delete Message', style: TextStyle(color: AppTokens.statusRed)),
                    onTap: () => Navigator.pop(ctx),
                  ),
                  ListTile(
                    leading: const Icon(Icons.block),
                    title: const Text('Block User'),
                    onTap: () => Navigator.pop(ctx),
                  ),
                  ListTile(
                    leading: const Icon(Icons.flag),
                    title: const Text('Report'),
                    onTap: () => Navigator.pop(ctx),
                  ),
                ],
              ),
            ),
          );
        }
      },
      child: Dismissible(
        key: Key(widget.message['id']),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          // Swipe to reply logic placeholder
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Replying to message...')),
          );
          return false;
        },
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16.0),
          child: const Icon(Icons.reply, color: AppTokens.textTertiary),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppTokens.spacingMd),
          child: Row(
            mainAxisAlignment: isMentor ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMentor) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.message['avatar']),
                ),
                const SizedBox(width: AppTokens.spacingSm),
              ],
              Flexible(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTokens.spacingMd),
                      decoration: BoxDecoration(
                        color: isMentor ? AppTokens.primaryOlive : Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(AppTokens.radiusCard),
                          topRight: const Radius.circular(AppTokens.radiusCard),
                          bottomLeft: isMentor ? const Radius.circular(AppTokens.radiusCard) : const Radius.circular(0),
                          bottomRight: isMentor ? const Radius.circular(0) : const Radius.circular(AppTokens.radiusCard),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isMentor)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                widget.message['author'],
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTokens.primaryOlive,
                                ),
                              ),
                            ),
                          Text(
                            widget.message['text'],
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isMentor ? AppTokens.backgroundLight : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.message['time'],
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 10,
                                  color: isMentor ? AppTokens.backgroundLight.withValues(alpha: 0.7) : AppTokens.textTertiary,
                                ),
                              ),
                              if (_isHearted) ...[
                                const SizedBox(width: 4),
                                ScaleTransition(
                                  scale: CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 12,
                                    color: isMentor ? AppTokens.backgroundLight : AppTokens.statusRed,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isMentor) ...[
                const SizedBox(width: AppTokens.spacingSm),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.message['avatar']),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
