part of 'guide_bloc.dart';

class GuideEvent extends Equatable{

  const GuideEvent();
  @override
  List<Object?> get props => [];
}

final class GuideSelected extends GuideEvent {
  const GuideSelected(this.cardGuide);

  final CardGuide cardGuide;

  @override
  List<Object> get props => [cardGuide];

}