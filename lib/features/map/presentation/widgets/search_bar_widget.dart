import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waypoint_alarm/features/map/data/geocoding_repository.dart';
import 'package:waypoint_alarm/features/map/providers/geocoding_provider.dart';
import 'package:waypoint_alarm/l10n/app_localizations.dart';

class MapSearchBar extends ConsumerStatefulWidget {
  const MapSearchBar({required this.onResultSelected, super.key});

  final void Function(GeocodingResult result) onResultSelected;

  @override
  ConsumerState<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends ConsumerState<MapSearchBar> {
  final _searchController = SearchController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SearchAnchor(
      searchController: _searchController,
      viewHintText: l10n.searchPlaceholder,
      viewLeading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => _searchController.closeView(null),
      ),
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          hintText: l10n.searchPlaceholder,
          leading: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.search),
          ),
          onTap: controller.openView,
          onChanged: (_) => controller.openView(),
          elevation: WidgetStateProperty.all(2),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 8),
          ),
        );
      },
      suggestionsBuilder: (context, controller) {
        return [
          Consumer(
            builder: (context, ref, child) {
              final query = controller.text;
              if (query.trim().length < 3) {
                return const SizedBox.shrink();
              }

              final searchAsync = ref.watch(geocodingSearchProvider(query));

              return searchAsync.when(
                data: (results) {
                  if (results.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: results
                        .map(
                          (result) => ListTile(
                            leading: const Icon(Icons.place_outlined),
                            title: Text(
                              result.displayName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              controller.closeView(result.displayName);
                              widget.onResultSelected(result);
                              controller.clear();
                            },
                          ),
                        )
                        .toList(),
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (e, st) {
                  return ListTile(
                    leading: const Icon(Icons.error_outline),
                    title: Text(l10n.errorSearching),
                  );
                },
              );
            },
          ),
        ];
      },
    );
  }
}
