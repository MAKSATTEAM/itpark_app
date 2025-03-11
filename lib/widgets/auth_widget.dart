import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/cubit/all/cubit.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "${AppLocalizations.of(context)?.togetaccess}",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  context.read<SlidingAutgCubit>().open();
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "${AppLocalizations.of(context)?.login}",
                    style: TextStyle(fontSize: 16),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
