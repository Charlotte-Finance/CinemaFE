import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema_fe/repositories/file_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

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
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          var file = result.files.first;

          yield PictureLoaded(file: file);
        } else {
          throw Exception();
        }
      } catch (e) {
        yield PictureError();
      }
    }
    // if (event is DownloadFile) {
    //   try {
    //     final content = base64Encode(event.file.bytes!);
    //     AnchorElement(
    //         href:
    //             "data:application/octet-stream;charset=utf-16le;base64,$content")
    //       ..setAttribute("download", event.file.name)
    //       ..click();
    //
    //     //yield PictureLoaded(listFiles: listFiles);
    //   } catch (_) {
    //     yield PictureError();
    //   }
    // }

    if (event is PostFiles) {
      try {
        if (event.listFiles != null) {
          for (int i = 0; i < event.listFiles!.length; i++) {
            await fileRepository.postFile(event.listFiles![i], event.path);
          }
        }
        yield PicturePostSuccess();
      } catch (_) {
        yield PictureError();
      }
    }
  }
}
