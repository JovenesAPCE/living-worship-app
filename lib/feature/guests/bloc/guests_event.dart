part of 'guests_bloc.dart';

sealed class GuestsEvent extends Equatable{
  const GuestsEvent();
  @override
  List<Object?> get props => [];
}

final class TabSelected extends GuestsEvent {
  const TabSelected(this.selectedIndex);

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];

}