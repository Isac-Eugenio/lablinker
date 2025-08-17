import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/theme/theme_widgets.dart';
import 'package:lablinker/app/shared/widgets/custom_app_bar_widget.dart';

import '../../models/add_view_form_model.dart';

class FormNewNetworkView extends StatelessWidget {

  final ValueNotifier<AddViewFormModel?> formModelNotifier;

  const FormNewNetworkView({super.key, required this.formModelNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsPrimarySystem.backgroundPrimaryColor.color,
      appBar: CustomAppBarWidget(title: "Nova Conexão ${formModelNotifier.value!.protocol?.label}", route: RoutesName.menuGamepad),

    );
  }
}
