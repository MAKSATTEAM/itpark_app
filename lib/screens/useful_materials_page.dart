import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class UsefulMaterialsPage extends StatelessWidget {
  const UsefulMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            title: Text("${AppLocalizations.of(context)?.usefulmaterials}",
                style: kAppBarTextStyle),
            actions: [NotificationIcon()],
          ),
          body: BlocBuilder<MaterialsCubit, MaterialsState>(
              builder: (context, state) {
            if (state is MaterialsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MaterialsError) {
              return Center(
                  child: Text("${AppLocalizations.of(context)?.error}"));
            }
            if (state is MaterialsLoaded) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.loaded!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                UrlLauncher.launch(
                                    "${ConstantsClass.url}${state.loaded![index].filePath}");
                              },
                              child: Row(children: [
                                Expanded(
                                  child: Text(state.loaded![index].name,
                                      style: kUseFul),
                                ),
                                SizedBox(width: 16),
                                SvgPicture.asset("assets/icons/download.svg"),
                              ]),
                            ),
                          ],
                        );
                      })
                ]),
              ));
            }
            return Center(
                child: Text("${AppLocalizations.of(context)?.error}"));
          })),
    );
  }
}
