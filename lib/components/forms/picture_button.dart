import 'dart:io';

import 'package:cinema_fe/blocs/picture/picture_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PictureButton extends StatelessWidget {
  const PictureButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PictureBloc, PictureState>(
      builder: (context, state) {
        return Row(
          children: [
            ElevatedButton(
              child: const Text("Choose a picture"),
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.single.path!);
                  print(file.path);
                } else {
                  // User canceled the picker
                }
              },
            ),
            if (state is PictureError)
              const Text("Error while loading the picture")
            else if (state is PictureLoaded)
              Text(state.file.name)
            else
              const CircularProgressIndicator()
          ],
        );
      },
    );
  }
}
