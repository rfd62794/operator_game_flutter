import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';
import 'package:operator_game_flutter/src/theme/app_theme.dart';

class SlimeCard extends StatelessWidget {
  final SlimeView slime;
  final VoidCallback? onStageToggle;

  const SlimeCard({
    super.key,
    required this.slime,
    this.onStageToggle,
  });

  @override
  Widget build(BuildContext context) {
    final cultureColor = SlimeColors.getCultureColor(slime.culture);
    final hpPercent = slime.hp / slime.maxHp;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(16),
          decoration: GlassDecoration(
            color: cultureColor,
            opacity: 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row 1: Name + Culture Badge + Stage Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      slime.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _CultureBadge(culture: slime.culture, color: cultureColor),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {}, // View Details Detail View
                    icon: const Icon(Icons.open_in_new, size: 20),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Row 2: HP Bar (Premium)
              _VitalityBar(percent: hpPercent, color: cultureColor),
              const SizedBox(height: 12),

              // Row 3: Level + Life Stage Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LVL ${slime.level}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                  ),
                  _StageBadge(stage: slime.stage),
                ],
              ),
              const SizedBox(height: 8),

              // Row 4: XP Progress (Sultle hairline)
              LinearProgressIndicator(
                value: slime.xpProgress,
                minHeight: 2,
                backgroundColor: Colors.white10,
                valueColor: AlwaysStoppedAnimation<Color>(cultureColor.withOpacity(0.5)),
              ),
              const SizedBox(height: 12),

              // Row 5: Action Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        slime.staged ? Icons.check_circle : Icons.radio_button_unchecked,
                        size: 16,
                        color: slime.staged ? Colors.greenAccent : Colors.white38,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        slime.staged ? 'STAGED' : 'UNSTAGED',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: slime.staged ? Colors.greenAccent : Colors.white38,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: onStageToggle,
                    icon: Icon(slime.staged ? Icons.remove : Icons.add, size: 18),
                    label: Text(slime.staged ? 'WITHDRAW' : 'STAGE'),
                    style: TextButton.styleFrom(
                      foregroundColor: slime.staged ? Colors.redAccent : Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CultureBadge extends StatelessWidget {
  final String culture;
  final Color color;

  const _CultureBadge({required this.culture, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        culture.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _StageBadge extends StatelessWidget {
  final String stage;

  const _StageBadge({required this.stage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        stage,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _VitalityBar extends StatelessWidget {
  final double percent;
  final Color color;

  const _VitalityBar({required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    // Determine vitality color (green to red transition)
    final barColor = Color.lerp(Colors.redAccent, Colors.greenAccent, percent) ?? color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 8,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('VITALITY', style: TextStyle(fontSize: 9, color: Colors.white38, fontWeight: FontWeight.bold)),
            Text('${(percent * 100).toInt()}%', style: TextStyle(fontSize: 9, color: barColor.withOpacity(0.8), fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
