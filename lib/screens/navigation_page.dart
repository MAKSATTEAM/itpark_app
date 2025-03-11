import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.navigation ?? ''),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/scheme1.jpg',
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20), 
            Image.asset(
              'assets/images/scheme.jpg',
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
