abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNaveState extends NewsStates {}
// ال  states  الخاصه ب اسكرينة الل business

class GetBusinessLoadingState extends NewsStates {}

class GetBusinessSuccessState extends NewsStates {}

class GetBusinessErrorState extends NewsStates {
  final String error;

  GetBusinessErrorState(this.error);
}
// ال  states  الخاصه ب اسكرينة الل sports

class GetSportsLoadingState extends NewsStates {}

class GetSportsSuccessState extends NewsStates {}

class GetSportsErrorState extends NewsStates {
  final String error;

  GetSportsErrorState(this.error);
}
// ال  states  الخاصه ب اسكرينة الل science

class GetScienceLoadingState extends NewsStates {}

class GetScienceSuccessState extends NewsStates {}

class GetScienceErrorState extends NewsStates {
  final String error;

  GetScienceErrorState(this.error);
}
// ال  states  الخاصه ب اسكرينة الل Search

class GetSearchLoadingState extends NewsStates {}

class GetSearchSuccessState extends NewsStates {}

class GetSearchErrorState extends NewsStates {
  final String error;

  GetSearchErrorState(this.error);
}
// ال  states  الخاصه ب اسكرينة الل بتغيير ال Mode

class NewsChangeModeState extends NewsStates {}

