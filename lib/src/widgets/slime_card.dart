import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/rust/api/simple.rs.dart';
import 'package:operator_game_flutter/src/rust/frb_generated.dart';
import 'package:operator_game_flutter/src/theme/app_theme.dart';

class SlimeCard extends ConsumerWidget {
  final SlimeView slime;

  const SlimeCard({super.key, required this.slime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ground-truth culture colors
    final cultureColor = SlimeColors.fromCulture(slime.culture);
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A22),
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
                style: TextStyle(color: cultureColor, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(width: 8),
              Text(
                slime.culture.toUpperCase(),
                style: TextStyle(color: cultureColor.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (slime.state_label != null)
                _StatusBadge(label: slime.state_label!)
              else
                _StageButton(
                  isStaged: slime.is_staged,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    // Future: ref.read(uiCommandProvider).apply(UiCommand.toggleStage(id: slime.id))
                  },
                ),
            ],
          ),
          const SizedBox(height: 4),

          // ROW 2: Level, LifeStage, Pattern
          Row(
            children: [
              Text('Lv: ${slime.level}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
              const SizedBox(width: 8),
              _LifeStageBadge(stage: slime.life_stage),
              const SizedBox(width: 8),
              const Text('PATTERN_ALPHA', style: TextStyle(color: Colors.white24, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 6),

          // ROW 3: XP ProgressBar (4dp height)
          _XPProgressBar(current: slime.cur_xp, max: slime.max_xp),
          const SizedBox(height: 6),

          // ROW 4: Stats (STR/AGI/INT) and HP
          Row(
            children: [
              Text(
                'STR:${slime.str} AGI:${slime.agi} INT:${slime.int} HP:${slime.hp.toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.white54, fontSize: 11, fontFamily: 'monospace'),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, size: 14, color: Colors.white10),
            ],
          ),
          const SizedBox(height: 8),

          // ROW 5: EQUIP HAT
          SizedBox(
            width: double.infinity,
            height: 28,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                slime.hat_name ?? '+ EQUIP HAT',
                style: const TextStyle(fontSize: 11, color: Colors.white38),
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold),
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
      height: 24,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isStaged ? Colors.greenAccent.withOpacity(0.1) : Colors.white.withOpacity(0.05),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        child: Text(
          isStaged ? 'STAGED' : 'STAGE',
          style: TextStyle(
            color: isStaged ? Colors.greenAccent : Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _LifeStageBadge extends StatelessWidget {
  final String stage;
  const _LifeStageBadge({required this.stage});

  @override
  Widget build(BuildContext context) {
    // Colors matched to egui manifest.rs §300+
    Color color = Colors.white54;
    switch (stage.toUpperCase()) {
      case 'HATCHLING': color = const Color(0xFFA0A0A0); break;
      case 'JUVENILE': color = const Color(0xFF8CC88C); break;
      case 'YOUNG': color = const Color(0xFF64C8B4); break;
      case 'PRIME': color = const Color(0xFFDCB450); break;
      case 'VETERAN': color = const Color(0xFFC88C3C); break;
      case 'ELDER': color = const Color(0xFFB478DC); break;
    }

    return Text(
      stage,
      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
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
