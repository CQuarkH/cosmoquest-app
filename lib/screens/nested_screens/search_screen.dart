import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cosmo_quest/components/molecules/celestial_body_card.dart';
import 'package:cosmo_quest/components/molecules/photo_card.dart';
import 'package:cosmo_quest/components/organisms/search_results_section.dart';
import 'package:cosmo_quest/models/celestial_body.dart';
import 'package:cosmo_quest/models/photo.dart';
import 'package:cosmo_quest/services/apod_service.dart';
import 'package:cosmo_quest/services/learning_service.dart';
import 'package:flutter_atoms/widgets/molecules/debounced_search_bar.dart';
import 'package:flutter_atoms/widgets/molecules/spaced_column.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final photosResults = useState<List<Photo>>([]);
    final celestialBodiesResults = useState<List<CelestialBody>>([]);
    final searchQuery = useState<String>('');

    final APODService apodService = APODService();
    final LearningService learningService = LearningService();

    Future<void> handleSearch(String query) async {
      searchQuery.value = query;
      if (query.isNotEmpty) {
        final photosSearchResults = await apodService.findPhotosByName(query);
        final celestialBodiesSearchResults =
            await learningService.findCelestialBodiesByName(query);
        photosResults.value = photosSearchResults;
        celestialBodiesResults.value = celestialBodiesSearchResults;
      } else {
        photosResults.value = [];
        celestialBodiesResults.value = [];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: DebouncedSearchBar(
          onSearchChanged: (value) async {
            await handleSearch(value);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SpacedColumn(
            children: [
              if (photosResults.value.isNotEmpty ||
                  celestialBodiesResults.value.isNotEmpty)
                ..._buildSearchResults(photosResults, celestialBodiesResults),
              if (photosResults.value.isEmpty &&
                  celestialBodiesResults.value.isEmpty &&
                  searchQuery.value.isNotEmpty)
                _buildNoResultsMessage(searchQuery),
              if (photosResults.value.isEmpty &&
                  celestialBodiesResults.value.isEmpty &&
                  searchQuery.value.isEmpty)
                _buildEmptySearchMessage(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSearchResults(ValueNotifier<List<Photo>> photosResults,
      ValueNotifier<List<CelestialBody>> celestialBodiesResults) {
    return [
      if (photosResults.value.isNotEmpty)
        SearchResultsSection(
          sectionTitle: "PHOTOS",
          searchResults: photosResults.value,
          itemBuilder: (context, item) => PhotoCard(
            photo: item,
            bottomWidget: Text(item.title),
            heroTag: 'photo-${item.title}',
          ),
        ),
      if (celestialBodiesResults.value.isNotEmpty)
        SearchResultsSection(
          sectionTitle: "BODIES",
          searchResults: celestialBodiesResults.value,
          itemBuilder: (context, item) => CelestialBodyCard(
            celestialBody: item,
          ),
        ),
    ];
  }

  Widget _buildNoResultsMessage(ValueNotifier<String> searchQuery) {
    return Center(
      child: Text(
        "No results found for '${searchQuery.value}'.",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEmptySearchMessage() {
    return const Center(
      child: Text(
        "Start searching by typing in the search bar above.",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
