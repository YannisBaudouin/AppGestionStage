part of 'mention_legale_bloc.dart';

sealed class MentionLegaleState {
  const MentionLegaleState();
}

final class MentionLegaleInitial extends MentionLegaleState {
  const MentionLegaleInitial();
}

final class MentionLegaleInitialised extends MentionLegaleState {
  const MentionLegaleInitialised();
}
