abstract class StoreSettingsState {}

class StoreSettingsInitState extends StoreSettingsState {}

class StoreSettingsLoadedState extends StoreSettingsState {}

class StoreSettingsLoadErrorState extends StoreSettingsState {
  final String errorMessage;

  StoreSettingsLoadErrorState({required this.errorMessage});
}

class StoreSettingsChangedState extends StoreSettingsState {}

class StoreSettingsLoadingState extends StoreSettingsState {}

class StoreSettingsErrorState extends StoreSettingsState {
  final String errorMessage;

  StoreSettingsErrorState({required this.errorMessage});
}

class StoreSettingsSuccessState extends StoreSettingsState {
  final String successMessage;

  StoreSettingsSuccessState({required this.successMessage});
}
