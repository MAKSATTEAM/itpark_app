import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventssytem/cubit/all/cubit.dart';

class Personalschedule {
  static List<dynamic>? psList = [];

  static check(int id, BuildContext context) {
    if (psList == null) {
      PersonalscheduleCubit filterCubit = context.read<PersonalscheduleCubit>();
      filterCubit.fetchEvent();
    }
    if (psList != null) {
      for (var item in psList!) {
        if (item.id == id) {
          return true;
        }
      }
      return false;
    }
  }
}
