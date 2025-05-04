import 'package:flutter/material.dart';

class ErrorMessege extends StatelessWidget {
  const ErrorMessege({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Произошла ошибка, перезайдите')));
  }
}
