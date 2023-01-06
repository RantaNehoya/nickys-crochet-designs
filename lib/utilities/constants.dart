import 'package:flutter/material.dart';
import 'package:nickys_designs/presentation/resources/string_manager.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';

const Center kProgressIndicator = Center(
  child: CircularProgressIndicator(),
);

const Center kErrorMessage = Center(
  child: Text(
    StringManager.errorMessage,
  ),
);

const Divider kCartDivider = Divider(
  indent: SizeManager.s_10,
  endIndent: SizeManager.s_10,
  thickness: SizeManager.s_1,
);
