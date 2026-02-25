import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/motion.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/theme/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  bool _hasChanges = false;
  final String _profileImageUrl = MockData.profileImageUrl;
  final String _bannerImageUrl = MockData.bannerImageUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: MockData.mentorName);
    _usernameController = TextEditingController(text: MockData.mentorUsername);
    _phoneController = TextEditingController(text: MockData.mentorPhone);
    _emailController = TextEditingController(text: MockData.mentorEmail);
    _bioController = TextEditingController(text: MockData.mentorBio);

    _nameController.addListener(_onFieldChanged);
    _usernameController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _bioController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      setState(() => _hasChanges = true);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locProvider = context.watch<LocalizationProvider>();
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? AppTokens.overlayLight : AppTokens.backgroundLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 18, color: Theme.of(context).textTheme.bodyMedium?.color ?? AppTokens.textPrimary),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          locProvider.translate('profile'),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppTokens.spacingLg),
            // Profile Picture with Edit Icon
            _buildProfileAvatar(),
            const SizedBox(height: AppTokens.spacingMd),
            // Name & Username display
            Text(
              _nameController.text,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTokens.spacingXs),
            Text(
              _usernameController.text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTokens.primaryOlive,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTokens.spacingXl),
            // Editable Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(locProvider.translate('personal_information')),
                  const SizedBox(height: AppTokens.spacingMd),
                  _buildEditableField(
                    controller: _nameController,
                    label: locProvider.translate('name'),
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: AppTokens.spacingMd),
                  _buildEditableField(
                    controller: _usernameController,
                    label: locProvider.translate('username'),
                    icon: Icons.alternate_email,
                  ),
                  const SizedBox(height: AppTokens.spacingMd),
                  _buildEditableField(
                    controller: _phoneController,
                    label: locProvider.translate('phone'),
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: AppTokens.spacingMd),
                  _buildEditableField(
                    controller: _emailController,
                    label: locProvider.translate('email'),
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppTokens.spacingXl),
                  // Bio Section
                  _buildSectionTitle(locProvider.translate('bio')),
                  const SizedBox(height: AppTokens.spacingMd),
                  _buildBioField(locProvider),
                  const SizedBox(height: AppTokens.spacingXl),
                  // Banner Section
                  _buildSectionTitle(locProvider.translate('banner_image')),
                  const SizedBox(height: AppTokens.spacingMd),
                  _buildBannerSection(),
                  const SizedBox(height: AppTokens.spacingXxl),
                  // Security Section
                  _buildSectionTitle(locProvider.translate('security')),
                  const SizedBox(height: AppTokens.spacingMd),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Change Password Flow Opened')),
                        );
                      },
                      icon: Icon(Icons.lock_outline, color: Theme.of(context).textTheme.bodyMedium?.color),
                      label: Text(
                        locProvider.translate('change_password'),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTokens.borderSubtle),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTokens.spacingXxl),
                  // App Settings Section
                  _buildSectionTitle(locProvider.translate('app_settings')),
                  const SizedBox(height: AppTokens.spacingMd),
                  _buildSettingsSection(context),
                  const SizedBox(height: AppTokens.spacingXxl),
                  // Save Changes Button
                  AnimatedSwitcher(
                    duration: AppTokens.durationMedium,
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: _hasChanges
                        ? SizedBox(
                            key: const ValueKey('save_btn'),
                            width: double.infinity,
                            height: 54,
                            child: AppTapBehavior(
                              child: FilledButton(
                              onPressed: _saveChanges,
                              child: Text(locProvider.translate('save_changes'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('empty_btn')),
                  ),
                  const SizedBox(height: AppTokens.spacingXxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTokens.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTokens.primaryOlive.withValues(alpha: 0.3),
                width: 3,
              ),
              boxShadow: AppTokens.elevatedShadow,
            ),
            child: CircleAvatar(
              radius: 56,
              backgroundImage: NetworkImage(_profileImageUrl),
              backgroundColor: AppTokens.backgroundLight,
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: GestureDetector(
              onTap: _pickProfileImage,
              child: Container(
                padding: const EdgeInsets.all(AppTokens.spacingSm),
                decoration: BoxDecoration(
                  color: AppTokens.primaryOlive,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTokens.backgroundLight, width: 2.5),
                  boxShadow: AppTokens.elevatedShadow,
                ),
                child: const Icon(Icons.edit, size: 16, color: AppTokens.backgroundLight),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return AppTextField(
      controller: controller,
      labelText: label,
      prefixIcon: icon,
      keyboardType: keyboardType,
    );
  }

  Widget _buildBioField(LocalizationProvider locProvider) {
    return AppTextField(
      controller: _bioController,
      labelText: locProvider.translate('write_something'),
      maxLines: 4,
    );
  }

  Widget _buildBannerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickBannerImage,
          child: Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTokens.radiusCard),
              border: Border.all(color: AppTokens.borderSubtle),
              boxShadow: AppTokens.elevatedShadow,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                  child: Image.network(
                    _bannerImageUrl,
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTokens.backgroundLight,
                      child: const Center(
                        child: Icon(Icons.image_outlined, size: 40, color: AppTokens.textTertiary),
                      ),
                    ),
                  ),
                ),
                // Dark overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000), // transparent
                        AppTokens.overlayDark,
                      ],
                    ),
                  ),
                ),
                // Edit icon
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(AppTokens.spacingSm),
                    decoration: BoxDecoration(
                      color: AppTokens.primaryOlive,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTokens.backgroundLight, width: 2),
                      boxShadow: AppTokens.elevatedShadow,
                    ),
                    child: const Icon(Icons.edit, size: 16, color: AppTokens.backgroundLight),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.info_outline, size: 14, color: AppTokens.textTertiary),
            SizedBox(width: 6),
            Text(
              '1280 × 720  •  Max 2 MB',
              style: TextStyle(
                fontSize: 12,
                color: AppTokens.textTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _pickProfileImage() {
    setState(() {
      _hasChanges = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile image picker would open here'),
        backgroundColor: AppTokens.primaryOlive,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _pickBannerImage() {
    setState(() {
      _hasChanges = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Banner image picker would open here'),
        backgroundColor: AppTokens.primaryOlive,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _saveChanges() {
    setState(() {
      _hasChanges = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: AppTokens.backgroundLight, size: 20),
            SizedBox(width: 10),
            Text('Changes saved successfully!'),
          ],
        ),
        backgroundColor: AppTokens.primaryOlive,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final locProvider = context.watch<LocalizationProvider>();
    final isDark = themeProvider.isDarkMode;
    final isAmharic = locProvider.isAmharic;

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SwitchListTile(
            value: isDark,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            activeThumbColor: AppTokens.primaryOlive,
            title: Text(
              locProvider.translate('dark_mode'),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: isDark ? AppTokens.primaryOlive : AppTokens.textSecondary,
            ),
          ),
          const Divider(height: 1),
          SwitchListTile(
            value: isAmharic,
            onChanged: (value) {
              locProvider.toggleLanguage();
            },
            activeThumbColor: AppTokens.primaryOlive,
            title: Text(
              locProvider.translate('language_amharic'),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            secondary: const Icon(Icons.language, color: AppTokens.primaryOlive),
          ),
        ],
      ),
    );
  }
}
