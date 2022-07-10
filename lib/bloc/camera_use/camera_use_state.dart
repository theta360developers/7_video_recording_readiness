// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'camera_use_bloc.dart';

class CameraUseState extends Equatable {
  final String message;
  final String id;
  final String cameraStatus;
  final String fileUrl;
  double elapsedTime = 0.0;
  CameraUseState(
      {required this.message,
      this.id = "",
      this.cameraStatus = "",
      this.fileUrl = "",
      this.elapsedTime = 0.0});

  factory CameraUseState.initial() => CameraUseState(
      message: "initial",
      id: "",
      cameraStatus: "",
      fileUrl: "",
      elapsedTime: 0.0);

  @override
  List<Object> get props => [message, id, cameraStatus, fileUrl, elapsedTime];

  @override
  bool get stringify => true;

  CameraUseState copyWith({
    String? message,
  }) {
    return CameraUseState(
      message: message ?? this.message,
    );
  }
}
