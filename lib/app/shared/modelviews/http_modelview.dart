import 'package:flutter/cupertino.dart';
import 'package:lablinker/app/models/http_form_model.dart';

class HttpModelView extends ValueNotifier<HttpFormModel> {
  HttpModelView(String? description)
    : super(HttpFormModel(description: description));
}
