import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart'; // Correct generated path
import 'package:operator_game_flutter/src/theme/app_theme.dart';

class SlimeCard extends ConsumerWidget {
  final SlimeView slime;

  const SlimeCard({super.key, required this.slime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ground-truth culture colors from the design system
    final cultureColor = SlimeColors.getCultureColor(slime.culture);
    final stageColor = AppTheme.getLifeStageColor(slime.life_stage);
    
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceHigh,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: slime.is_staged ? Colors.greenAccent.withOpacity(0.5) : Colors.white10,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ROW 1: Name, Culture, Stage Toggle
          Row(
            children: [
              Text(
                slime.name,
                style: TextStyle(color: cultureColor, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(width: 8),
              Text(
                slime.culture.toUpperCase(),
                style: TextStyle(color: cultureColor.withOpacity(0.5), fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (slime.state_label != null)
                _StatusBadge(label: slime.state_label!)
              else
                _StageButton(
                  isStaged: slime.is_staged,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                  },
                ),
            ],
          ),
          const SizedBox(height: 4),

          // ROW 2: Level, LifeStage, Pattern
          Row(
            children: [
              Text('LVL: ${slime.level}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
              const SizedBox(width: 8),
              Text(
                slime.life_stage,
                style: TextStyle(color: stageColor, fontSize: 11, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Text('PATTERN_ALPHA', style: TextStyle(color: Colors.white10, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 6),

          // ROW 3: XP ProgressBar
          _XPProgressBar(current: slime.cur_xp, max: slime.max_xp),
          const SizedBox(height: 6),

          // ROW 4: Stats and HP
          Row(
            children: [
              Text(
                'STR:${slime.str} AGI:${slime.agi} INT:${slime.intel} HP:${slime.hp.toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.white54, fontSize: 10, fontFamily: 'monospace'),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, size: 14, color: Colors.white12),
            ],
          ),
          const SizedBox(height: 8),

          // ROW 5: EQUIP HAT
          SizedBox(
            width: double.infinity,
            height: 26,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                slime.hat_name ?? '+ EQUIP HAT',
                style: const TextStyle(fontSize: 10, color: Colors.white38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  const _StatusBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.redAccent, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _StageButton extends StatelessWidget {
  final bool isStaged;
  final VoidCallback onPressed;
  const _StageButton({required this.isStaged, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isStaged ? Colors.greenAccent.withOpacity(0.1) : Colors.white.withOpacity(0.05),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        child: Text(
          isStaged ? 'STAGED' : 'STAGE',
          style: TextStyle(
            color: isStaged ? Colors.greenAccent : Colors.white60,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _XPProgressBar extends StatelessWidget {
  final int current;
  final int max;
  const _XPProgressBar({required this.current, required this.max});

  @override
  Widget build(BuildContext context) {
    final pct = (current / max).clamp(0.0, 1.0);
    return SizedBox(
      height: 4,
      width: double.infinity,
      child: LinearProgressIndicator(
        value: pct,
        backgroundColor: Colors.white.withOpacity(0.05),
        valueColor: const AlwaysStoppedAnimation(Colors.white24),
      ),
    );
  }
}
