import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema_fe/repositories/file_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc() : super(PictureEmpty());

  final FileRepository fileRepository = FileRepository();

  @override
  Stream<PictureState> mapEventToState(
    PictureEvent event,
  ) async* {
    yield PictureLoading();
    if (event is UploadFile) {
      try {
        final ImagePicker _picker = ImagePicker();

        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);

        print(image!.name);

        //FilePickerResult? result = await FilePicker.platform.pickFiles();

        yield PictureLoaded(file: image);
      } catch (e) {
        print(e.toString());
        yield PictureError();
      }
    }

    if (event is DownloadFile) {
      try {

        GallerySaver.saveImage(event.file.path);



        yield PictureLoaded(file: event.file);
      } catch (_) {
        print(_.toString());
        yield PictureError();
      }
    }

    if (event is PostFiles) {
      try {
        /*if (event.listFiles != null) {
          for (int i = 0; i < event.listFiles!.length; i++) {
            await fileRepository.postFile(event.listFiles![i], event.path);
          }
        }*/
        yield PicturePostSuccess();
      } catch (_) {
        yield PictureError();
      }
    }
  }
}
