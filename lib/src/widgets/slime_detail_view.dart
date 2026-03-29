import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';
import 'package:operator_game_flutter/src/theme/app_theme.dart';

class SlimeDetailView extends StatelessWidget {
  final SlimeView slime;

  const SlimeDetailView({super.key, required this.slime});

  static Future<void> show(BuildContext context, SlimeView slime) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SlimeDetailView(slime: slime),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cultureColor = SlimeColors.getCultureColor(slime.culture);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            
            // Header: Name & ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slime.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                    ),
                    Text(
                      'ID: ${slime.id}',
                      style: const TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
                _CultureOrb(color: cultureColor),
              ],
            ),
            const SizedBox(height: 32),

            // Main Stats
            _DetailStatTile(
              label: 'VITALITY',
              value: '${slime.hp} / ${slime.maxHp}',
              percent: slime.hp / slime.maxHp,
              color: cultureColor,
            ),
            const SizedBox(height: 20),
            _DetailStatTile(
              label: 'EXPERIENCE (LEVEL ${slime.level})',
              value: '${(slime.xpProgress * 100).toInt()}% towards LVL ${slime.level + 1}',
              percent: slime.xpProgress,
              color: Colors.white70,
            ),
            
            const Spacer(),

            // Footer Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('BACK'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {}, // Future: Interact
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cultureColor.withOpacity(0.2),
                      foregroundColor: cultureColor,
                    ),
                    child: const Text('MANAGE'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _CultureOrb extends StatelessWidget {
  final Color color;
  const _CultureOrb({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0.0)],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

class _DetailStatTile extends StatelessWidget {
  final String label;
  final String value;
  final double percent;
  final Color color;

  const _DetailStatTile({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, letterSpacing: 1.5, color: Colors.white54)),
            Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 12,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
