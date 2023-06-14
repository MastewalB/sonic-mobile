import 'package:flutter/material.dart';
import '../../components/header.dart';
import '../../components/my_files.dart';
import '../../components/recent_files.dart';
import '../../components/playlist_header.dart';
import '../components/record_list.dart';

class AudioRecorderUI extends StatefulWidget {
  @override
  _AudioRecorderUIState createState() => _AudioRecorderUIState();
}

class _AudioRecorderUIState extends State<AudioRecorderUI> {
  bool _isRecording = false;

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });

    // Add your logic here to start or stop the recording
    if (_isRecording) {
      // Start recording
      print('Recording started');
    } else {
      // Stop recording
      print('Recording stopped');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 17, 5, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Assuming this is a custom widget representing the recorded files
                  SizedBox(height: 20),

                  FloatingActionButton(
                    onPressed: _toggleRecording,
                    child: Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                    ),
                    backgroundColor: _isRecording ? Colors.red : Colors.blue,
                  ),

                  SizedBox(height: 20),
                  Text(
                    _isRecording ? 'Recording' : 'Tap to Record',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            RecordFiles(),
          ],
        ),
      ),
    );
  }
}

class RecordButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isRecording;

  RecordButton({required this.onPressed, required this.isRecording});

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      child: Icon(
        widget.isRecording ? Icons.stop : Icons.mic,
      ),
      backgroundColor: widget.isRecording ? Colors.red : Colors.blue,
    );
  }
}
