import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/screens/hotel_page.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/services_card.dart';
import 'package:eventssytem/screens/currency_exchange_page.dart';
import 'package:eventssytem/screens/accridetation_center_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eventssytem/screens/contact_page.dart';
import 'transport_page.dart';
import 'navigation_page.dart';
class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String? eventId;
  String? participantId;

  @override
  void initState() {
    super.initState();
    _loadParticipantAndEventId(); // Load eventId and participantId when the page initializes
  }
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _loadParticipantAndEventId() async {
    final secureStorage = FlutterSecureStorage();
    final sharedPreferences = await SharedPreferences.getInstance();

    participantId = await secureStorage.read(key: 'participantId');
    eventId = sharedPreferences.getString('eventId');

    if (mounted) {
      setState(() {}); // Update the state to use the loaded eventId
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Background().background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: kIconColor),
          elevation: 0,
          centerTitle: true,
          title: Text(localizations?.services ?? '', style: kAppBarTextStyle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccreditationCentersPage(),
                      ),
                    );
                  },
                  child: ServicesCard(
                    text: localizations?.accreditationCenters ?? '',
                    text2: localizations?.accreditationCentersDescription ?? '',
                    icon: Image.asset("assets/icons/tag.png"),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransportPage(),
                      ),
                    );
                  },
                  child: ServicesCard(
                    text: localizations?.transfers ?? '',
                    text2: localizations?.transfersDescription ?? '',
                    icon: Image.asset("assets/icons/transport.png"),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    if (eventId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelsPage(eventId: eventId!),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(localizations?.eventIdNotFound ?? 'Event ID not found'),
                        ),
                      );
                    }
                  },
                  child: ServicesCard(
                    text: localizations?.recommendedHotels ?? '',
                    text2: localizations?.hotelsDescription ?? '',
                    icon: Image.asset("assets/icons/location.png"),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrencyExchangePage(),
                      ),
                    );
                  },
                  child: ServicesCard(
                    text: localizations?.currencyExchange ?? '',
                    text2: localizations?.currencyExchangeDescription ?? '',
                    icon: Image.asset("assets/icons/dollar.png"),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationPage(),
                      ),
                    );
                  },
                  child: ServicesCard(
                    text: localizations?.navigation ?? '',
                    text2: localizations?.navigationDescription ?? '',
                    icon: Image.asset("assets/icons/map.png"),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    // Launch the URL for the excursions page
                    _launchUrl("https://russiachinaforum.com/excursions2024#!/tab/796082314-2");
                  },
                  child: ServicesCard(
                    text: localizations?.excursions ?? '',
                    text2: localizations?.excursionsDescription ?? '',
                    icon: Image.asset("assets/icons/eye.png"),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactsPage(),
                      ),
                    );
                  },
                  child: ServicesCard(
                    text: localizations?.contacts ?? '',
                    text2: localizations?.contactsDescription ?? '',
                    icon: Image.asset("assets/icons/mail.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
