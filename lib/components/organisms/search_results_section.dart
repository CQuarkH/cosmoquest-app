import 'package:flutter/material.dart';
import 'package:flutter_atoms/widgets/molecules/spaced_column.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchResultsSection extends StatelessWidget {
  final String sectionTitle;
  final List<dynamic> searchResults;
  final Widget Function(BuildContext context, dynamic item) itemBuilder;

  const SearchResultsSection({
    Key? key,
    required this.sectionTitle,
    required this.searchResults,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        MasonryGridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final item = searchResults[index];
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: itemBuilder(context, item));
          },
        ),
      ],
    );
  }
}
