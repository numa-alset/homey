import 'package:flutter/material.dart';

class SplashWaiting extends StatelessWidget {
  const SplashWaiting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: Colors.white,),);
  }
}
