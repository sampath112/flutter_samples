import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureExample(),
    );
  }
}

class GestureExample extends StatefulWidget {
  @override
  _GestureExampleState createState() => _GestureExampleState();
}

class _GestureExampleState extends State<GestureExample> {
  String _gestureText = "Try different gestures!";
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _startOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gesture Detector Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() => _gestureText = "Single Tap detected");
              },
              onDoubleTap: () {
                setState(() => _gestureText = "Double Tap detected");
              },
              onPanUpdate: (details) {
                setState(() {
                  _gestureText = "Dragging...";
                  _offset += details.delta;
                });
              },
              onPanEnd: (details) {
                setState(() => _gestureText = "Drag Released");
              },
              onLongPress: () {
                setState(() => _gestureText = "Long Press detected");
              },
              child: Transform.translate(
                offset: _offset,
                child: InteractiveViewer(
                  scaleEnabled: true,
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 3.0,
                  onInteractionStart: (details) {
                    _previousScale = _scale;
                  },
                  onInteractionUpdate: (details) {
                    setState(() {
                      _scale = _previousScale * details.scale;
                      _gestureText =
                          details.scale > 1 ? "Zooming In" : "Pinching";
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Gesture Box",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _gestureText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
