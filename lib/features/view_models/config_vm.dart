import 'package:flutter/material.dart';
import 'package:twitter/features/models/config_model.dart';
import 'package:twitter/features/repos/config_repo.dart';

class ConfigViewModel extends ChangeNotifier {
  final ConfigRepository _repository;

  late final ConfigModel _model = ConfigModel(
    darkmode: _repository.isDarkmode(),
  );

  ConfigViewModel(this._repository);

  bool get darkmode => _model.darkmode;

  void setDarkmode(bool value) {
    _repository.setDarkmode(value);
    _model.darkmode = value;
    notifyListeners();
  }
}
