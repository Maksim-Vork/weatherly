import 'package:flutter/material.dart';

class ImageLoginScreen extends StatelessWidget {
  const ImageLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/img/login_img.png', width: 159, height: 171),

        SizedBox(
          width: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '8',
                style: TextStyle(
                  fontSize: 100,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Positioned(
                top: 15,
                right: 5,
                child: Text(
                  '°',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
