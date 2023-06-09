import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comment/models/comment.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone/views/components/rich_two_parts_text.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;

  const CompactCommentTile({required this.comment, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    return userInfo.when(data: (userInfo) {
      return RichTwoPartText(
          leftPart: userInfo.displayName ?? "", rightPart: comment.comment);
    }, error: (error, _) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const LoadingAnimationView();
    });
  }
}
