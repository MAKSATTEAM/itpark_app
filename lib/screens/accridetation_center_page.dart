import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';

class AccreditationCentersPage extends StatelessWidget {
  const AccreditationCentersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.accreditationCenters ?? 'Accreditation Centers'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Background().background),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListView(
              children: [
                ExchangeLocationCard(
                  title: localizations?.korstonKazanTitle ?? 'Korston Kazan',
                  address: localizations?.korstonKazanAddress ?? 'Kazan, Tatarstan, RussiaInternational Exhibition Center Kazan Expo, Tatarstan',
                  hours: localizations?.korstonKazanHours ?? '07:30-17:00',
                  note: localizations?.korstonKazanNote ?? 'Text',
                  type: localizations?.primary ?? 'Основной', // Localization for "Primary"
                  typeColor: Colors.blue, // Color for "Основной"
                ),
                SizedBox(height: 16),
                ExchangeLocationCard(
                  title: localizations?.kazanExpoTitle ?? 'Kazan Expo',
                  address: localizations?.kazanExpoAddress ?? 'International Exhibition Center Kazan Expo, Tatarstan',
                  hours: localizations?.kazanExpoHours ?? '07:30-17:00',
                  note: localizations?.kazanExpoNote ?? 'Text',
                  type: localizations?.additional ?? 'Дополнительный', // Localization for "Additional"
                  typeColor: Colors.blueAccent, // Color for "Дополнительный"
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExchangeLocationCard extends StatelessWidget {
  final String title;
  final String address;
  final String hours;
  final String note;
  final String type;
  final Color typeColor;

  const ExchangeLocationCard({
    super.key,
    required this.title,
    required this.address,
    required this.hours,
    required this.note,
    required this.type,
    required this.typeColor,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: TextStyle(
                color: typeColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('${localizations?.address ?? 'Address'}: $address'),
            SizedBox(height: 8),
            Text('${localizations?.workingHours ?? 'Working Hours'}: $hours'),
            SizedBox(height: 8),
            //Text('${localizations?.note ?? 'Note'}: $note'),
          ],
        ),
      ),
    );
  }
}
