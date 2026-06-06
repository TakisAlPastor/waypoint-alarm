import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:waypoint_alarm/features/alarm/presentation/widgets/alarm_card.dart';
import 'package:waypoint_alarm/features/alarm/providers/alarm_list_provider.dart';
import 'package:waypoint_alarm/l10n/app_localizations.dart';

class AlarmsScreen extends ConsumerWidget {
  const AlarmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final alarmsAsync = ref.watch(alarmListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navAlarms),
      ),
      body: alarmsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(error.toString()),
        ),
        data: (alarms) {
          if (alarms.isEmpty) {
            return _EmptyState(l10n: l10n);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: alarms.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) => AlarmCard(alarm: alarms[index]),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.alarm_off_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.5,
                  ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.alarmsEmptyTitle,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.alarmsEmptySubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.go('/map'),
              icon: const Icon(Icons.map_outlined),
              label: Text(l10n.alarmsEmptyAction),
            ),
          ],
        ),
      ),
    );
  }
}
