import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/posts/providers/post_by_search_term_provider.dart';
import 'package:instagram_clone/views/components/animations/data_not_found_animation_view.dart';
import 'package:instagram_clone/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/post/posts_sliver_grid_view.dart';
import 'package:instagram_clone/views/constants/strings.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;

  const SearchGridView({required this.searchTerm, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(
          text: Strings.enterYourSearchTerm,
        ),
      );
    }
    final posts = ref.watch(postBySearchTermProvider(searchTerm));
    return posts.when(data: (posts) {
      if (posts.isEmpty) {
        return const SliverToBoxAdapter(
          child: DataNotFoundAnimationView(),
        );
      } else {
        return PostsSliverGridView(
          posts: posts,
        );
      }
    }, error: (error, _) {
      return const SliverToBoxAdapter(child: ErrorAnimationView());
    }, loading: () {
      return const SliverToBoxAdapter(child: LoadingAnimationView());
    });
  }
}
