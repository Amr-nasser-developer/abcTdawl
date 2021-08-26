abstract class TradeStates{}
class TradeInitial extends TradeStates{}

//login screen
class TradeLoginLoading extends TradeStates{}
class TradeLoginSuccess extends TradeStates{}
class TradeLoginError extends TradeStates{
  final error;
  TradeLoginError(this.error);
}
//loginFirebase screen
class TradeLoginFirebaseLoading extends TradeStates{}
class TradeLoginFirebaseSuccess extends TradeStates{}
class TradeLoginFirebaseError extends TradeStates{
  final error;
  TradeLoginFirebaseError(this.error);
}
//getNotification screen
class TradePostNotificationLoading extends TradeStates{}
class TradePostNotificationSuccess extends TradeStates{}
class TradePostNotificationError extends TradeStates{
  final error;
  TradePostNotificationError(this.error);
}
//getNotification screen
class TradeGetNotificationLoading extends TradeStates{}
class TradeGetNotificationSuccess extends TradeStates{}
class TradeGetNotificationError extends TradeStates{
  final error;
  TradeGetNotificationError(this.error);
}
//saveDeviceToken screen
class TradeSaveDeviceTokenLoading extends TradeStates{}
class TradeSaveDeviceTokenSuccess extends TradeStates{}
class TradeSaveDeviceTokenError extends TradeStates{
  final error;
  TradeSaveDeviceTokenError(this.error);
}
//register screen
class TradeRegisterLoading extends TradeStates{}
class TradeRegisterSuccess extends TradeStates{}
class TradeRegisterError extends TradeStates{
  final error;
  TradeRegisterError(this.error);
}
//registerFirebase screen
class TradeRegisterFirebaseLoading extends TradeStates{}
class TradeRegisterFirebaseSuccess extends TradeStates{}
class TradeRegisterFirebaseError extends TradeStates{
  final error;
  TradeRegisterFirebaseError(this.error);
}
//freeRegister screen
class TradeFreeRegisterLoading extends TradeStates{}
class TradeFreeRegisterSuccess extends TradeStates{}
class TradeFreeRegisterError extends TradeStates{
  final error;
  TradeFreeRegisterError(this.error);
}
//getFirebase screen
class TradeGetFirebaseLoading extends TradeStates{}
class TradeGetFirebaseSuccess extends TradeStates{}
class TradeGetFirebaseError extends TradeStates{
  final error;
  TradeGetFirebaseError(this.error);
}
//package screen
class TradePackageLoading extends TradeStates{}
class TradePackageSuccess extends TradeStates{}
class TradePackageError extends TradeStates{
  final error;
  TradePackageError(this.error);
}
//service screen
class TradeServiceLoading extends TradeStates{}
class TradeServiceSuccess extends TradeStates{}
class TradeServiceError extends TradeStates{
  final error;
  TradeServiceError(this.error);
}
//news screen
class TradeNewsLoading extends TradeStates{}
class TradeNewsSuccess extends TradeStates{}
class TradeNewsError extends TradeStates{
  final error;
  TradeNewsError(this.error);
}
class TradeNewsMoreLoading extends TradeStates{}
class TradeNewsMoreSuccess extends TradeStates{}
class TradeNewsMoreError extends TradeStates{
  final error;
  TradeNewsMoreError(this.error);
}
//news details screen
class TradeNewsDetailsLoading extends TradeStates{}
class TradeNewsDetailsSuccess extends TradeStates{}
class TradeNewsDetailsError extends TradeStates{
  final error;
  TradeNewsDetailsError(this.error);
}
//recommand screen
class TradeRecommandLoading extends TradeStates{}
class TradeRecommandSuccess extends TradeStates{}
class TradeRecommandError extends TradeStates{
  final error;
  TradeRecommandError(this.error);
}
//recommandMore screen
class TradeRecommandMoreLoading extends TradeStates{}
class TradeRecommandMoreSuccess extends TradeStates{}
class TradeRecommandMoreError extends TradeStates{
  final error;
  TradeRecommandMoreError(this.error);
}
//recommandType screen
class TradeRecommandTypeLoading extends TradeStates{}
class TradeRecommandTypeSuccess extends TradeStates{}
class TradeRecommandTypeError extends TradeStates{
  final error;
  TradeRecommandTypeError(this.error);
}
//contactUs screen
class TradeContactUSLoading extends TradeStates{}
class TradeContactUSSuccess extends TradeStates{}
class TradeContactUSError extends TradeStates{
  final error;
  TradeContactUSError(this.error);
}
//contactInfo screen
class TradeContactInfoLoading extends TradeStates{}
class TradeContactInfoSuccess extends TradeStates{}
class TradeContactInfoError extends TradeStates{
  final error;
  TradeContactInfoError(this.error);
}
//performanceYear screen
class TradePerformanceYearLoading extends TradeStates{}
class TradePerformanceYearSuccess extends TradeStates{}
class TradePerformanceYearError extends TradeStates{
  final error;
  TradePerformanceYearError(this.error);
}
//performanceMonth screen
class TradePerformanceMonthLoading extends TradeStates{}
class TradePerformanceMonthSuccess extends TradeStates{}
class TradePerformanceMonthError extends TradeStates{
  final error;
  TradePerformanceMonthError(this.error);
}
//performanceShort screen
class TradePerformanceShortLoading extends TradeStates{}
class TradePerformanceShortSuccess extends TradeStates{}
class TradePerformanceShortError extends TradeStates{
  final error;
  TradePerformanceShortError(this.error);
}
//performanceShortMore screen
class TradePerformanceShortMoreLoading extends TradeStates{}
class TradePerformanceShortMoreSuccess extends TradeStates{}
class TradePerformanceShortMoreError extends TradeStates{
  final error;
  TradePerformanceShortMoreError(this.error);
}