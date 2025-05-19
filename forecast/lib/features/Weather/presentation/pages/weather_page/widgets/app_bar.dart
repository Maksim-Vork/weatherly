import 'package:flutter/material.dart';
import 'package:forecast/features/Settings/presentation/pages/setting_screen.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Chill',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 5),
            Text(
              'прогноз',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingScreen()),
            );
          },
          icon: Icon(Icons.settings, size: 34),
        ),
      ],
    );
  }
}
