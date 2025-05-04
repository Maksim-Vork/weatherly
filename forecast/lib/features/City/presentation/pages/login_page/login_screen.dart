import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/city_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/city_state.dart';
import 'package:forecast/features/City/presentation/pages/login_page/widgets/error_messege.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          if (state is CityLoading) {
            return CircularProgressIndicator();
          } else if (state is CityNotFound) {
            return WelcomScreen();
          } else {
            return ErrorMessege();
          }
        },
      ),
    );
  }
}

class WelcomScreen extends StatelessWidget {
  WelcomScreen({super.key});
  final TextEditingController _controllerCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5698DE),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10),
            Column(
              children: [
                Image.asset(
                  'assets/img/login_img.png',
                  width: 159,
                  height: 171,
                ),

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
            ),
            Column(
              children: [
                Text(
                  'Введите город',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 5),
                Form(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 280,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: TextFormField(
                        controller: _controllerCity,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                SizedBox(
                  width: 280,
                  height: 70,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color(0xFF333333),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Войти',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Text('0.0.1 version'),
          ],
        ),
      ),
    );
  }
}
