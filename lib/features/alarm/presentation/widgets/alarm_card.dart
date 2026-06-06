import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';
import 'package:waypoint_alarm/features/alarm/presentation/widgets/alarm_bottom_sheet.dart';
import 'package:waypoint_alarm/features/alarm/providers/alarm_provider.dart';
import 'package:waypoint_alarm/features/monitoring/providers/monitoring_provider.dart';
import 'package:waypoint_alarm/l10n/app_localizations.dart';

class AlarmCard extends ConsumerWidget {
  const AlarmCard({
    required this.alarm,
    super.key,
  });

  final AlarmModel alarm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Dismissible(
      key: ValueKey(alarm.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(context, l10n),
      onDismissed: (_) {
        if (alarm.id != null) {
          ref.read(alarmRepositoryProvider).deleteAlarmById(alarm.id!).ignore();
        }
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _openEditSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _LeadingIcon(isActive: alarm.isActive),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alarm.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${alarm.radiusMeters.round()} ${l10n.unitMeters}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                          if (alarm.isActive) ...[
                            const SizedBox(width: 16),
                            TextButton.icon(
                              onPressed: () {
                                if (alarm.id != null) {
                                  ref
                                      .read(monitoringServiceProvider.notifier)
                                      .dismissAlarm(alarm.id!);
                                }
                              },
                              icon: const Icon(
                                Icons.stop_circle_outlined,
                                size: 16,
                              ),
                              label: Text(
                                l10n.alarmDismiss,
                                style: const TextStyle(fontSize: 12),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: alarm.isActive,
                  onChanged: (value) {
                    if (alarm.id != null) {
                      ref
                          .read(alarmRepositoryProvider)
                          .toggleAlarmStatus(alarm.id!, isActive: value)
                          .ignore();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, AppLocalizations l10n) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.alarmDeleteConfirmTitle),
        content: Text(l10n.alarmDeleteConfirmMessage(alarm.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.alarmDelete),
          ),
        ],
      ),
    );
  }

  void _openEditSheet(BuildContext context) {
    showAlarmBottomSheet(
      context,
      coordinates: LatLng(alarm.latitude, alarm.longitude),
      existingAlarm: alarm,
    ).ignore();
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        isActive ? Icons.alarm_on : Icons.alarm_off,
        color: isActive
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
