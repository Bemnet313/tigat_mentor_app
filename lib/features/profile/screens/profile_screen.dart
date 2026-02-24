import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/mock_data/mock_data.dart';
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
    final themeProvider = context.watch<ThemeProvider>();
    final locProvider = context.watch<LocalizationProvider>();
    final isDark = themeProvider.isDarkMode;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color ?? AppTheme.textPrimary;
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
              color: isDark ? Colors.white.withValues(alpha: 0.1) : AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 18, color: textColor),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          locProvider.translate('profile') == 'profile' ? 'Profile' : locProvider.translate('profile'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Picture with Edit Icon
            _buildProfileAvatar(),
            const SizedBox(height: 16),
            // Name & Username display
            Text(
              _nameController.text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _usernameController.text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodySmall?.color ?? AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 28),
            // Editable Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Personal Information'),
                  const SizedBox(height: 12),
                  _buildEditableField(
                    controller: _nameController,
                    label: 'Name',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 12),
                  _buildEditableField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: Icons.alternate_email,
                  ),
                  const SizedBox(height: 12),
                  _buildEditableField(
                    controller: _phoneController,
                    label: 'Phone',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  _buildEditableField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  // Bio Section
                  _buildSectionTitle('Bio'),
                  const SizedBox(height: 12),
                  _buildBioField(),
                  const SizedBox(height: 24),
                  // Banner Section
                  _buildSectionTitle('Banner Image'),
                  const SizedBox(height: 12),
                  _buildBannerSection(),
                  const SizedBox(height: 32),
                  // Security Section
                  _buildSectionTitle('Security'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Change Password Flow Opened')),
                        );
                      },
                      icon: Icon(Icons.lock_outline, color: textColor),
                      label: Text(
                        'Change Password',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // App Settings Section
                  _buildSectionTitle('App Settings'),
                  const SizedBox(height: 12),
                  _buildSettingsSection(context, themeProvider, locProvider),
                  const SizedBox(height: 32),
                  // Save Changes Button
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
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
                            child: FilledButton(
                              onPressed: _saveChanges,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.primaryStatusGreen,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 3,
                              ),
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('empty_btn')),
                  ),
                  const SizedBox(height: 40),
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
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).textTheme.bodySmall?.color ?? AppTheme.textSecondary,
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
                color: AppTheme.primaryStatusGreen.withValues(alpha: 0.3),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryStatusGreen.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 56,
              backgroundImage: NetworkImage(_profileImageUrl),
              backgroundColor: AppTheme.backgroundLight,
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: GestureDetector(
              onTap: _pickProfileImage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryStatusGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.edit, size: 16, color: Colors.white),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color ?? AppTheme.textPrimary;
    final secondaryTextColor = Theme.of(context).textTheme.bodySmall?.color ?? AppTheme.textSecondary;
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.12);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: secondaryTextColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.only(left: 12, right: 8),
            child: Icon(icon, size: 20, color: AppTheme.primaryStatusGreen),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildBioField() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color ?? AppTheme.textPrimary;
    final secondaryTextColor = Theme.of(context).textTheme.bodySmall?.color ?? AppTheme.textSecondary;
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.12);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          TextField(
            controller: _bioController,
            maxLines: 4,
            maxLength: 250,
            buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: 'Write something about yourself...',
              hintStyle: TextStyle(color: secondaryTextColor.withValues(alpha: 0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 12,
            child: ListenableBuilder(
              listenable: _bioController,
              builder: (context, _) {
                final len = _bioController.text.length;
                return Text(
                  '$len / 250',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: len > 230 ? AppTheme.statusRed : AppTheme.textTertiary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    _bannerImageUrl,
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTheme.backgroundLight,
                      child: const Center(
                        child: Icon(Icons.image_outlined, size: 40, color: AppTheme.textTertiary),
                      ),
                    ),
                  ),
                ),
                // Dark overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                ),
                // Edit icon
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryStatusGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.info_outline, size: 14, color: AppTheme.textTertiary),
            SizedBox(width: 6),
            Text(
              '1280 × 720  •  Max 2 MB',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textTertiary,
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
        backgroundColor: AppTheme.primaryStatusGreen,
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
        backgroundColor: AppTheme.primaryStatusGreen,
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
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text('Changes saved successfully!'),
          ],
        ),
        backgroundColor: AppTheme.primaryStatusGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, ThemeProvider themeProvider, LocalizationProvider locProvider) {
    final bool isDark = themeProvider.isDarkMode;
    final bool isAmharic = locProvider.isAmharic;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color ?? AppTheme.textPrimary;
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.12);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SwitchListTile(
            value: isDark,
            onChanged: (value) => themeProvider.toggleTheme(),
            activeThumbColor: AppTheme.primaryStatusGreen,
            title: Text(
              'Dark Mode',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: textColor),
            ),
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: isDark ? AppTheme.primaryStatusGreen : AppTheme.textSecondary,
            ),
          ),
          Divider(height: 1, color: borderColor),
          SwitchListTile(
            value: isAmharic,
            onChanged: (value) => locProvider.toggleLanguage(),
            activeThumbColor: AppTheme.primaryStatusGreen,
            title: Text(
              'Language (Amharic)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: textColor),
            ),
            secondary: const Icon(Icons.language, color: AppTheme.primaryStatusGreen),
          ),
        ],
      ),
    );
  }
}
