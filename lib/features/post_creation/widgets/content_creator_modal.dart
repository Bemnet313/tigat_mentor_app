import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/motion.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../posts/models/post_model.dart';
import '../../posts/providers/posts_provider.dart';
import 'post_video_library_picker.dart';
import '../screens/ai_content_lab_screen.dart';

class ContentCreatorModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0x00000000),
      builder: (context) => const _CreatePostView(),
    );
  }
}

class _CreatePostView extends StatefulWidget {
  const _CreatePostView();

  @override
  State<_CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<_CreatePostView> {
  // ── Updated destinations: no "Global Feed"
  String _selectedDestination = 'My Profile';
  String _selectedContentType = 'Text';
  bool _isPinned = false;

  // Selected video from the library picker
  Map<String, dynamic>? _selectedVideo;
  
  // Content returned from AI Lab
  Map<String, dynamic>? _aiLabContent;

  final List<String> _destinations = [
    'My Profile',
    'Expert Circle',
    'Student Q&A',
    'Announcements',
    'General',
  ];

  // Index 0 = AI Magic Wand, then media types
  final List<Map<String, dynamic>> _contentTypes = [
    {'label': 'AI', 'icon': Icons.auto_awesome, 'isAI': true},
    {'label': 'Text', 'icon': Icons.text_fields, 'isAI': false},
    {'label': 'Image', 'icon': Icons.image, 'isAI': false},
    {'label': 'Poll', 'icon': Icons.poll, 'isAI': false},
    {'label': 'Voice', 'icon': Icons.mic, 'isAI': false},
    {'label': 'PDF/Link', 'icon': Icons.link, 'isAI': false},
    {'label': 'Video', 'icon': Icons.video_library, 'isAI': false},
  ];

  // ── Video library picker ──────────────────────────────────────────────────
  Future<void> _openVideoLibrary() async {
    final result = await PostVideoLibraryPicker.show(context);
    if (result != null && mounted) {
      setState(() {
        _selectedVideo = result;
        _selectedContentType = 'Video';
      });
    }
  }

  // ── AI button handler ─────────────────────────────────────────────────────
  Future<void> _openAiContentLab() async {
    final result = await AiContentLab.show(context);

    if (result != null && mounted) {
      setState(() {
        _aiLabContent = result;
        if (result['type'] == 'image') {
          _selectedContentType = 'Image';
        } else if (result['type'] == 'voice') {
          _selectedContentType = 'Voice';
        } else {
          _selectedContentType = 'Text';
        }
      });
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? Theme.of(context).colorScheme.surface
        : AppTokens.backgroundLight;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppTokens.radiusCard),
          topRight: Radius.circular(AppTokens.radiusCard),
        ),
      ),
      margin: const EdgeInsets.only(top: kToolbarHeight),
      padding: EdgeInsets.fromLTRB(
        AppTokens.spacingMd,
        AppTokens.spacingMd,
        AppTokens.spacingMd,
        bottomInset + AppTokens.spacingMd,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: AppTokens.spacingMd),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: AppTokens.borderSubtle,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          _buildHeader(context),
          const Divider(),
          _buildDestinationToggle(context),
          const SizedBox(height: AppTokens.spacingMd),
          _buildContentTypePicker(context),
          const SizedBox(height: AppTokens.spacingMd),
          Flexible(
            child: SingleChildScrollView(
              child: _buildDynamicContentEditor(context),
            ),
          ),
          const SizedBox(height: AppTokens.spacingMd),
          _buildPinToggle(),
          const SizedBox(height: AppTokens.spacingMd),
          _buildPublishButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Create Post',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildDestinationToggle(BuildContext context) {
    return Row(
      children: [
        Text(
          'Post to: ',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: AppTokens.spacingSm),
        Expanded(
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedDestination,
            dropdownColor: Theme.of(context).colorScheme.surface,
            style: Theme.of(context).textTheme.bodyMedium,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => _selectedDestination = newValue);
              }
            },
            items: _destinations
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(_destinationIcon(value),
                            size: 16, color: AppTokens.primaryOlive),
                        const SizedBox(width: 8),
                        Text(value),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  IconData _destinationIcon(String dest) {
    switch (dest) {
      case 'My Profile':
        return Icons.person_outline;
      case 'Expert Circle':
        return Icons.stars_outlined;
      case 'Student Q&A':
        return Icons.quiz_outlined;
      case 'Announcements':
        return Icons.campaign_outlined;
      case 'General':
        return Icons.public_outlined;
      default:
        return Icons.public_outlined;
    }
  }

  Widget _buildContentTypePicker(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppTokens.backgroundLight : AppTokens.textPrimary;
    final surfaceColor =
        isDark ? AppTokens.overlayLight : AppTokens.surfaceElevated;

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _contentTypes.length,
        itemBuilder: (context, index) {
          final type = _contentTypes[index];
          final isAI = type['isAI'] as bool;
          final isSelected = _selectedContentType == type['label'];

          if (isAI) {
            return _buildAIChip(context);
          }

          return Padding(
            padding: const EdgeInsets.only(right: AppTokens.spacingSm),
            child: ChoiceChip(
              label: Row(
                children: [
                  Icon(
                    type['icon'] as IconData,
                    size: 16,
                    color: isSelected ? AppTokens.backgroundLight : textColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    type['label'] as String,
                    style: TextStyle(
                      color: isSelected
                          ? AppTokens.backgroundLight
                          : textColor,
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              onSelected: (_) {
                if (type['label'] == 'Video') {
                  // Video → open library picker, not phone gallery
                  _openVideoLibrary();
                } else {
                  setState(() => _selectedContentType = type['label'] as String);
                }
              },
              selectedColor: AppTokens.primaryOlive,
              backgroundColor: surfaceColor,
            ),
          );
        },
      ),
    );
  }

  /// Premium AI chip with olive gradient glow — always at index 0
  Widget _buildAIChip(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppTokens.spacingMd),
      child: GestureDetector(
        onTap: _openAiContentLab,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTokens.primaryOlive, Color(0xFF7D9A38)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppTokens.primaryOlive.withValues(alpha: 0.4),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppTokens.accentGlow.withValues(alpha: 0.3),
                blurRadius: 24,
                spreadRadius: 4,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.onPrimary, size: 16),
              const SizedBox(width: 6),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Theme.of(context).colorScheme.onPrimary, const Color(0xFFDDF0A0)],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: Text(
                  'AI Lab',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinToggle() {
    return SwitchListTile(
      title: const Text('Pin this post'),
      subtitle: Text('Pin to top of $_selectedDestination'),
      value: _isPinned,
      activeThumbColor: AppTokens.primaryOlive,
      activeTrackColor: AppTokens.primaryOlive.withValues(alpha: 0.3),
      onChanged: (bool value) => setState(() => _isPinned = value),
    );
  }

  Widget _buildPublishButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppTapBehavior(
        child: FilledButton(
          onPressed: () {
            final typeMap = {
              'Text': PostType.text,
              'Image': PostType.image,
              'Poll': PostType.poll,
              'Voice': PostType.voice,
              'Video': PostType.video,
              'PDF/Link': PostType.blog,
              'AI': PostType.text,
            };
            final postType = typeMap[_selectedContentType] ?? PostType.text;

            final newPost = PostModel(
              id: 'new_${DateTime.now().millisecondsSinceEpoch}',
              type: postType,
              authorName: MockData.mentorName,
              authorAvatarUrl: MockData.profileImageUrl,
              isMentor: true,
              text: _selectedVideo != null
                  ? 'Video post: ${_selectedVideo!['title']} — shared to $_selectedDestination'
                  : 'New post from $_selectedDestination — $_selectedContentType content',
              mediaUrl:
                  _selectedVideo != null ? _selectedVideo!['thumbnail'] : null,
              timestamp: DateTime.now(),
            );

            context.read<PostsProvider>().addPost(newPost);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post Published Successfully! ✨')),
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppTokens.primaryOlive,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child:
              const Text('Post', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildDynamicContentEditor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor =
        isDark ? AppTokens.overlayLight : AppTokens.surfaceElevated;

    switch (_selectedContentType) {
      case 'Voice':
        return Column(
          children: [
            _buildTextField(),
            const SizedBox(height: AppTokens.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppTokens.spacingLg),
              decoration: BoxDecoration(
                color: AppTokens.primaryOlive.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                border: Border.all(color: AppTokens.primaryOlive.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppTokens.primaryOlive,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mic, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AI Voice Script Attached',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Content from AI Lab ready for post.',
                          style: TextStyle(fontSize: 12, color: AppTokens.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => setState(() {
                      _aiLabContent = null;
                      _selectedContentType = 'Text';
                    }),
                  ),
                ],
              ),
            ),
          ],
        );
      case 'Image':
        return Column(
          children: [
            _buildTextField(),
            const SizedBox(height: AppTokens.spacingMd),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: surfaceColor,
                border: Border.all(
                    color: AppTokens.primaryOlive.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                boxShadow: AppTokens.elevatedShadow,
              ),
              child: _aiLabContent != null && _aiLabContent!['type'] == 'image'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppTokens.radiusCard - 1),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            _aiLabContent!['content'] as String,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
                              onPressed: () => setState(() => _aiLabContent = null),
                              style: IconButton.styleFrom(backgroundColor: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_photo_alternate,
                            size: 40, color: AppTokens.textSecondary),
                        const SizedBox(height: 8),
                        Text('Tap to select an image (Max 1)',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
            ),
          ],
        );

      case 'Poll':
        return Column(
          children: [
            const AppTextField(
              labelText: 'Ask a question...',
              maxLines: 2,
            ),
            const SizedBox(height: AppTokens.spacingSm),
            _buildPollOptionField('Option 1'),
            _buildPollOptionField('Option 2'),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: AppTokens.primaryOlive),
              label: const Text('Add Option',
                  style: TextStyle(color: AppTokens.primaryOlive)),
            ),
          ],
        );


      case 'Video':
        // Show selected video preview OR the "tap to pick" prompt
        return _buildVideoEditor(context, surfaceColor);

      case 'Text':
      default:
        return _buildTextField();
    }
  }

  Widget _buildVideoEditor(BuildContext context, Color surfaceColor) {
    if (_selectedVideo != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(),
          const SizedBox(height: AppTokens.spacingMd),
          // Preview card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTokens.elevatedShadow,
              border: Border.all(
                  color: AppTokens.primaryOlive.withValues(alpha: 0.4),
                  width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.network(
                    _selectedVideo!['thumbnail'] as String,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: AppTokens.surfaceElevated,
                      child: const Icon(Icons.broken_image,
                          size: 40, color: AppTokens.textTertiary),
                    ),
                  ),
                  // Overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: AppTokens.primaryOliveDark.withValues(alpha: 0.65),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.play_circle_fill,
                              color: Theme.of(context).colorScheme.onPrimary, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _selectedVideo!['title'] as String,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _selectedVideo!['duration'] as String,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Change button (top-right)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _openVideoLibrary,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.swap_horiz,
                                color: Colors.white, size: 14),
                            const SizedBox(width: 4),
                            Text('Change',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // No video selected yet
    return Column(
      children: [
        _buildTextField(),
        const SizedBox(height: AppTokens.spacingMd),
        GestureDetector(
          onTap: _openVideoLibrary,
          child: Container(
            padding: const EdgeInsets.all(AppTokens.spacingMd),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
              border: Border.all(color: AppTokens.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTokens.primaryOlive, Color(0xFF6B7E30)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.video_library_rounded,
                      color: Theme.of(context).colorScheme.onPrimary, size: 18),
                ),
                const SizedBox(width: AppTokens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pick from Library',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Select from your published course videos',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppTokens.textSecondary),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppTokens.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    String? initialText;
    if (_aiLabContent != null && _aiLabContent!['type'] == 'text') {
      initialText = _aiLabContent!['content'] as String;
    }

    return AppTextField(
      labelText: _aiLabContent != null && (_aiLabContent!['type'] == 'voice' || _aiLabContent!['type'] == 'image') 
          ? 'Add a caption...' 
          : 'What\'s on your mind?',
      maxLines: 5,
      controller: initialText != null ? TextEditingController(text: initialText) : null,
    );
  }

  Widget _buildPollOptionField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTokens.spacingSm),
      child: AppTextField(labelText: hint),
    );
  }
}
