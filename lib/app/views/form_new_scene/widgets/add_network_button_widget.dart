import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lablinker/app/models/add_view_form_model.dart';
import 'package:lablinker/app/shared/modelviews/page_navigator_viewmodel.dart';
import 'package:lablinker/app/shared/routes/routes.dart';

class AddNetworkButtonWidget extends StatelessWidget {

  final ValueNotifier<AddViewFormModel?> formModelNotifier;

  const AddNetworkButtonWidget({super.key, required this.formModelNotifier});

  @override
  Widget build(BuildContext context) =>
   SizedBox(
      height: 48,
      width: 48,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            log(formModelNotifier.value!.networks.toString(), name: "log do botão");
            pageNavigatorViewModel.go(RoutesName.formNetworkView, context);
            },
        ),
      ),
    );
}
