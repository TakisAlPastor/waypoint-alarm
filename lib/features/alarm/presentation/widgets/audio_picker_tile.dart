import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:waypoint_alarm/l10n/app_localizations.dart';

class AudioPickerTile extends StatefulWidget {
  const AudioPickerTile({
    required this.onAudioSelected,
    this.currentFilePath,
    super.key,
  });

  final String? currentFilePath;
  final ValueChanged<String?> onAudioSelected;

  @override
  State<AudioPickerTile> createState() => _AudioPickerTileState();
}

class _AudioPickerTileState extends State<AudioPickerTile> {
  final AudioPlayer _previewPlayer = AudioPlayer();

  @override
  void dispose() {
    _previewPlayer.dispose().ignore();
    super.dispose();
  }

  Future<void> _pickAudioFile() async {
    await _previewPlayer.stop();

    try {
      final result = await FilePicker.pickFiles(
        type: FileType.audio,
      );

      if (result == null || result.files.single.path == null) return;

      widget.onAudioSelected(result.files.single.path);
    } on Exception catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  Future<void> _togglePreview() async {
    try {
      if (_previewPlayer.playing) {
        await _previewPlayer.stop();
        return;
      }

      final path = widget.currentFilePath;
      if (path == null) return;

      await _previewPlayer.setFilePath(path);
      await _previewPlayer.play();
    } on PlayerException catch (e) {
      debugPrint('PLayer error: ${e.message}');
      await _previewPlayer.stop();
    } on PlayerInterruptedException catch (e) {
      debugPrint('Connection aborted: ${e.message}');
    } on Exception catch (e) {
      debugPrint('Error loading audio preview: $e');
      await _previewPlayer.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasCustomAudio = widget.currentFilePath != null;
    final displayName = hasCustomAudio
        ? p.basename(widget.currentFilePath!)
        : l10n.alarmToneDefault;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.alarmToneLabel,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          leading: Icon(
            hasCustomAudio ? Icons.music_note : Icons.notifications_active,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasCustomAudio)
                StreamBuilder<PlayerState>(
                  stream: _previewPlayer.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final isPlaying = playerState?.playing ?? false;
                    final processingState = playerState?.processingState;

                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return const SizedBox(
                        width: 48,
                        height: 48,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }

                    return IconButton(
                      onPressed: _togglePreview,
                      icon: Icon(
                        isPlaying ? Icons.stop_circle : Icons.play_circle,
                      ),
                    );
                  },
                ),
              TextButton(
                onPressed: _pickAudioFile,
                child: Text(l10n.alarmToneChoose),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
