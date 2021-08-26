abstract class TradeHomeState{}
class TradeHomeInitial extends TradeHomeState{}
class TradeHomeChangeIndex extends TradeHomeState{}
class TradeHomeSuccess extends TradeHomeState{}
class TradeHomeError extends TradeHomeState{
  final error;
  TradeHomeError(this.error);
}
