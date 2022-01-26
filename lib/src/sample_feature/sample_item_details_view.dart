import 'package:flutter/material.dart';
import 'package:localization_riverpod_flutter/src/localization/app_localizations_context.dart';

class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({Key? key}) : super(key: key);

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.itemDetails),
      ),
      body: Center(
        child: Text(context.loc.moreInformationHere),
      ),
    );
  }
}
