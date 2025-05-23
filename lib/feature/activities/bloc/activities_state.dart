part of 'activities_bloc.dart';

final class ActivitiesState extends Equatable{

  final List<CardActivity> cardActivities;
  final CardActivity selectCardActivities;

  const ActivitiesState({
    this.selectCardActivities = const CardActivity(),
    this.cardActivities = const [
      CardActivity(
        title: "Información general",
        details: [
          CardDetailActivity(
            body: "Conoce al presidente de la APCE y su labor en la misión.",
            image: AppImages.activityImage3,
          ),
          CardDetailActivity(
            body: "Descubre quién es el departamental de jóvenes de la APCE y su rol en el liderazgo juvenil.",
            image: AppImages.activityImage2,
          ),
          CardDetailActivity(
            body: "Conoce a la coordinadora general y su responsabilidad en la organización del evento.",
            image: AppImages.activityImage4,
          ),
        ],
      ),
      CardActivity(
        title: "Mensajes Inspiracionales",
          details: [
            CardDetailActivity(
                body: "Temas sobre adoración auténtica, liderazgo joven y misión.",
                image: AppImages.activityImage1
            )
          ]

      ),
      CardActivity(
        title: "Semiplenarias",
          details: [
            CardDetailActivity(
                body: "Espacios de capacitación diseñados para desarrollar habilidades en liderazgo, evangelismo y discipulado. Cada participante podrá <a href='semi-plenary'>asistir a dos semiplenarias</a> durante el periodo asignado a esta actividad. <a href='semi-plenary'>Haz clic aquí para elegir tus dos semiplenarias de capacitación.</a>"
            )
          ]

      ),
      CardActivity(
        title: "Misión en Acción",
          details: [
            CardDetailActivity(
                body: "Lanzamiento de Misión Caleb con proyectos específicos de impacto social."
            )
          ]

      ),
      CardActivity(
        title: "Adoración y Testimonio",
          details: [
            CardDetailActivity(
                body: "Experiencias de jóvenes comprometidos con la misión y la adoración. <a href='guests'>Haz clic aquí para ver la información de los invitados.</a>"
            )
          ]

      ),
      CardActivity(
        title: "Maranata Class",
          details: [
            CardDetailActivity(
                body: "Capacitación en el estudio bíblico y dinamismo de la Escuela Sabática Joven."
            )
          ]

      ),
    ]
  });

  ActivitiesState copyWith({
    CardActivity? selectCardActivities,
    List<CardActivity>? cardActivities
  }) {
    return ActivitiesState(
      selectCardActivities: selectCardActivities ?? this.selectCardActivities,
      cardActivities: cardActivities ?? this.cardActivities,
    );
  }

  @override
  List<Object?> get props => [cardActivities, selectCardActivities];

}
