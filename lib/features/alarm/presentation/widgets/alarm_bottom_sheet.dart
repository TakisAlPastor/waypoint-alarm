import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:waypoint_alarm/core/constants/alarm_defaults.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';
import 'package:waypoint_alarm/features/alarm/presentation/widgets/audio_picker_tile.dart';
import 'package:waypoint_alarm/features/alarm/presentation/widgets/radius_slider.dart';
import 'package:waypoint_alarm/features/alarm/providers/alarm_provider.dart';
import 'package:waypoint_alarm/l10n/app_localizations.dart';

Future<void> showAlarmBottomSheet(
  BuildContext context, {
  required LatLng coordinates,
  AlarmModel? existingAlarm,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => AlarmBottomSheet(
      coordinates: coordinates,
      existingAlarm: existingAlarm,
    ),
  );
}

class AlarmBottomSheet extends ConsumerStatefulWidget {
  const AlarmBottomSheet({
    required this.coordinates,
    this.existingAlarm,
    super.key,
  });

  final LatLng coordinates;
  final AlarmModel? existingAlarm;

  @override
  ConsumerState<AlarmBottomSheet> createState() => _AlarmBottomSheetState();
}

class _AlarmBottomSheetState extends ConsumerState<AlarmBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late double _radiusMeters;
  late int _volumePercent;
  late AlarmTriggerBehavior _triggerBehavior;
  String? _audioFilePath;
  bool _isSaving = false;

  bool get _isEditing => widget.existingAlarm != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingAlarm;

    _nameController = TextEditingController(text: existing?.name ?? '');
    _radiusMeters = existing?.radiusMeters ?? kDefaultRadiusMeters;
    _volumePercent = existing?.volumePercent ?? kDefaultVolumePercent;
    _triggerBehavior =
        existing?.triggerBehavior ?? AlarmTriggerBehavior.oneTime;
    _audioFilePath = existing?.audioFilePath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveAlarm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final repository = ref.read(alarmRepositoryProvider);

    try {
      if (_isEditing) {
        final updated = widget.existingAlarm!.copyWith(
          name: _nameController.text.trim(),
          radiusMeters: _radiusMeters,
          audioFilePath: _audioFilePath,
          volumePercent: _volumePercent,
          triggerBehavior: _triggerBehavior,
          isActive: true,
        );
        await repository.updateAlarm(updated);
      } else {
        final alarm = AlarmModel(
          name: _nameController.text.trim(),
          latitude: widget.coordinates.latitude,
          longitude: widget.coordinates.longitude,
          radiusMeters: _radiusMeters,
          audioFilePath: _audioFilePath,
          volumePercent: _volumePercent,
          triggerBehavior: _triggerBehavior,
          isActive: true,
          createdAt: DateTime.now(),
          triggerDurationSeconds: kDefaultTriggerDuration,
        );
        await repository.addAlarm(alarm);
      }

      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              controller: scrollController,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                          .withValues(
                            alpha: 0.4,
                          ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  _isEditing ? l10n.alarmEdit : l10n.alarmSave,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.alarmNameLabel,
                    hintText: l10n.alarmNameHint,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.label_outline),
                  ),
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.alarmNameLabel;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                RadiusSlider(
                  value: _radiusMeters,
                  onChanged: (value) {
                    setState(() => _radiusMeters = value);
                  },
                ),
                const SizedBox(height: 24),
                AudioPickerTile(
                  currentFilePath: _audioFilePath,
                  onAudioSelected: (path) {
                    setState(() => _audioFilePath = path);
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.alarmVolumeLabel,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      _volumePercent == kMinVolumePercent
                          ? Icons.volume_off
                          : Icons.volume_up,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: Slider(
                        value: _volumePercent.toDouble(),
                        min: kMinVolumePercent.toDouble(),
                        max: kMaxVolumePercent.toDouble(),
                        divisions: kMaxVolumePercent,
                        label: '$_volumePercent${l10n.unitPercent}',
                        onChanged: (value) {
                          setState(() => _volumePercent = value.round());
                        },
                      ),
                    ),
                    SizedBox(
                      width: 48,
                      child: Text(
                        '$_volumePercent${l10n.unitPercent}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.alarmTriggerBehaviorLabel,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                SegmentedButton<AlarmTriggerBehavior>(
                  segments: [
                    ButtonSegment(
                      value: AlarmTriggerBehavior.oneTime,
                      label: Text(l10n.triggerAutoDeactivate),
                      icon: const Icon(Icons.timer_off),
                    ),
                    ButtonSegment(
                      value: AlarmTriggerBehavior.dismissible,
                      label: Text(l10n.triggerManualDismiss),
                      icon: const Icon(Icons.touch_app),
                    ),
                  ],
                  selected: {_triggerBehavior},
                  onSelectionChanged: (selection) {
                    setState(() => _triggerBehavior = selection.first);
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isSaving
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: Text(l10n.alarmCancel),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: FilledButton.icon(
                        onPressed: _isSaving ? null : _saveAlarm,
                        icon: _isSaving
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.alarm_add),
                        label: Text(l10n.alarmSave),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
