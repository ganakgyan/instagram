import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/likes/models/like_dislike_request.dart';
import 'package:instagram_clone/state/likes/providers/has_liked_post_provider.dart';
import 'package:instagram_clone/state/likes/providers/like_dislike_post_provider.dart';
import 'package:instagram_clone/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;

  const LikeButton({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));
    return hasLiked.when(data: (hasLiked) {
      return IconButton(
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            } else {
              final likeRequest = LikeDislikeRequest(
                postId: postId,
                likedBy: userId,
              );
              ref.read(
                likeDislikePostProvider(likeRequest),
              );
            }
          },
          icon: FaIcon(
              hasLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart));
    }, error: (error, _) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const LoadingAnimationView();
    });
  }
}
