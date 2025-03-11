import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eventssytem/screens/contact_orginize_page.dart';
import 'package:eventssytem/widgets/background.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not make a call to $phoneNumber';
    }
  }

  Future<void> _sendEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not send an email to $email';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Background().background), // Путь к изображению фона
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Сделать Scaffold прозрачным
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Прозрачный AppBar
          elevation: 0, // Убрать тень
          title: Text(localizations?.contacts ?? 'Contacts'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.phone, color: Colors.blue),
                title: Text('+7 (843) 570-40-01'),
                subtitle: Text(localizations?.callUs ?? 'Call Us'),
                onTap: () => _makePhoneCall('+78435704001'),
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.blue),
                title: Text('forumrostki@mail.ru'),
                subtitle: Text(localizations?.emailUs ?? 'Email Us'),
                onTap: () => _sendEmail('forumrostki@mail.ru'),
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text(localizations?.address ?? 'Address'),
                subtitle: Text(
                  localizations?.expoCenterAddress ??
                  'Международный выставочный центр Казань Экспо\nРеспублика Татарстан, Лаишевский район, с. Большие Кабаны, ул. Выставочная, 1',
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactOrganizerPage(),
                      ),
                    );
                  },
                  child: Text(localizations?.contactUs ?? 'Contact Us'),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.public, color: Colors.blue),
                    onPressed: () {
                      _launchUrl('https://russiachinaforum.com');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam, color: Colors.blue), // VK icon
                    onPressed: () {
                      _launchUrl('https://vk.com');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.telegram, color: Colors.blue), // Telegram icon
                    onPressed: () {
                      _launchUrl('https://t.me');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
