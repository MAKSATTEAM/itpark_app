import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/news_card.dart';
import 'package:eventssytem/widgets/notification_icon.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NewsCubit>().fetchNews();
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
          title: Text("${AppLocalizations.of(context)?.news}",
              style: kAppBarTextStyle),
          actions: [NotificationIcon()],
        ),
        body: SafeArea(
            child: BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
          print(state);
          if (state is NewsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is NewsError) {
            return Center(
                child: Text("${AppLocalizations.of(context)?.error}"));
          }
          if (state is NewsLoaded) {
            return ListView.builder(
                itemCount: state.newsloaded?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 6),
                    child: NewsCard(
                        date: state.newsloaded![index]?.date,
                        text: state.newsloaded![index]?.title,
                        url: state.newsloaded![index]?.link),
                  );
                });
          }
          return Center(child: Text("${AppLocalizations.of(context)?.error}"));
        })),
      ),
    );
  }
}
