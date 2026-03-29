import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/providers/roster_provider.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';
import 'package:operator_game_flutter/src/theme/app_theme.dart';
import 'package:operator_game_flutter/src/widgets/slime_detail_view.dart';

class SlimeCard extends ConsumerWidget {
  final SlimeView slime;

  const SlimeCard({super.key, required this.slime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cultureColor = SlimeColors.getCultureColor(slime.culture);
    final stageColor = AppTheme.getLifeStageColor(slime.life_stage);
    final isStaged = slime.is_staged;
    
    // Status Logic
    final isBusy = slime.status_label != null;
    final isInjured = slime.status_label?.contains('INJRD') ?? false;

    return Container(
      width: 380, // SDD-038 parity
      margin: const EdgeInsets.only(bottom: 4), // CARD_GAP
      decoration: BoxDecoration(
        color: isStaged ? const Color(0xFF1E3228) : AppTheme.surfaceHigh,
        border: Border.all(
          color: isStaged ? AppTheme.primaryAccent : Colors.white10,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Identity & Stage Button
              Row(
                children: [
                  Text(
                    slime.name.toUpperCase(),
                    style: TextStyle(color: cultureColor, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    slime.culture.toUpperCase(),
                    style: TextStyle(color: cultureColor.withOpacity(0.7), fontSize: 10),
                  ),
                  const Spacer(),
                  _ActionButtons(slime: slime),
                ],
              ),
              const SizedBox(height: 4),

              // Row 2: Level, LifeStage, Pattern
              Row(
                children: [
                  Text('LV: ${slime.level}', style: const TextStyle(color: Colors.white38, fontSize: 10)),
                  const SizedBox(width: 8),
                  Text(
                    slime.life_stage.toUpperCase(),
                    style: TextStyle(color: stageColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  const Text('SOLID', style: TextStyle(color: Colors.white24, fontSize: 10)), // Placeholder for pattern
                ],
              ),
              const SizedBox(height: 8),

              // Row 3: XP Bar
              _XPBar(percent: (slime.cur_xp / slime.max_xp).clamp(0.0, 1.0)),
              const SizedBox(height: 8),

              // Row 4: Vitals
              Text(
                'STR:${slime.str} AGI:${slime.agi} INT:${slime.intel} HP:${slime.hp.toInt()}',
                style: const TextStyle(color: Colors.white54, fontSize: 10, fontFamily: 'monospace'),
              ),
              const SizedBox(height: 8),

              // Row 5: Equipment
              _HatButton(slime: slime),
            ],
          ),
          
          if (isBusy)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    color: Colors.black26,
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isInjured ? AppTheme.stressAlert : Colors.black87,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Text(
                        slime.status_label!,
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionButtons extends ConsumerWidget {
  final SlimeView slime;
  const _ActionButtons({required this.slime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => SlimeDetailView.show(context, slime),
          icon: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white24),
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: 4),
        SizedBox(
          height: 24,
          child: OutlinedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              applyUiCommand(cmd: UiCommand.toggleStage(id: slime.id));
              ref.invalidate(rosterProvider);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              side: BorderSide(color: slime.is_staged ? AppTheme.primaryAccent : Colors.white24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            ),
            child: Text(
              slime.is_staged ? 'STAGED' : 'STAGE',
              style: TextStyle(
                fontSize: 9,
                color: slime.is_staged ? AppTheme.primaryAccent : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _XPBar extends StatelessWidget {
  final double percent;
  const _XPBar({required this.percent});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: LinearProgressIndicator(
        value: percent,
        minHeight: 4,
        backgroundColor: Colors.white10,
        valueColor: const AlwaysStoppedAnimation(Colors.white38),
      ),
    );
  }
}

class _HatButton extends StatelessWidget {
  final SlimeView slime;
  const _HatButton({required this.slime});

  @override
  Widget build(BuildContext context) {
    final label = slime.hat_name ?? '+ EQUIP HAT';
    
    return SizedBox(
      height: 28,
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.05),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ),
    );
  }
}
