part of 'guests_bloc.dart';

class GuestsState extends Equatable {

  final List<GuestTab> tabs;
  final int selectedIndex;

  const GuestsState({
    this.tabs = const [
      GuestTab(
        title: 'Semiplenarias',
        guests: [
          GuestCard(name: "Pr. Alan Cosavalente", schedule: "", image: AppImages.guests11),
          GuestCard(name: "Pr. Anthony Centeno", schedule: "", image: AppImages.guests4),
          GuestCard(name: "Pr. Francesco Marquina", schedule: "", image: AppImages.guests12),
          GuestCard(name: "Pr. Edison Choque", schedule: "", image: AppImages.guests10),
          GuestCard(name: "Psic. Damaris Quinteros", schedule: "", image: AppImages.guests3),
          GuestCard(name: "Psic. Mayumi Arellano", schedule: "", image: AppImages.guests13),

          GuestCard(name: "Lc. Carolyn Azo", schedule: "", image: AppImages.guests5),
          GuestCard(name: "Pr. Raúl Sotelo", schedule: "", image: AppImages.guests2),
          GuestCard(name: "Pr. Rolando Quinteros", schedule: "", image: AppImages.guests1),

          GuestCard(name: "Lic. Jaime Vilcapoma", schedule: "", image: AppImages.guests6),
        ]
      ),
      GuestTab(
        title: 'Predicador',
        guests: [
          GuestCard(name: "Pr. Brian Chalá", schedule: "Desde Nuevo Tiempo Brasil", image: AppImages.guests7),
        ]
      ),
      GuestTab(
        title: 'Alabanza',
        guests: [
          GuestCard(name: "CORDÃO DE TRÊS", schedule: "Desde Brasil", image:AppImages.guests8),
          GuestCard(name: "Dennys Bravo", schedule: "Desde Brasil", image: AppImages.guests14),
          GuestCard(name: "Jefferson Cesar", schedule: "Desde Brasil", image: AppImages.guests9),
        ]
      )],
    this.selectedIndex = 0,
  });

  GuestsState copyWith({
    List<GuestTab>? tabs,
    int? selectedIndex
  }){
    return GuestsState(
        selectedIndex: selectedIndex??this.selectedIndex,
        tabs: tabs??this.tabs
    );
  }

  @override
  List<Object?> get props => [tabs, selectedIndex];

}