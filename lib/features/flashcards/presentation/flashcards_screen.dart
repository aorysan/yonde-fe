import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/flashcard_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../data/flashcard_dummy_data.dart';
import 'widgets/card_action_controls.dart';
import 'widgets/flip_card_widget.dart';

class FlashcardsScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const FlashcardsScreen({super.key, required this.onThemeToggle});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  int _currentCardIndex = 0;
  bool _isFlipped = false;
  final List<FlashcardData> _cards = dummyFlashcards;

  void _nextCard() {
    setState(() {
      _isFlipped = false;
      _currentCardIndex = (_currentCardIndex + 1) % _cards.length;
    });
  }

  void _prevCard() {
    setState(() {
      _isFlipped = false;
      _currentCardIndex =
          (_currentCardIndex - 1 + _cards.length) % _cards.length;
    });
  }

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    final card = _cards[_currentCardIndex];

    return Column(
      children: [
        AppHeader(
          streak: 7,
          xpDisplay: '3.4k',
          onThemeToggle: widget.onThemeToggle,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colors.secondary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 12,
                              color: colors.accent,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '✦ Whispered Words · 単語',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: colors.secondaryForeground,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      '${_currentCardIndex + 1} / ${_cards.length}',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_cards.length, (index) {
                    final isCurrent = index == _currentCardIndex;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 14,
                        color: isCurrent
                            ? colors.accent
                            : colors.mutedForeground.withValues(alpha: 0.3),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: FlipCardWidget(
                        card: card,
                        isFlipped: _isFlipped,
                        onTap: _toggleFlip,
                        onSwipeRight: _nextCard,
                        onSwipeLeft: _prevCard,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CardActionControls(
                  onRevisit: _prevCard,
                  onFlip: _toggleFlip,
                  onCherish: _nextCard,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
