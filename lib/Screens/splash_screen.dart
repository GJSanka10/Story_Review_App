import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_app/Screens/login_screen.dart';
import 'package:story_app/utils/colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
    @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 5500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start, 
            children: [
              Image.asset('images/van.gif'),
              const SizedBox(height: 10.0),

              Row(
                children: [
                  Image.asset(
                    'images/smile.png',
                    width: 40,
                    height: 40,
                  ),
                  Text('The Journey',
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: colors.mainHeadingColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Document your life, reflect on your journey.',
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                      color: colors.secondHeadingColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
