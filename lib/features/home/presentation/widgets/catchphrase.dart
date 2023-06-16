import 'package:flutter/material.dart';

class CatchPhrase extends StatefulWidget {
  final String text;

  const CatchPhrase({Key? key, required this.text}) : super(key: key);

  @override
  _CatchPhraseState createState() => _CatchPhraseState();
}

class _CatchPhraseState extends State<CatchPhrase>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // color: const Color.fromARGB(255, 31, 29, 43),
      color: Colors.transparent,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            // child: Text(
            //   widget.text,
            //   style: const TextStyle(
            //     color: Colors.blue,
            //     fontSize: 33.0,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            child: Center(
              child: Image(image: AssetImage('assets/logoblack.png')),
            )),
      ),
    );
  }
}
