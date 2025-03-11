import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/cubit/all/util.dart';
import 'package:eventssytem/cubit/auth/login_cubit.dart';
import 'package:eventssytem/cubit/auth/login_state.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/screens/event_page.dart';
import 'package:eventssytem/screens/speaker_page_open.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/TextLine.dart';
import 'package:eventssytem/widgets/auth_widget.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/green_line.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:eventssytem/widgets/schedule_card.dart';
import 'package:eventssytem/widgets/search_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue.shade50,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 205, 216, 225)),
          elevation: 0,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)?.profile ?? "Profile",
              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: SvgPicture.asset("assets/icons/settings.svg"),
              onPressed: () {
                Navigator.pushNamed(context, '/settingsPage');
              },
            ),
          ],
        ),
        body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          if (state is LoginedState) {
            return BlocBuilder<ProfilePageCubit, ProfilePageState>(
                builder: (context, state) {
              if (state is ProfilePageLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfilePageLoadedState) {
                final profile = state.loadedProfilePage;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text(AppLocalizations.of(context)?.eventTitle ?? "Russia China Forum",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            const SizedBox(height: 10),
                            _buildSectionHeader(AppLocalizations.of(context)?.personalinformation ?? "Personal data"),
                            _buildProfileInfo(context, AppLocalizations.of(context)?.fullname ?? "Name", "${profile.lastNameRus ?? ''} ${profile.firstNameRus ?? ''}"),
                            _buildProfileInfo(context, AppLocalizations.of(context)?.participationpackage ?? "Participation Package",
                                ConstantsClass.locale == "en"
                                    ? profile.category?.nameEng ?? AppLocalizations.of(context)?.nopackage ?? "No Package"
                                    : profile.category?.nameRus ?? "Без пакета"),
                            const SizedBox(height: 16),
                            _buildSectionHeader(AppLocalizations.of(context)?.organization ?? "Organization"),
                            _buildProfileInfo(context, AppLocalizations.of(context)?.organization ?? "Organization",
                                profile.company?.nameRus ?? AppLocalizations.of(context)?.notavailable ?? "Not available"),
                            _buildProfileInfo(context, AppLocalizations.of(context)?.jobtitle ?? "Position",
                                profile.company?.positionRus ?? AppLocalizations.of(context)?.notavailable ?? "Not available"),
                            _buildProfileInfo(context, AppLocalizations.of(context)?.citizenship ?? "Citizenship",
                                profile.citizenshipId != null
                                    ? ConstantsClass.locale == "en"
                                        ? state.loadedCountry[profile.citizenshipId! - 1].nameEng ??
                                            AppLocalizations.of(context)?.unknowncountry ?? "Unknown Country"
                                        : state.loadedCountry[profile.citizenshipId! - 1].nameRus ?? "Неизвестная страна"
                                    : AppLocalizations.of(context)?.notavailable ?? "Not available"),
                            const SizedBox(height: 16),
                            _buildSectionHeader(AppLocalizations.of(context)?.contactinformation ?? "Contact Information"),
                            _buildContactInfo(context, Icons.phone, profile.phoneNumber),
                            _buildContactInfo(context, Icons.email, profile.email),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            TextButton(
                              onPressed: () => _launchUrl("https://sprouts.maksat.pro/manual_rus.pdf"),
                              child: Text(
                                "Инструкция на русском",
                                 style: TextStyle(color: Colors.blue, fontSize: 16),
                              ),
                            ),
                            TextButton(
                              onPressed: () => _launchUrl("https://sprouts.maksat.pro/manual_eng.pdf"),
                              child: Text(
                                "Instruction in English",
                                style: TextStyle(color: Colors.blue, fontSize: 16),
                              ),
                            ),
                            TextButton(
                              onPressed: () => _launchUrl("https://sprouts.maksat.pro/manual_chi.pdf"),
                              child: Text(
                                "中文说明",
                                style: TextStyle(color: Colors.blue, fontSize: 16),
                             ),
                           ),
                          ],
                       ),
                      ),


                    ],
                  ),
                );

              }
              return Center(child: Text(AppLocalizations.of(context)?.errorloadingprofile ?? "Error loading profile"));
            });
          } else {
            return Center(child: Text(AppLocalizations.of(context)?.notloggedin ?? "Not logged in"));
          }
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: const Color.fromARGB(255, 201, 227, 239),
      child: Center(
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, String label, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        Text(value ?? AppLocalizations.of(context)?.notavailable ?? "Not available", style: const TextStyle(color: Colors.black)),
      ],
    ),
  );
}

Widget _buildContactInfo(BuildContext context, IconData icon, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 10),
        Text(value ?? AppLocalizations.of(context)?.notavailable ?? "Not available", style: const TextStyle(color: Colors.black)),
      ],
    ),
  );
}
}
