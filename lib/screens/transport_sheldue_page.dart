import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';

class TransportSchedulePage extends StatelessWidget {
  const TransportSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.transfers ?? 'Трансферы'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      extendBody: true, 
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Background().background),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 120.0, 16.0, 16.0), // Add padding at the top for spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations?.transferHeader ?? 'Уважаемые гости и участники форума!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16), // Increased spacing below the header
              Text(
                localizations?.transferDetails ?? '14 и 15 ноября будет предоставлено регулярное автобусное сообщение...',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              // Shuttle Schedule Images
              Image.asset(
                'assets/images/shuttle_schedule_to_expo.png',
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              Image.asset(
                'assets/images/shuttle_schedule_from_expo.png',
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              // Additional Transport Options
              Text(
                localizations?.additionalTransportOptions ?? 'Дополнительные способы доехать до МВЦ "Казань Экспо"',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                localizations?.aeroexpressDetails ?? '1. Аэроэкспресс от ЖД Вокзала "Казань 1" до конечной остановки "Аэропорт"',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                localizations?.bus197Details ?? '2. На городском автобусе №197 от Автовокзала "Восточный" до остановки "Аэропорт"',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              // Aeroexpress Schedule Image
              Image.asset(
                'assets/images/aeroexpress_schedule.png',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
