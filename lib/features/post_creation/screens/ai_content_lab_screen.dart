import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/motion.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────────────

class AiContentLab {
  static Future<Map<String, dynamic>?> show(BuildContext context) {
    return Navigator.of(context).push<Map<String, dynamic>>(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const AiContentLabScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
      transitionDuration: AppMotion.long,
    ));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main Screen
// ─────────────────────────────────────────────────────────────────────────────

class AiContentLabScreen extends StatefulWidget {
  const AiContentLabScreen({super.key});

  @override
  State<AiContentLabScreen> createState() => _AiContentLabScreenState();
}

class _AiContentLabScreenState extends State<AiContentLabScreen>
    with TickerProviderStateMixin {
  // ── State ──────────────────────────────────────────────────────────────────
  bool _isAmharic = false;
  String _selectedFormat = 'Text/Blog'; // 'Text/Blog', 'Voice Script', 'AI Image'
  String _selectedDuration = '1 Min';   // '30 Sec', '1 Min', '3 Min'
  bool _pdfUploaded = false;
  double _pdfUploadProgress = 0.0;
  bool _isPdfUploading = false;
  String _pdfName = '';
  
  bool _isGenerating = false;
  bool _hasGenerated = false;
  String _generatedContent = '';
  String _generatedImageUrl = '';

  final TextEditingController _promptController = TextEditingController();

  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  Future<void> _generate() async {
    if (_promptController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter what you want the AI to create.')),
      );
      return;
    }
    setState(() {
      _isGenerating = true;
      _hasGenerated = false;
    });

    // Simulate AI generation delay
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    if (_selectedFormat == 'AI Image') {
      setState(() {
        _isGenerating = false;
        _hasGenerated = true;
        _generatedImageUrl = 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=1000&auto=format&fit=crop';
      });
      return;
    }

    final sampleContent = _isAmharic
        ? _buildSampleAmharicContent()
        : _buildSampleEnglishContent();

    setState(() {
      _isGenerating = false;
      _hasGenerated = true;
      _generatedContent = sampleContent;
    });
  }

  String _buildSampleEnglishContent() {
    if (_selectedFormat == 'Voice Script') {
      return "🎙️ Voice Script — ${_selectedDuration}\n\n"
          "Hello everyone! I'm absolutely stoked to invite you to our special live session this Friday at 7PM Addis Ababa time.\n\n"
          "We'll be diving deep into advanced Flutter animations — topics you've been requesting for weeks!\n\n"
          "Whether you're a beginner or you've been coding with me for months, this session is 100% for YOU.\n\n"
          "Link in the community chat. See you there! 🚀";
    }
    return "📝 Blog Post\n\n"
        "**Join Us This Friday — A Special Live Session You Don't Want to Miss!**\n\n"
        "Dear Students,\n\n"
        "I am thrilled to announce a special live coding session this Friday evening. "
        "We will be covering the most-requested topics, answering your questions in real-time, "
        "and building something incredible together.\n\n"
        "Mark your calendar: **Friday, 7:00 PM EAT**\n\n"
        "Don't miss it — this is your chance to level up your skills and connect with the community! 🌿";
  }

  String _buildSampleAmharicContent() {
    if (_selectedFormat == 'Voice Script') {
      return "🎙️ Voice Script — ${_selectedDuration}\n\n"
          "ሰላም ሁሉም! አርብ ምሽት ሰዓቱ 7 ሰዓት ላይ ልዩ ቀጥታ ትምህርት አለን።\n\n"
          "ብዙ ጊዜ የጠየቃቸውን ርዕሶች — Flutter animations ና Firebase integration — ዛሬ ሁሉን ምንታዬ ነው!\n\n"
          "ከጀማሪ ጀምሮ እስከ ከፍተኛ ደረጃ ያሉ ሁሉም ጠቃሚ የሆነ ትምህርት ነው።\n\n"
          "ሊንኩ በ community chat ውስጥ ነው። እናንተን ለማዬ እጠብቃለሁ! 🚀";
    }
    return "📝 Blog Post\n\n"
        "**አርብ ቀጥታ ትምህርት — አትስቲ!**\n\n"
        "ውድ ተማሪዎቼ፣\n\n"
        "ይህ አርብ ምሽት 7 ሰዓት ላይ ልዩ ቀጥታ ትምህርት ያለን ሲሆን "
        "ብዙ ጊዜ የጠያቁትን ርዕሶች በዚህ ሰዓት ሁሉ ምንም ተናጋሪ ነን። "
        "ጥያቄዎቻቹን ለማዳመጥ ዝግጁ ነኝ!\n\n"
        "ቀን: **አርብ፣ ሰዓቱ ሰባት**\n\n"
        "አትስቲ — ቤተሰቦቼ! 🌿";
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? Theme.of(context).colorScheme.surface
        : AppTokens.backgroundLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(context),
      body: _hasGenerated
          ? _buildOutputView(context)
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppTokens.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContextSection(context),
                  const SizedBox(height: AppTokens.spacingXl),
                  _buildPromptSection(context),
                  const SizedBox(height: AppTokens.spacingXl),
                  _buildOutputPrefSection(context),
                  const SizedBox(height: AppTokens.spacingXl),
                  if (_selectedFormat == 'Voice Script')
                    _buildDurationSelector(context),
                  if (_selectedFormat == 'Voice Script')
                    const SizedBox(height: AppTokens.spacingXl),
                  _buildGenerateButton(context),
                  const SizedBox(height: AppTokens.spacingXl),
                ],
              ),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTokens.primaryOlive,
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _shimmerAnimation,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    AppTokens.accentGlow,
                    Theme.of(context).colorScheme.onPrimary,
                    AppTokens.accentGlow,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  begin: Alignment(_shimmerAnimation.value, 0),
                  end: Alignment(_shimmerAnimation.value + 1, 0),
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Icon(Icons.auto_awesome, size: 20),
              );
            },
          ),
          const SizedBox(width: 8),
          const Text(
            'AI Content Lab',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _buildContextSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, '📎 Reference Document'),
        const SizedBox(height: AppTokens.spacingMd),
        _buildContextNote(context),
        const SizedBox(height: AppTokens.spacingMd),
        _buildPdfUploadCard(context, isDark),
      ],
    );
  }

  Widget _buildContextNote(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTokens.spacingMd),
      decoration: BoxDecoration(
        color: AppTokens.accentGlow.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        border: Border.all(
          color: AppTokens.accentGlow.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppTokens.primaryOlive, size: 18),
          const SizedBox(width: AppTokens.spacingMd),
          Expanded(
            child: Text(
              'AI will refer to this Doc and your previous feed posts.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTokens.primaryOlive,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfUploadCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: _isPdfUploading ? null : _simulatePdfUpload,
      child: AnimatedContainer(
        duration: AppTokens.durationMedium,
        height: 100,
        decoration: BoxDecoration(
          color: _pdfUploaded
              ? AppTokens.accentGlow.withValues(alpha: 0.1)
              : (isDark ? AppTokens.overlayLight : AppTokens.surfaceElevated),
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          border: Border.all(
            color: _pdfUploaded
                ? AppTokens.primaryOlive.withValues(alpha: 0.5)
                : AppTokens.borderSubtle,
            width: 1.5,
          ),
        ),
        child: _isPdfUploading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Uploading Reference PDF...',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTokens.primaryOlive)),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _pdfUploadProgress,
                        backgroundColor: AppTokens.primaryOlive.withValues(alpha: 0.1),
                        color: AppTokens.primaryOlive,
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              )
            : _pdfUploaded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.picture_as_pdf, color: AppTokens.primaryOlive, size: 28),
                      const SizedBox(width: AppTokens.spacingMd),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_pdfName,
                              style: const TextStyle(
                                  color: AppTokens.primaryOlive,
                                  fontWeight: FontWeight.bold)),
                          const Text('Tap to replace',
                              style: TextStyle(
                                  color: AppTokens.textSecondary, fontSize: 11)),
                        ],
                      ),
                      const SizedBox(width: AppTokens.spacingMd),
                      const Icon(Icons.check_circle, color: AppTokens.primaryOlive),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.upload_file_outlined,
                          color: AppTokens.textSecondary, size: 28),
                      const SizedBox(height: 6),
                      Text('Tap to upload a PDF',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('Max 1 document',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppTokens.textTertiary)),
                    ],
                  ),
      ),
    );
  }

  Future<void> _simulatePdfUpload() async {
    if (_pdfUploaded) {
      setState(() {
        _pdfUploaded = false;
        _pdfName = '';
        _pdfUploadProgress = 0.0;
      });
      return;
    }

    setState(() {
      _isPdfUploading = true;
      _pdfUploadProgress = 0.0;
    });

    // Simulate progress
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (!mounted) return;
      setState(() {
        _pdfUploadProgress = i / 10.0;
      });
    }

    setState(() {
      _isPdfUploading = false;
      _pdfUploaded = true;
      _pdfName = 'Course_Outline_Q1_2025.pdf';
    });
  }

  Widget _buildPromptSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, '✨ What should the AI create today?'),
        const SizedBox(height: AppTokens.spacingMd),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTokens.radiusCard),
            boxShadow: AppTokens.elevatedShadow,
          ),
          child: TextField(
            controller: _promptController,
            maxLines: 4,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText:
                  'e.g. "A script to invite students to Friday\'s live session"',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppTokens.textTertiary),
              filled: true,
              fillColor: isDark
                  ? Theme.of(context).colorScheme.surface
                  : AppTokens.backgroundLight,
              contentPadding: const EdgeInsets.all(AppTokens.spacingLg),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                borderSide: const BorderSide(
                    color: AppTokens.primaryOlive, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                borderSide: BorderSide(color: AppTokens.borderSubtle),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOutputPrefSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, '⚙️ Output Preferences'),
        const SizedBox(height: AppTokens.spacingMd),
        _buildLanguageToggle(context),
        const SizedBox(height: AppTokens.spacingLg),
        _buildFormatSelector(context),
      ],
    );
  }


  Widget _buildLanguageToggle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.spacingLg, vertical: AppTokens.spacingMd),
      decoration: BoxDecoration(
        color: AppTokens.surfaceElevated,
        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        border: Border.all(color: AppTokens.borderSubtle),
      ),
      child: Row(
        children: [
          const Icon(Icons.language, color: AppTokens.primaryOlive, size: 20),
          const SizedBox(width: AppTokens.spacingMd),
          Expanded(
            child: Row(
              children: [
                _langChip('ENGLISH', !_isAmharic),
                const SizedBox(width: 8),
                Switch(
                  value: _isAmharic,
                  onChanged: (v) => setState(() => _isAmharic = v),
                  activeThumbColor: AppTokens.primaryOlive,
                  activeTrackColor:
                      AppTokens.primaryOlive.withValues(alpha: 0.3),
                ),
                const SizedBox(width: 8),
                _langChip('አማርኛ', _isAmharic),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _langChip(String label, bool active) {
    return Text(
      label,
      style: TextStyle(
        color: active ? AppTokens.primaryOlive : AppTokens.textTertiary,
        fontWeight: active ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
      ),
    );
  }

  Widget _buildFormatSelector(BuildContext context) {
    final formats = [
      {'id': 'Text/Blog', 'icon': Icons.article_outlined, 'label': 'Text / Blog'},
      {'id': 'Voice Script', 'icon': Icons.mic_outlined, 'label': 'Voice Script'},
      {'id': 'AI Image', 'icon': Icons.image_outlined, 'label': 'AI Image'},
    ];
    return Row(
      children: formats.map((f) {
        final isSelected = _selectedFormat == f['id'];
        final isComingSoon = f['id'] == 'AI Image';
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                if (isComingSoon) {
                  _showComingSoonDialog(context, 'AI Image Generation');
                  return;
                }
                setState(() => _selectedFormat = f['id'] as String);
              },
              child: AnimatedContainer(
                duration: AppTokens.durationMedium,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [
                            AppTokens.primaryOlive,
                            Color(0xFF6B7E30),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected ? null : AppTokens.surfaceElevated,
                  borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                  border: Border.all(
                    color: isSelected
                        ? AppTokens.primaryOlive
                        : AppTokens.borderSubtle,
                    width: isSelected ? 1.5 : 1,
                  ),
                  boxShadow: isSelected ? AppTokens.glowingShadow : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      f['icon'] as IconData,
                      color: isSelected ? Colors.white : AppTokens.textSecondary,
                      size: 24,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      f['label'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : AppTokens.textPrimary,
                        fontSize: 11,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    if (isComingSoon) ...[
                      const SizedBox(height: 3),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppTokens.statusWarning.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'SOON',
                          style: TextStyle(
                              fontSize: 8,
                              color: AppTokens.statusWarning,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDurationSelector(BuildContext context) {
    final durations = ['30 Sec', '1 Min', '3 Min'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, '⏱️ Script Duration'),
        const SizedBox(height: AppTokens.spacingMd),
        Row(
          children: durations.map((d) {
            final isSelected = _selectedDuration == d;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDuration = d),
                  child: AnimatedContainer(
                    duration: AppTokens.durationMedium,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTokens.primaryOlive
                          : AppTokens.surfaceElevated,
                      borderRadius:
                          BorderRadius.circular(AppTokens.radiusCard),
                      border: Border.all(
                        color: isSelected
                            ? AppTokens.primaryOlive
                            : AppTokens.borderSubtle,
                      ),
                    ),
                    child: Text(
                      d,
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : AppTokens.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGenerateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: _isGenerating ? null : _generate,
        child: AnimatedContainer(
          duration: AppTokens.durationMedium,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A5A23), Color(0xFF6B7E30), Color(0xFFB7D77A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppTokens.radiusCard),
            boxShadow: [
              BoxShadow(
                color: AppTokens.primaryOlive.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: _isGenerating
              ? const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5),
                  ),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Generate with AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // ── Output Views ───────────────────────────────────────────────────────────

  Widget _buildOutputView(BuildContext context) {
    switch (_selectedFormat) {
      case 'Voice Script':
        return _TeleprompterView(
          script: _generatedContent,
          duration: _selectedDuration,
          onBack: () => setState(() {
            _hasGenerated = false;
          }),
          onPublish: (finalScript) {
            Navigator.pop(context, {
              'type': 'voice',
              'content': finalScript,
            });
          },
        );
      case 'Text/Blog':
        return _RichTextEditorView(
          content: _generatedContent,
          onBack: () => setState(() {
            _hasGenerated = false;
          }),
          onPublish: () {
            Navigator.pop(context, {
              'type': 'text',
              'content': _generatedContent,
            });
          },
        );
      case 'AI Image':
        return _AiImageResultView(
          imageUrl: _generatedImageUrl,
          onBack: () => setState(() {
            _hasGenerated = false;
          }),
          onUseImage: () {
            Navigator.pop(context, {
              'type': 'image',
              'content': _generatedImageUrl,
            });
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark 
            ? const Color(0xFF1B1B1B) 
            : Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusCard),
            side: BorderSide(color: AppTokens.primaryOlive.withValues(alpha: 0.2))),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTokens.statusWarning.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.rocket_launch,
                  color: AppTokens.statusWarning, size: 22),
            ),
            const SizedBox(width: 12),
            const Text('Coming Soon!'),
          ],
        ),
        content: Text(
            '$feature is under development and will be available in the next release. Stay tuned! 🚀'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Got it!',
                style:
                    TextStyle(color: AppTokens.primaryOlive, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ── Utility ────────────────────────────────────────────────────────────────
  Widget _sectionLabel(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTokens.primaryOlive,
            letterSpacing: 0.3,
          ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Teleprompter View
// ─────────────────────────────────────────────────────────────────────────────

class _TeleprompterView extends StatefulWidget {
  final String script;
  final String duration;
  final VoidCallback onBack;
  final Function(String) onPublish;

  const _TeleprompterView({
    required this.script,
    required this.duration,
    required this.onBack,
    required this.onPublish,
  });

  @override
  State<_TeleprompterView> createState() => _TeleprompterViewState();
}

class _TeleprompterViewState extends State<_TeleprompterView> {
  bool _isRecording = false;
  bool _isDragging = false;
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;
  double _scrollPosition = 0;

  int get _durationSeconds {
    switch (widget.duration) {
      case '30 Sec':
        return 30;
      case '1 Min':
        return 60;
      case '3 Min':
        return 180;
      default:
        return 60;
    }
  }

  void _startAutoScroll(double maxExtent) {
    const fps = 60;
    final ticksTotal = _durationSeconds * fps;
    final scrollPerTick = maxExtent / ticksTotal;

    _scrollTimer = Timer.periodic(
      const Duration(milliseconds: 1000 ~/ 60),
      (timer) {
        if (!_scrollController.hasClients) {
          timer.cancel();
          return;
        }
        
        // If user is not manually scrolling, proceed with auto-scroll
        if (!_isDragging) {
          _scrollPosition += scrollPerTick;
          if (_scrollPosition >= maxExtent) {
            _scrollPosition = maxExtent;
            timer.cancel();
          }
          _scrollController.jumpTo(_scrollPosition);
        } else {
          // Sync internal tracker with manual scroll
          _scrollPosition = _scrollController.offset;
        }
      },
    );
  }

  void _toggleRecording() {
    setState(() => _isRecording = !_isRecording);
    if (_isRecording) {
      _scrollPosition = _scrollController.offset;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startAutoScroll(_scrollController.position.maxScrollExtent);
      });
    } else {
      _scrollTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toolbar
        Container(
          color: AppTokens.primaryOlive,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.spacingLg, vertical: AppTokens.spacingMd),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  _scrollTimer?.cancel();
                  widget.onBack();
                },
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Teleprompter',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    widget.duration,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.duration,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        // Script scroll area
        Expanded(
          child: Container(
            color: Colors.black87,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  setState(() => _isDragging = true);
                } else if (notification is ScrollEndNotification) {
                  setState(() => _isDragging = false);
                }
                return false;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 40),
                child: Text(
                  widget.script,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    height: 1.7,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),

        // Record Button
        Container(
          color: Colors.black87,
          padding: const EdgeInsets.symmetric(
              vertical: AppTokens.spacingXl, horizontal: AppTokens.spacingLg),
          child: Column(
            children: [
              if (_isRecording)
                Text(
                  '🔴 Recording — script auto-scrolling at ${widget.duration} pace',
                  style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Reset
                  GestureDetector(
                    onTap: () {
                      _scrollTimer?.cancel();
                      _scrollPosition = 0;
                      _scrollController.jumpTo(0);
                    },
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Colors.white12,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.refresh, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Record
                  GestureDetector(
                    onTap: _toggleRecording,
                    child: AnimatedContainer(
                      duration: AppTokens.durationMedium,
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: _isRecording
                            ? Colors.redAccent
                            : AppTokens.primaryOlive,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (_isRecording
                                    ? Colors.redAccent
                                    : AppTokens.primaryOlive)
                                .withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isRecording ? Icons.stop : Icons.fiber_manual_record,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Publish/Play
                  GestureDetector(
                    onTap: () {
                      if (!_isRecording) {
                        widget.onPublish(widget.script);
                      }
                    },
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _isRecording ? Colors.white10 : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isRecording ? Icons.play_arrow : Icons.publish,
                        color: _isRecording ? Colors.white38 : AppTokens.primaryOlive,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rich Text Editor (Blog/Text output view)
// ─────────────────────────────────────────────────────────────────────────────

class _RichTextEditorView extends StatefulWidget {
  final String content;
  final VoidCallback onBack;
  final VoidCallback onPublish;

  const _RichTextEditorView({
    required this.content,
    required this.onBack,
    required this.onPublish,
  });

  @override
  State<_RichTextEditorView> createState() => _RichTextEditorViewState();
}

class _RichTextEditorViewState extends State<_RichTextEditorView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        // Toolbar
        Container(
          color: AppTokens.primaryOlive,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.spacingLg, vertical: AppTokens.spacingMd),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary),
                onPressed: widget.onBack,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '✏️ Edit & Publish',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              TextButton(
                onPressed: widget.onPublish,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Publish',
                    style: TextStyle(
                        color: AppTokens.primaryOlive,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        // Rich text field
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppTokens.spacingLg),
            child: Column(
              children: [
                // Format toolbar (decorative)
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Theme.of(context).colorScheme.surface
                        : AppTokens.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
                    border: Border.all(color: AppTokens.borderSubtle),
                  ),
                  child: Row(
                    children: [
                      _toolbarBtn(Icons.format_bold),
                      _toolbarBtn(Icons.format_italic),
                      _toolbarBtn(Icons.format_underlined),
                      const VerticalDivider(width: 16, indent: 8, endIndent: 8),
                      _toolbarBtn(Icons.format_list_bulleted),
                      _toolbarBtn(Icons.format_list_numbered),
                      const VerticalDivider(width: 16, indent: 8, endIndent: 8),
                      _toolbarBtn(Icons.link),
                      _toolbarBtn(Icons.image_outlined),
                    ],
                  ),
                ),
                const SizedBox(height: AppTokens.spacingMd),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Theme.of(context).colorScheme.surface
                          : AppTokens.backgroundLight,
                      borderRadius:
                          BorderRadius.circular(AppTokens.radiusCard),
                      border: Border.all(color: AppTokens.borderSubtle),
                      boxShadow: AppTokens.elevatedShadow,
                    ),
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(fontSize: 15, height: 1.6),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.all(AppTokens.spacingLg),
                        border: InputBorder.none,
                        hintText: 'Start writing...',
                        hintStyle: TextStyle(color: AppTokens.textTertiary),
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

  Widget _toolbarBtn(IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(icon, size: 18, color: AppTokens.textSecondary),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AI Image Result View
// ─────────────────────────────────────────────────────────────────────────────

class _AiImageResultView extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onBack;
  final VoidCallback onUseImage;

  const _AiImageResultView({
    required this.imageUrl,
    required this.onBack,
    required this.onUseImage,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Toolbar
        Container(
          color: AppTokens.primaryOlive,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.spacingLg, vertical: AppTokens.spacingMd),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBack,
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    '🎨 AI Generated Image',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 48), // Spacer to balance back button
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTokens.spacingLg),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                    boxShadow: AppTokens.elevatedShadow,
                    border: Border.all(
                      color: AppTokens.primaryOlive.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppTokens.radiusCard - 2),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 300,
                          width: double.infinity,
                          color: isDark ? Colors.white10 : Colors.black12,
                          child: const Center(
                            child: CircularProgressIndicator(color: AppTokens.primaryOlive),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppTokens.spacingXl),
                const Text(
                  'Your masterpiece is ready!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'High-resolution, custom generated image for your post.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppTokens.textSecondary),
                ),
                const SizedBox(height: AppTokens.spacingXl),
                _actionButton(
                  context,
                  label: 'Use this Image',
                  icon: Icons.check_circle_outline,
                  onTap: onUseImage,
                  isPrimary: true,
                ),
                const SizedBox(height: AppTokens.spacingMd),
                _actionButton(
                  context,
                  label: 'Regenerate',
                  icon: Icons.refresh,
                  onTap: onBack,
                  isPrimary: false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, color: isPrimary ? Theme.of(context).colorScheme.onPrimary : AppTokens.primaryOlive, size: 20),
          label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary ? AppTokens.primaryOlive : Colors.transparent,
            foregroundColor: isPrimary ? Theme.of(context).colorScheme.onPrimary : AppTokens.primaryOlive,
            elevation: isPrimary ? 4 : 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTokens.radiusCard),
              side: isPrimary ? BorderSide.none : const BorderSide(color: AppTokens.primaryOlive),
            ),
          ),
        ),
      ),
    );
  }
}
