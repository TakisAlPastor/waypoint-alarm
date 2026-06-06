import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waypoint_alarm/core/constants/alarm_defaults.dart';
import 'package:waypoint_alarm/l10n/app_localizations.dart';

class RadiusSlider extends StatefulWidget {
  const RadiusSlider({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<RadiusSlider> createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<RadiusSlider> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: widget.value.round().toString(),
    );
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _onTextSubmitted(_textController.text);
      }
    });
  }

  @override
  void didUpdateWidget(RadiusSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      final newText = widget.value.round().toString();
      if (_textController.text != newText) {
        _textController.text = newText;
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextSubmitted(String text) {
    final parsed = double.tryParse(text);
    if (parsed == null) {
      _textController.text = widget.value.round().toString();
      return;
    }

    final clamped = parsed.clamp(kMinRadiusMeters, kMaxRadiusMeters);
    widget.onChanged(clamped);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.alarmRadiusLabel,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: widget.value,
                min: kMinRadiusMeters,
                max: kMaxRadiusMeters,
                divisions: ((kMaxRadiusMeters - kMinRadiusMeters) / 100)
                    .round(),
                label: '${widget.value.round()} ${l10n.unitMeters}',
                onChanged: widget.onChanged,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 80,
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  suffixText: l10n.unitMeters,
                  isDense: true,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  suffixStyle: Theme.of(context).textTheme.bodySmall,
                ),
                onSubmitted: _onTextSubmitted,
                focusNode: _focusNode,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
