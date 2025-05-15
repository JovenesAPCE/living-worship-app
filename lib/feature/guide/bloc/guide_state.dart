part of 'guide_bloc.dart';

class GuideState extends Equatable{
  final List<CardGuide> cardGuides;
  final CardGuide selectCardGuide;

  const GuideState({
    this.selectCardGuide = const CardGuide(),
    this.cardGuides = const [
      CardGuide(
          title:"Datos generales del evento",
          body: "<p><p>Lema: <a href='#'>Living Worship</a></p></p><p><p>Fecha: <a href='#'>del 30 de Mayo al 01 de Junio.</a></p></p><p><p>Lugar de las programaciones: <a href='#'>Carpa Movil . UPeU - Sede Lima</a></p></p>Lugar de campamento: <a href='#'>Áreas verdes de la UPeU, Sede Lima - cercano a la carpa móvil.</a>",
      ),
      CardGuide(
        title:"¿Qué es el congreso joven APCE?",
        body: 'La Asociación Peruana Central Este organiza el Congreso Joven "Living Worship" con el propósito de fortalecer la fe, el liderazgo y la misión de los jóvenes adventistas. Este evento será un espacio de adoración, capacitación y compromiso con el evangelismo, consolidando el trabajo con la Escuela Sabática Joven (Maranata Class) y realizando el lanzamiento de Misión Caleb 2025.',
      ),
      CardGuide(
        title:"Público destinatario",
        body: "<p><p>1. jóvenes de las iglesias locales, directores de Maranata Class.</p></p><p><p>2. Distritales, regionales y coordinadores de jóvenes.</p></p>3. Ancianos y pastores distritales, relacionados al trabajo de jóvenes."),
      CardGuide(
          title:"Objetivos",
          body: "<p><b>Objetivo General:</b> Fomentar una experiencia de adoración auténtica y fortalecer el liderazgo y la misión de los jóvenes adventistas a través de capacitaciones, dinámicas y el compromiso con el evangelismo.</p><p></p><b>Objetivos Específicos:</b></p><p><p>• Inspirar a los jóvenes a vivir una adoración que trascienda y se refleje en su estilo de vida.</p></p><p><p>• Capacitar a los jóvenes en liderazgo y discipulado a través del  Maranata Class.</p></p><p>• Lanzar oficialmente Misión Caleb, impulsando la participación joven en el evangelismo y servicio a los demás.</p></p><p><p>• Fortalecer el sentido de comunidad y pertenencia entre los jóvenes adventistas.</p></p>• Promover el estudio de la Biblia y la formación de líderes de impacto misionero."),
      CardGuide(
        title:"Dinámica del evento",
        body: "<p><p>El congreso se desarrollará en diversas sesiones que incluirán:</p></p><p><p><b>• Mensajes Inspiracionales:</b> Temas sobre adoración auténtica, liderazgo joven y misión.</p></p><p><p><b>• Semiplenarias de Capacitación:</b> Espacios para desarrollar habilidades de liderazgo, evangelismo y discipulado.</p></p><p><p><b>• Misión en Acción:</b> Lanzamiento de Misión Caleb con proyectos específicos de impacto social.</p></p><p><p><b>• Espacios de Adoración y Testimonio:</b> Experiencias de jóvenes comprometidos con la misión y la adoración.</p></p><b>• Consolidación del Maranata Class:</b> Capacitación en el estudio bíblico y dinamismo de la Escuela Sabática Joven."),
      CardGuide(
        title:"¿Por qué la UPEU?",
        body: "<p><p>El congreso se llevará a cabo en la Universidad Peruana Unión (UPEU), ubicada en el kilómetro 19.5 de la Carretera Central. Esta sede ha sido elegida por varias razones clave:</p></p><p><p><b>• Amplias áreas verdes:</b> Espacios abiertos que favorecen un ambiente de comunión y actividades al aire libre.</p></p><p><p><b>• Infraestructura adecuada:</b> La UPEU cuenta con una carpa móvil que puede albergar a una gran cantidad de personas, garantizando comodidad para los asistentes.</p></p><p><p><b>• Seguridad:</b> La universidad es un espacio cerrado y controlado, lo que brinda tranquilidad a los participantes y organizadores.</p></p>• El clima a fines de mayo e inicios de junio  son favorables y sin temperaturas extremas. Poca probabilidad de llluvia.",
      ),
      CardGuide(
        title:"Prerrequisitos para participar",
        body: "<p><p>• Tener como mínimo 16 años cumplidos hasta mayo del 2025.</p></p><p><p>• Ser miembro bautizado.</p></p><p><p>• Ser director JA o estar en el liderazgo JA (líder GP,  Líder Maranata Class, Líder de Misión Caleb, etc.).</p></p>• Estar registrado y asegurado en el S-JA.",),
      CardGuide(
        title: "Inscripciones",
        body: "<p><p>Las inscripciones ya están abiertas y se cerrarán a la media noche del día 04 de mayo de 2025. Contacta a tu director o pastor  local.</p></p>"
            "<p><p>Valor de la inscripción completa: s/70.00 soles – incluye: participación del evento, chaleco, morral, pin de colección e identificación.</p></p>"
            "Se realizará via Sistema de Gestión del Ministerio Joven - S-JA. Cada participante debe contactarse con su regional.",
      ),
      CardGuide(
        title: "Clima",
        body: "<p><p>En esta epoca del año, el clima en Ñaña, Lima es templado; sin embargo, por las noches suele ser frío y con viento.</p></p>"
            "Frazada/manta y casaca son esenciales para una mejor estadía.",
      ),
      CardGuide(
        title: "Acreditación",
        body: "<p><p>1. La acreditación se realizará a partir de las 8:00 a.m del día 30/05/2025.</p></p>"
            "<p><p>2. Es obligatorio la presentación de un documento oficial con foto al momento de la acreditación.</p></p>"
            "<p><p>3. En la acreditación se entregarán los materiales y la identificación del evento. Además se le indicará el lugar de acampar.</p></p>"
            "4. Podrá ingresar al evento solo quien está inscrito y con la identificación de la pulsera oficial.",
      ),
      CardGuide(
        title: "Indicaciones acerca de la alimentación",
        body: "<p><p>Cada región podrá gestionar su alimentación siguiendo las siguientes indicaciones:</p></p>"
            "<p><p>a. La alimentación es exclusivamente locto-ovo-vegetariana, sin excepciones.</p></p>"
            "<p><p>b. Se podrá tener hasta dos cocinas por región.</p></p>"
            "<p><p>c. La ubicación de las cocinas serán en un lugar indicado previamente. No podrán instalarse en otro lugar no autorizado.</p></p>"
            "<p><p>d. Los responsables de las cocinas deberán llevar bolsas de limpieza grandes para que cada día su espacio quede limpio y los desechos en los lugares designados.</p></p>"
            "e. Los responsables de las cocinas deberán estar atentos a la programación para dar los alimentos en los horarios designados y sus participantes estén puntuales en las actividades.",
      ),
      CardGuide(
        title: "Indicaciones acerca del campamento/alojamiento",
        body: "<p><p>1. El participante tiene la opción de buscar alojamiento particular o acampar en el área designada de la UPeU - Sede Lima.</p></p>"
            "<p><p>2. Pondremos a disposición áreas debidamente designadas y señalizadas para acampar.</p></p>"
            "<p><p>3. En la acreditación, el acampante recibirá sus materiales y la indicación de dónde acampará.</p></p>"
            "<p><p>4. Será importante llevar al evento una carpa mediana o pequeña, una bola de dormir y opcionalmente una colchoneta o colchón inflable.</p></p>"
            "<p><p>5. Si desea puede traer un candado pequeño para el cierre de su carpa.</p></p>"
            "<p><p>6. Habrán baños, duchas y lavaderos para atender a los acampantes.</p></p>"
            "7. Al final del evento, el participante deberá recoger sus cosas y limpiar el área en donde acampó.",
      ),
      CardGuide(
        title: "Vestimenta",
        body: "<p><p>El viernes de noche, todos los líderes investidos deben vestir el uniforme B del Ministerio Joven.</p></p>"
            "<p><p>El sábado de mañana los líderes investidos usarán el uniforme A del MJ.</p></p>"
            "<p><p>El sábado por la tarde todos deberán vestir el polo de: Misión Caleb. (Puede ser de cualquier edición)</p></p>"
            "<p><p>El sábado de noche puede utilizar el polo MRNT.</p></p>"
            "En caso de no ser un líder investido sugerimos el uso de polos relacionados al Ministerio Joven: Oyim, JA, Misión Caleb, etc.",
      ),
      CardGuide(
        title: "Carrusel de actividades",
        body: "<p><p>1. Los participantes estarán divididos en grupos para realizar actividades en carrusel. Los grupos estarán divididos por colores, de acuerdo con la pulsera que recibirán.</p></p>"
            "<p><p>2. Los participantes podrán participar de las <a href='#'>semi plenarias</a> y feria JA en los horarios designados.</p></p>"
            "<p><b>Semi plenarias</b></p><p><a href='#'>Cada participante asistirá a dos semi plenarias que se realizarán en los lugares designados de la UPeU.</a> El ingreso a los lugares designados será hasta agotar aforo.</p></p>"
            "<p><b>Feria JA</b></p>Este espacio comprenderá visitas a los stands, feria de misiones y proyectos. Allí habrá una variedad de actividades creadas para que el participante tenga una experiencia que lo marque. La feria estará disponible desde el Viernes a las 14:00 hs hasta las 17:30 hs. El sábado aperturará a las 18:00 hs y domingo desde las 7:30 hs.",
      ),
      CardGuide(
        title: "Programación general",
        colorText: Colors.black,
        body: "<p><b>HORARIOS:</b></p>"
            "<p></p>"
            "<p><b>VIERNES - 30/05</b></p>"
            "<p><b>✦ 8:00</b> - Acreditación en el Campus UPeU.</p>"
            "<p><b>✦ 18:20</b> - Apertura de la Carpa Móvil</p>"
            "<p><b>✦ 18:45</b> - Concentración en la Carpa principal</p>"
            "<p>– Programa de Apertura</p>"
            "<p><b>✦ 19:20</b> - Presentación por regiones</p>"
            "<p><b>✦ 20:28</b> - Palabras de Apertura</p>"
            "<p><b>✦ 20:48</b> - Joven News</p>"
            "<p><b>✦ 21:00</b> - Mensaje</p>"
            "<p><b>✦ 22:10</b> - Regreso al área de campamento</p>"
            "<p><b>✦ 00:00</b> - Descanso y silencio total</p>"
            "<p></p>"
            "<p><b>SÁBADO - 31/05</b></p>"

            "<p><b>MAÑANA</b></p>"
            "<p><b>✦ 7:20</b> - Concentración en la Carpa principal</p>"
            "<p><b>✦ 8:00</b> - Maranata Class</p>"
            "<p><b>✦ 8:45</b> - Semiplenarias y Expo Joven</p>"
            "<p><b>✦ 9:56</b> - Concentración en la Carpa principal</p>"
            "<p><b>✦ 10:30</b> - Desfile Maranata Class</p>"
            "<p><b>✦ 11:20</b> - Mensaje</p>"
            "<p><b>✦ 12:10</b> - Bautismo</p>"
            "<p></p>"
            "<p><b>TARDE</b></p>"
            "<p><b>✦ 12:30</b> - Tiempo de Almuerzo</p>"
            "<p><b>✦ 14:30</b> - Concentración en la Carpa principal</p>"
            "<p><b>✦ 15:00</b> - Maranata Faith</p>"
            "<p><b>✦ 15:15</b> - Lanzamiento Living Worship</p>"
            "<p><b>✦ 15:35</b> - Semiplenarias y Expo Joven</p>"
            "<p><b>✦ 16:45</b> - Concentración en la Carpa principal</p>"
            "<p><b>✦ 17:05</b> - Concierto</p>"
            "<p><b>✦ 17:45</b> - Lanzamiento Misión Caleb 2025</p>"
            "<p><b>✦ 18:15</b> - Despedida de Sábado</p>"
            "<p><b>✦ 18:25</b> - Tiempo de Cena</p>"
            "<p></p>"
            "<p><b>NOCHE</b></p>"
            "<p><b>✦ 19:30</b> - Concentración en la Carpa principal</p>"
            "<p><b>✦ 19:40</b> - Inicia ceremonia de investidura JA</p>"
            "<p><b>✦ 20:35</b> - Joven News</p>"
            "<p><b>✦ 20:50</b> - Mensaje</p>"
            "<p><b>✦ 21:40</b> - Anuncios y despedida</p>"
            "<p><b>✦ 23:00</b> - Regreso al área de campamento</p>"
            "<p><b>✦ 00:00</b> - Descanso y silencio total</p>"
            "<p></p>"
            "<p><b>DOMINGO - 01/06</b></p>"
            "<p><b>✦ 7:20</b> - Concentración en la Carpa principal</p>"
            "<p><b>✦ 7:30</b> - Inicia programa de premiación y Clausura</p>"
            "<p><b>✦ 7:50</b> - Reconocimiento a espacios Maranata Class, Club de líderes, etc.</p>"
            "<p><b>✦ 8:20</b> - Joven News</p>"
            "<p><b>✦ 8:30</b> - Mensaje</p>"
            "<p><b>✦ 9:15</b> - Palabras de Clausura</p>"
            "<p><b>✦ 9:30</b> - Gynkana Joven (losas deportivas)</p>"
            "<p><b>✦ 11:30</b> - Premiación y Despedida</p>"
            "<b>✦ 12:00</b> - Regreso a casa",
      ),
    ]
  });

  GuideState copyWith({
    CardGuide? selectCardGuides,
    List<CardGuide>? cardGuides
  }) {
    return GuideState(
      selectCardGuide: selectCardGuides ?? this.selectCardGuide,
      cardGuides: cardGuides ?? this.cardGuides,
    );
  }

  @override
  List<Object?> get props => [cardGuides, selectCardGuide];


}
