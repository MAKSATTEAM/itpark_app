import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/green_line.dart';
import 'package:eventssytem/widgets/notification_icon.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PartnersCubit>().feth();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBacColor,
        iconTheme: IconThemeData(color: kIconColor),
        elevation: 0,
        centerTitle: true,
        title: Text("${AppLocalizations.of(context)?.partners}",
            style: kAppBarTextStyle),
        actions: [NotificationIcon()],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Background().background),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<PartnersCubit, PartnersState>(
                builder: (context, state) {
              print(state);
              if (state is PartnersLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is PartnersErrorState) {
                return Center(
                    child: Text("${AppLocalizations.of(context)?.error}"));
              }
              if (state is PartnersLoadedState) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.loaded.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(height: 8),
                          GreenLine(text: "${state.loaded[index].name}"),
                          SizedBox(height: 16),
                          wrapik(List.generate(
                              state.loaded[index].partners.length,
                              (int index2) => containerchik(
                                  context,
                                  state.loaded[index].partners[index2]
                                      .imageHover))),
                          SizedBox(height: 8),
                        ],
                      );
                    });
              }
              return Center(
                  child: Text("${AppLocalizations.of(context)?.error}"));
            })),
      ),
    );
  }
}

Widget containerchik(BuildContext context, String photo) {
  return SizedBox(
    height: MediaQuery.of(context).size.width / 3.5,
    width: MediaQuery.of(context).size.width / 3.5,
    child: CachedNetworkImage(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      imageUrl: photo,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => SvgPicture.asset(
        "assets/icons/noimg.svg",
        fit: BoxFit.contain,
        alignment: Alignment.center,
        color: kPrimaryColor,
      ),
    ),
  );
}

Widget wrapik(List<Widget> rr) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      children: rr,
    ),
  );
}
