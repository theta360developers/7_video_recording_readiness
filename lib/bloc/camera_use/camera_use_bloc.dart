import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_concept_7/services/theta_service.dart';

part 'camera_use_event.dart';
part 'camera_use_state.dart';

class CameraUseBloc extends Bloc<CameraUseEvent, CameraUseState> {
  CameraUseBloc() : super(CameraUseState.initial()) {
    var chopper = ChopperClient(
        services: [ThetaService.create()], converter: const JsonConverter());
    final thetaService = chopper.getService<ThetaService>();
    Stopwatch stopwatch = Stopwatch();
    on<StartCaptureEvent>((event, emit) async {
      var response =
          await thetaService.command({'name': 'camera.startCapture'});
      var convertResponse = jsonDecode(response.bodyString);
      var id = convertResponse['id'];

      if (convertResponse != null && id != null) {
        stopwatch.start();
        emit(CameraUseState(message: response.bodyString, id: id));
        while (state.cameraStatus != "done") {
          add(CameraStatusEvent());
          await Future.delayed(Duration(milliseconds: 100));
          print(state.cameraStatus);
          emit(CameraUseState(
              message: response.bodyString,
              id: id,
              cameraStatus: state.cameraStatus,
              fileUrl: state.fileUrl,
              elapsedTime: stopwatch.elapsedMilliseconds.toDouble()));
        }
        stopwatch.stop();
        stopwatch.reset();
      }
    });
    on<StopCaptureEvent>((event, emit) async {
      var response = await thetaService.command({'name': 'camera.stopCapture'});
      var convertResponse = jsonDecode(response.bodyString);
      var fileUrl = convertResponse['results']['fileUrls'][0];
      print(fileUrl);
      emit(CameraUseState(
          message: response.bodyString,
          elapsedTime: state.elapsedTime,
          fileUrl: fileUrl));
    });
    on<CameraStatusEvent>((event, emit) async {
      if (state.id.isNotEmpty) {
        var response = await thetaService.status({'id': state.id});
        var convertResponse = jsonDecode(response.bodyString);
        var cameraState = convertResponse['state'];

        emit(CameraUseState(
            message: response.bodyString,
            id: state.id,
            cameraStatus: cameraState,
            elapsedTime: state.elapsedTime,
            fileUrl: state.fileUrl));
      }
    });
    on<VideoModeEvent>((event, emit) async {
      var response = await thetaService.command({
        'name': 'camera.setOptions',
        'parameters': {
          'options': {'captureMode': 'video'}
        }
      });
    });
  }
}
