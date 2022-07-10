import 'package:flutter/material.dart';
import 'package:theta_concept_7/bloc/camera_use/camera_use_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraUseBloc(),
      child: MaterialApp(
        home: BlocBuilder<CameraUseBloc, CameraUseState>(
          builder: (context, state) {
            return Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.read<CameraUseBloc>().add(VideoModeEvent());
                        },
                        iconSize: 40,
                        icon: const Icon(
                          Icons.video_camera_front,
                          color: Colors.black54,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<CameraUseBloc>()
                              .add(StartCaptureEvent());
                        },
                        iconSize: 80,
                        icon: const Icon(
                          Icons.play_circle_outline_outlined,
                          color: Color.fromARGB(255, 255, 126, 117),
                        )),
                    IconButton(
                        onPressed: () {
                          context.read<CameraUseBloc>().add(StopCaptureEvent());
                        },
                        iconSize: 80,
                        icon: const Icon(Icons.stop_circle_outlined,
                            color: Color.fromARGB(255, 255, 126, 117)))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('State: ${state.cameraStatus}')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('${state.elapsedTime}')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.fileUrl.isNotEmpty && state.cameraStatus == 'done'
                        ? SizedBox(
                            width: 300,
                            child: Image.network(
                              '${state.fileUrl}?type=thumb',
                            ))
                        : Container()
                  ],
                )
              ],
            ));
          },
        ),
      ),
    );
  }
}
