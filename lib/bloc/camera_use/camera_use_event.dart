part of 'camera_use_bloc.dart';

abstract class CameraUseEvent extends Equatable {
  const CameraUseEvent();

  @override
  List<Object> get props => [];
}

class StartCaptureEvent extends CameraUseEvent {}

class StopCaptureEvent extends CameraUseEvent {}

class VideoModeEvent extends CameraUseEvent {}

class CameraStatusEvent extends CameraUseEvent {}
