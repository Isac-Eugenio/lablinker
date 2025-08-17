import 'package:flutter/cupertino.dart';
import '../../models/bluetooth_form_model.dart';

class BluetoothModelView extends ValueNotifier<BluetoothFormModel> {
  BluetoothModelView(String? description)
    : super(BluetoothFormModel(description: description));

}
