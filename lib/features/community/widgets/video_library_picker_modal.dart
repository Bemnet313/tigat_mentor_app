import 'package:flutter/material.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../../core/widgets/app_card.dart';

class VideoLibraryPickerModal extends StatelessWidget {
  const VideoLibraryPickerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTokens.radiusLarge)),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppTokens.spacingMd),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTokens.textTertiary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppTokens.spacingMd),
          Text(
            "Select Course Video",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppTokens.spacingMd),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppTokens.spacingMd),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppTokens.spacingMd,
                mainAxisSpacing: AppTokens.spacingMd,
                childAspectRatio: 0.8,
              ),
              itemCount: MockData.publishedVideos.length,
              itemBuilder: (context, index) {
                final video = MockData.publishedVideos[index];
                return _buildVideoCard(context, video);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context, Map<String, dynamic> video) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          Navigator.pop(context, video);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTokens.radiusCard)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(video['thumbnail'], fit: BoxFit.cover),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.play_arrow, color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          video['duration'],
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTokens.spacingMd),
              child: Text(
                video['title'],
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
