part of 'mention_legale_bloc.dart';

sealed class MentionLegaleEvent {
  const MentionLegaleEvent();
}

class getTextFile extends MentionLegaleEvent {
  final String path;
  const getTextFile({required this.path});
}
