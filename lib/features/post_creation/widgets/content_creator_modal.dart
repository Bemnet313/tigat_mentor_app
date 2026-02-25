import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/motion.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../posts/models/post_model.dart';
import '../../posts/providers/posts_provider.dart';

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
  String _selectedDestination = 'Global Feed';
  String _selectedContentType = 'Text';
  bool _isPinned = false;

  final List<String> _destinations = ['Global Feed', 'My Profile', 'Ask Mentor Room'];
  final List<Map<String, dynamic>> _contentTypes = [
    {'label': 'Text', 'icon': Icons.text_fields},
    {'label': 'Image', 'icon': Icons.image},
    {'label': 'Poll', 'icon': Icons.poll},
    {'label': 'Voice', 'icon': Icons.mic},
    {'label': 'PDF/Link', 'icon': Icons.link},
    {'label': 'Video', 'icon': Icons.video_library},
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).colorScheme.surface : AppTokens.backgroundLight;
    
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppTokens.radiusCard),
          topRight: Radius.circular(AppTokens.radiusCard),
        ),
      ),
      margin: const EdgeInsets.only(top: kToolbarHeight),
      padding: EdgeInsets.fromLTRB(AppTokens.spacingMd, AppTokens.spacingMd, AppTokens.spacingMd, bottomInset + AppTokens.spacingMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(
            width: double.infinity,
            child: AppTapBehavior(
              child: FilledButton(
              onPressed: () {
                // Map selected content type to PostType
                final typeMap = {
                  'Text': PostType.text,
                  'Image': PostType.image,
                  'Poll': PostType.poll,
                  'Voice': PostType.voice,
                  'Video': PostType.video,
                  'PDF/Link': PostType.blog,
                };
                final postType = typeMap[_selectedContentType] ?? PostType.text;

                final newPost = PostModel(
                  id: 'new_${DateTime.now().millisecondsSinceEpoch}',
                  type: postType,
                  authorName: MockData.mentorName,
                  authorAvatarUrl: MockData.profileImageUrl,
                  isMentor: true,
                  text: 'New post from $_selectedDestination — $_selectedContentType content',
                  timestamp: DateTime.now(),
                );

                context.read<PostsProvider>().addPost(newPost);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post Published Successfully!')),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppTokens.primaryOlive,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Post', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Create Post', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
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
        Text('Post to: ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
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
            items: _destinations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildContentTypePicker(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppTokens.backgroundLight : AppTokens.textPrimary;
    final surfaceColor = isDark ? AppTokens.overlayLight : AppTokens.surfaceElevated;

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _contentTypes.length,
        itemBuilder: (context, index) {
          final type = _contentTypes[index];
          final isSelected = _selectedContentType == type['label'];
          return Padding(
            padding: const EdgeInsets.only(right: AppTokens.spacingSm),
            child: ChoiceChip(
              label: Row(
                children: [
                  Icon(type['icon'], size: 16, color: isSelected ? AppTokens.backgroundLight : textColor),
                  const SizedBox(width: 4),
                  Text(type['label'], style: TextStyle(color: isSelected ? AppTokens.backgroundLight : textColor)),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedContentType = type['label']);
              },
              selectedColor: AppTokens.primaryOlive,
              backgroundColor: surfaceColor,
            ),
          );
        },
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
      onChanged: (bool value) {
        setState(() {
          _isPinned = value;
        });
      },
    );
  }

  Widget _buildDynamicContentEditor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppTokens.overlayLight : AppTokens.surfaceElevated;

    switch (_selectedContentType) {
      case 'Image':
        return Column(
          children: [
            _buildTextField(),
            const SizedBox(height: AppTokens.spacingMd),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: surfaceColor,
                border: Border.all(color: AppTokens.textSecondary.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_photo_alternate, size: 40, color: AppTokens.textSecondary),
                  const SizedBox(height: 8),
                  Text('Tap to select an image (Max 1)', style: Theme.of(context).textTheme.bodyMedium),
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
              label: const Text('Add Option', style: TextStyle(color: AppTokens.primaryOlive)),
            ),
          ],
        );
      case 'Voice':
        return Container(
          padding: const EdgeInsets.all(AppTokens.spacingLg),
          alignment: Alignment.center,
          child: Column(
            children: [
              const Icon(Icons.mic, size: 64, color: AppTokens.statusRed),
              const SizedBox(height: AppTokens.spacingMd),
              const Text('00:00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: AppTokens.spacingLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
                  FloatingActionButton(
                    backgroundColor: AppTokens.statusRed,
                    onPressed: () {},
                    child: const Icon(Icons.stop, color: AppTokens.backgroundLight),
                  ),
                  IconButton(icon: const Icon(Icons.play_arrow), onPressed: () {}),
                ],
              ),
            ],
          ),
        );
      case 'Video':
        return Column(
          children: [
            _buildTextField(),
            const SizedBox(height: AppTokens.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppTokens.spacingMd),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
              ),
              child: Row(
                children: [
                  const Icon(Icons.video_library, color: AppTokens.textSecondary),
                  const SizedBox(width: AppTokens.spacingMd),
                  Expanded(child: Text('Pick from Web-Uploaded Library', style: Theme.of(context).textTheme.bodyMedium)),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ],
        );
      case 'Text':
      default:
        return _buildTextField();
    }
  }

  Widget _buildTextField() {
    return const AppTextField(
      labelText: 'What\'s on your mind?',
      maxLines: 5,
    );
  }

  Widget _buildPollOptionField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTokens.spacingSm),
      child: AppTextField(
        labelText: hint,
      ),
    );
  }
}
