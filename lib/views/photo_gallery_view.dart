import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/app_bloc.dart';
import '../bloc/main_popup_menu_button.dart';
import '../utils/extensions.dart';
import 'storage_image_view.dart';

class PhotoGalleryView extends HookWidget {
  const PhotoGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final appBloc = context.read<AppBloc>();
    final images = context.watch<AppBloc>().state.images ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery ${images.length}'),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.gallery);
              if (image == null) return;
              appBloc.add(AppEventUploadImage(image.path));
            },
            icon: const Icon(Icons.upload_rounded),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          padding: const EdgeInsets.all(20.0),
          itemCount: images.length,
          itemBuilder: (_, i) => StorageImageView(image: images[i])),
    );
  }
}
