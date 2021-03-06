part of 'picture_bloc.dart';

abstract class PictureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadFile extends PictureEvent {}

class DownloadFile extends PictureEvent {
  final XFile file;

  DownloadFile({required this.file});

  @override
  List<Object> get props => [file];
}

class PostFiles extends PictureEvent {
  final List<ImagePicker>? listFiles;
  final String path;

  PostFiles({required this.listFiles, required this.path});

  @override
  List<Object?> get props => [listFiles, path];
}

class DeleteFile extends PictureEvent {
  final ImagePicker file;

  DeleteFile({required this.file});
}
