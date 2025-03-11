import 'package:flutter/material.dart';
import 'package:eventssytem/cubit/all/api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelsPage extends StatefulWidget {
  final String eventId;

  const HotelsPage({super.key, required this.eventId});

  @override
  _HotelsPageState createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  late Future<List<Hotel>> _hotels;

  @override
  void initState() {
    super.initState();
    _hotels = HotelsApi().fetchHotels(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.recommendedHotels ?? 'Recommended Hotels'),
      ),
      body: FutureBuilder<List<Hotel>>(
        future: _hotels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching hotels'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hotels available'));
          }

          final hotels = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              return Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hotel.imageUrl.isNotEmpty)
                        Image.network(hotel.imageUrl, fit: BoxFit.cover),
                      SizedBox(height: 8),
                      Text(hotel.name, style: Theme.of(context).textTheme.headlineSmall),
                      SizedBox(height: 4),
                      Text('${localizations?.address ?? 'Address'}: ${hotel.address}'),
                      SizedBox(height: 4),
                      Text('${localizations?.phone ?? 'Phone'}: ${hotel.phone}'),
                      SizedBox(height: 4),
                      Text('${localizations?.email ?? 'Email'}: ${hotel.email}'),
                      SizedBox(height: 4),
                      Text('${localizations?.description ?? 'Description'}: ${hotel.description}'),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(hotel.website));
                        },
                        child: Text(localizations?.visitWebsite ?? 'Visit Website'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
