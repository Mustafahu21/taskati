import 'package:flutter/material.dart';
import 'package:taskati/core/constants/asset_names.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/extensions/navigations.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/pfp_upload.dart/pfp_upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      pushReplacement(context, const UploadScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets.splashAnimation, width: 250, height: 250),
            SizedBox(height: 50),
            Text('Taskati', style: TextStyles.getBody(fontSize: 26)),
            SizedBox(height: 30),
            Text(
              'It\'s Time to Get Organized',
              style: TextStyles.getSmall(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
