part of 'picture_bloc.dart';

abstract class PictureState extends Equatable {
  @override
  List<Object> get props => [];
}

class PictureLoading extends PictureState {}

class PictureError extends PictureState {}

class PictureEmpty extends PictureState {}

class PicturePostSuccess extends PictureState {}

class PictureLoaded extends PictureState {
  final PlatformFile file;

  PictureLoaded({required this.file});

  @override
  List<Object> get props => [file];
}
