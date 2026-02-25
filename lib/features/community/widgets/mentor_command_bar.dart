import 'package:flutter/material.dart';
import '../../../core/design/tokens.dart';
import 'video_library_picker_modal.dart';

class MentorCommandBar extends StatefulWidget {
  const MentorCommandBar({super.key});

  @override
  State<MentorCommandBar> createState() => _MentorCommandBarState();
}

class _MentorCommandBarState extends State<MentorCommandBar> {
  bool _isTrayOpen = false;
  final TextEditingController _controller = TextEditingController();

  void _toggleTray() {
    setState(() {
      _isTrayOpen = !_isTrayOpen;
    });
  }

  void _openVideoPicker() {
    _toggleTray();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoLibraryPickerModal(),
    ).then((selectedVideo) {
      if (selectedVideo != null) {
        // Handle selected video (e.g. insert rich media bubble)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Attached Video: ${selectedVideo['title']}')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isTrayOpen)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg, vertical: AppTokens.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              border: const Border(
                top: BorderSide(color: AppTokens.borderSubtle),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTrayIcon(Icons.image, "Image", () {}),
                _buildTrayIcon(Icons.picture_as_pdf, "PDF", () {}),
                _buildTrayIcon(Icons.link, "Link", () {}),
                _buildTrayIcon(Icons.mic, "Voice", () {}),
                _buildTrayIcon(Icons.video_library, "Video", _openVideoPicker),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.all(AppTokens.spacingMd),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            border: const Border(top: BorderSide(color: AppTokens.borderSubtle)),
          ),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    _isTrayOpen ? Icons.close : Icons.add_circle_outline,
                    color: AppTokens.primaryOlive,
                  ),
                  onPressed: _toggleTray,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                    ),
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: AppTokens.spacingMd, vertical: AppTokens.spacingMd),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTokens.spacingSm),
                Container(
                  decoration: const BoxDecoration(
                    color: AppTokens.primaryOlive,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: AppTokens.backgroundLight, size: 20),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrayIcon(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppTokens.spacingMd),
            decoration: BoxDecoration(
              color: AppTokens.primaryOlive.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTokens.primaryOlive),
          ),
          const SizedBox(height: AppTokens.spacingXs),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
