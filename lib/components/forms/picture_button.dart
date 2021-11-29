import 'package:cinema_fe/blocs/picture/picture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PictureButton extends StatelessWidget {
  const PictureButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PictureBloc, PictureState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text("Choose a picture"),
                onPressed: () {
                  BlocProvider.of<PictureBloc>(context).add(UploadFile());
                }),
            if (state is PictureError)
              const Text("Error while loading the picture")
            else if (state is PictureLoaded)
              ElevatedButton(
                  child: const Text("Verify picture"),
                  onPressed: () {
                    BlocProvider.of<PictureBloc>(context)
                        .add(DownloadFile(file: state.file));
                  })
            else if (state is PictureLoading)
              const CircularProgressIndicator()
            else
              Container()
          ],
        );
      },
    );
  }
}
