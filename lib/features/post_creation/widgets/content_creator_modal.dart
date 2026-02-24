import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class ContentCreatorModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
    
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppTheme.radiusCard),
          topRight: Radius.circular(AppTheme.radiusCard),
        ),
      ),
      margin: const EdgeInsets.only(top: kToolbarHeight),
      padding: EdgeInsets.fromLTRB(AppTheme.spacingMd, AppTheme.spacingMd, AppTheme.spacingMd, bottomInset + AppTheme.spacingMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          _buildHeader(context),
          const Divider(),
          _buildDestinationToggle(),
          const SizedBox(height: AppTheme.spacingMd),
          _buildContentTypePicker(),
          const SizedBox(height: AppTheme.spacingMd),
          Flexible(
            child: SingleChildScrollView(
              child: _buildDynamicContentEditor(),
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          _buildPinToggle(),
          const SizedBox(height: AppTheme.spacingMd),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post Published Successfully!')),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryStatusGreen,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Post', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _buildDestinationToggle() {
    return Row(
      children: [
        Text('Post to: ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedDestination,
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

  Widget _buildContentTypePicker() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _contentTypes.length,
        itemBuilder: (context, index) {
          final type = _contentTypes[index];
          final isSelected = _selectedContentType == type['label'];
          return Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacingSm),
            child: ChoiceChip(
              label: Row(
                children: [
                  Icon(type['icon'], size: 16, color: isSelected ? Colors.white : AppTheme.textPrimary),
                  const SizedBox(width: 4),
                  Text(type['label'], style: TextStyle(color: isSelected ? Colors.white : AppTheme.textPrimary)),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedContentType = type['label']);
              },
              selectedColor: AppTheme.primaryStatusGreen,
              backgroundColor: AppTheme.backgroundLight,
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
      activeThumbColor: AppTheme.primaryStatusGreen,
      activeTrackColor: AppTheme.primaryStatusGreen.withValues(alpha: 0.3),
      onChanged: (bool value) {
        setState(() {
          _isPinned = value;
        });
      },
    );
  }

  Widget _buildDynamicContentEditor() {
    switch (_selectedContentType) {
      case 'Image':
        return Column(
          children: [
            _buildTextField(),
            const SizedBox(height: AppTheme.spacingMd),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(AppTheme.radiusCard),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate, size: 40, color: AppTheme.textSecondary),
                  SizedBox(height: 8),
                  Text('Tap to select an image (Max 1)'),
                ],
              ),
            ),
          ],
        );
      case 'Poll':
        return Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Ask a question...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: AppTheme.spacingSm),
            _buildPollOptionField('Option 1'),
            _buildPollOptionField('Option 2'),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: AppTheme.primaryStatusGreen),
              label: const Text('Add Option', style: TextStyle(color: AppTheme.primaryStatusGreen)),
            ),
          ],
        );
      case 'Voice':
        return Container(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          alignment: Alignment.center,
          child: Column(
            children: [
              const Icon(Icons.mic, size: 64, color: AppTheme.statusRed),
              const SizedBox(height: AppTheme.spacingMd),
              const Text('00:00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: AppTheme.spacingLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
                  FloatingActionButton(
                    backgroundColor: AppTheme.statusRed,
                    onPressed: () {},
                    child: const Icon(Icons.stop, color: Colors.white),
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
            const SizedBox(height: AppTheme.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(AppTheme.radiusInput),
              ),
              child: const Row(
                children: [
                  Icon(Icons.video_library, color: AppTheme.textSecondary),
                  SizedBox(width: AppTheme.spacingMd),
                  Expanded(child: Text('Pick from Web-Uploaded Library')),
                  Icon(Icons.chevron_right),
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
    return TextField(
      decoration: InputDecoration(
        hintText: 'What\'s on your mind?',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppTheme.radiusInput)),
      ),
      maxLines: 5,
    );
  }

  Widget _buildPollOptionField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppTheme.radiusInput)),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd, vertical: AppTheme.spacingSm),
        ),
      ),
    );
  }
}
