import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_clone/state/image_upload/provider/image_uploader_provider.dart';
import 'package:instagram_clone/state/post_setting/model/post_setting.dart';
import 'package:instagram_clone/state/post_setting/providers/post_setting_provider.dart';
import 'package:instagram_clone/views/constants/strings.dart';

import '../file_thumbnail_view.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;

  const CreateNewPostView(
      {required this.fileToPost, required this.fileType, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest =
        ThumbnailRequest(file: widget.fileToPost, fileType: widget.fileType);
    final postSetting = ref.watch(postSettingProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(
      () {
        void listener() {
          isPostButtonEnabled.value = postController.text.isNotEmpty;
        }

        postController.addListener(listener);
        return () {
          postController.removeListener(listener);
        };
      },
      [postController],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text;
                    final isUploaded = await ref
                        .read(imageUploadProvider.notifier)
                        .upload(
                            file: widget.fileToPost,
                            fileType: widget.fileType,
                            message: message,
                            postSettings: postSetting,
                            userId: userId);
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FileThumbnailView(thumbnailRequest: thumbnailRequest),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: postController,
              decoration: const InputDecoration(
                  labelText: Strings.pleaseWriteYourMessageHere),
              autofocus: true,
              maxLines: null,
            ),
          ),
          ...PostSetting.values.map((setting) => ListTile(
                trailing: Switch(
                  value: postSetting[setting] ?? false,
                  onChanged: (isOn) {
                    ref.read(postSettingProvider.notifier).setSetting(
                          setting,
                          isOn,
                        );
                  },
                ),
                title: Text(setting.title),
                subtitle: Text(setting.description),
              )),
        ],
      )),
    );
  }
}
