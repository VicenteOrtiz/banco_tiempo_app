part of 'poc_bloc.dart';

@immutable
abstract class PocEvent {}

class PocRefresh extends PocEvent {}

class PocFetched extends PocEvent {}
