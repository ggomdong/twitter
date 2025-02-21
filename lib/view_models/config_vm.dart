import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/models/config_model.dart';
import 'package:twitter/repos/config_repo.dart';

class ConfigViewModel extends Notifier<ConfigModel> {
  final ConfigRepository _repository;

  ConfigViewModel(this._repository);

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = ConfigModel(darkMode: value);
  }

  @override
  ConfigModel build() {
    return ConfigModel(
      darkMode: _repository.isDarkMode(),
    );
  }
}

final configProvider = NotifierProvider<ConfigViewModel, ConfigModel>(
  () => throw UnimplementedError(),
);
