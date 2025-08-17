import 'package:flutter/material.dart';

import '../modelviews/page_navigator_viewmodel.dart';
import '../routes/routes.dart';

class RollbackButtonWidget extends StatelessWidget {
  final RoutesName? route;

  const RollbackButtonWidget({super.key, required this.route});

  @override
  Widget build(BuildContext context) => route != null
      ? IconButton(
          onPressed: () => pageNavigatorViewModel.goRollBack(route!, context),
          icon: Icon(Icons.arrow_back),
        )
      : Container();
}
