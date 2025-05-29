part of 'guests_bloc.dart';

class GuestsState extends Equatable {

  final List<GuestTab> tabs;
  final int selectedIndex;

  const GuestsState({
    this.tabs = const [
      GuestTab(
        title: 'Semiplenarias',
        guests: [
          GuestCard(
              name: "Pr. Alan Cosavalente",
              schedule: "",
              image: AppImages.guests11,
              issue: 'Generación Misionera',
              review: '''<p>El pastor Alan Cosavalente nació en Trujillo, Perú. Estudió en la Universidad Peruana Unión, donde se graduó como Licenciado en Teología y Salud Pública.</p>
<p>En el 2019 concluyó el curso de extensión en Liderazgo con Énfasis en Nuevas Generaciones - Sao Paulo (UNASP-EC).</p>
<p>Inició su ministerio pastoral en Cayma, Arequipa, Perú. Luego en Tacna, donde trabajó también como pastor distrital.</p>
<p>En el mismo campo fue llamado como Director del Ministerio Joven de la Misión Peruana del Sur. Posteriormente, fue Director del Ministerio Joven, Música y Universitario de la Unión Peruana del Norte.</p>
<p>Luego trabajó como Director del Ministerio de Conquistadores y Aventureros, Ministerio Joven, Música y Universitarios de la Asociación Peruana Central Este.</p>
<p>Está casado con Katherine Velásquez y tiene dos hijas: Alana y Elaine.</p>
<p>En la actualidad, el pastor Cosavalente se desempeña como Director del Ministerio de Conquistadores y Aventureros, Ministerio Joven, Música y Universitarios de la Unión Peruana del Norte.</p>'''
          ),
          //GuestCard(name: "Pr. Anthony Centeno", schedule: "", image: AppImages.guests4),
          //GuestCard(name: "Pr. Francesco Marquina", schedule: "", image: AppImages.guests12),
          GuestCard(
              name: "Pr. Edison Choque",
              schedule: "",
              image: AppImages.guests10,
              issue: 'La misión para el tiempo del fin',
              review: '''<p>El pastor Edison Choque Fernández es natural de Arequipa. Realizó sus estudios secundarios en el colegio Unión de Ñaña, sus estudios en Teología en el antiguo CESU, y su maestría en Misiología en la UPeU.</p>
<p>Está casado con la profesora Ruth León Espejo con quien tiene dos hijos, Kevin y Mercy, y dos nietos.</p>
<p>Se desempeñó como líder de Jóvenes y Ministerial en la MAC, MPN y ANOP. Fue líder del área de MIPES en la Asociación Bahía Sur en Brasil.</p>
<p>Fue Director del Ministerio Joven en la Unión Peruana, antes de la división del territorio, y posteriormente como líder de la misma área en la naciente Unión Peruana del Norte.</p>
<p>Fue llamado para ser líder de las áreas de Misión Global, Ministerio de Familia y Escuela Sabática de la División Sudamericana, donde trabajó por 14 años.</p>
<p>Actualmente es el secretario Ministerial de la Unión Peruana del Norte.</p>'''
          ),
          GuestCard(
              name: "Dra. Dámaris Quinteros",
              schedule: "",
              image: AppImages.guests3,
              issue: "Amores extraños",
              review: '''<p>Psicóloga. Actualmente Directora general de la Escuela de Posgrado de la UPeU, desde el 2023. Nació en San Martín, Perú.</p>
<p>Se graduó en psicología en la Universidad Adventista del Plata (UAP) en Argentina en 2001. Es Magíster en Educación con mención en Psicología Educativa por la UPeU en 2006 y Doctora en Psicología por la Universidad Femenina del Sagrado Corazón (UNIFE) en 2013.</p>
<p>Es docente investigadora de pregrado y posgrado en la UPeU. Ha publicado varios artículos en revistas científicas y en diversas plataformas de la IASD.</p>
<p>Tiene 22 años de matrimonio con Christian Vallejos, y es mamá de dos jóvenes: Franco (21) y Lety (18).</p>'''
          ),
          GuestCard(
              name: "Mg. Mayumi Arellano",
              schedule: "",
              image: AppImages.guests13,
              issue: 'Un Amor de Otro Nivel: Cuando el Cerebro Ama con Libertad',
              review: '''<p>La psicóloga Mayumi Arellano Lino es una joven profesional con sólida formación académica y creciente trayectoria en el campo clínico y docente. Actualmente se desempeña como docente en la Universidad Peruana Unión, donde dicta cursos relacionados con la neuropsicología y la psicología clínica-comunitaria.</p>
<p>Tiene una especialidad en Neuropsicología Infantil por la Universidad Católica de Trujillo y es Magíster en Ciencias de la Familia con mención en Terapia Familiar por la Universidad Peruana Unión. Además, continúa su formación en psicoterapéutica en el Sapareachi Emotional Lifestyle Center en México.</p>
<p>Cuenta con más de cinco años de experiencia clínica y hospitalaria, atendiendo principalmente a niños con trastornos del neurodesarrollo en instituciones públicas y privadas. Ha desarrollado investigaciones sobre neurodivergencia y el desarrollo humano desde una perspectiva integradora entre fe y ciencia.</p>'''
          ),
          GuestCard(
              name: "Mg. Carolyn Azo & Christian Ødegård",
              schedule: "",
              image: AppImages.guests18,
              issue: 'La inteligencia emocional: el corazón del voluntariado efectivo',
              review: '''<p><b>Carolyn Azo</b>, peruana, licenciada en Comunicación Social, con un máster en inteligencia emocional y educación sexual. Es esposa y madre de una niña. Actualmente se encuentra haciendo un posgrado en Sexualidad.</p>
<p><b>Christian Ødegård</b>, de nacionalidad noruega, esposo de Carolyn, es profesor de educación primaria y actualmente estudia la carrera de teología en la UPEU.</p>'''
          ),
          GuestCard(
              name: "Pr. Raúl Sotelo",
              schedule: "",
              image: AppImages.guests2,
              issue: 'CREACIONISMO PURO (mañana), LA FE DE LOS ASTRONAUTAS (tarde)',
              review: '''<p>Profesor Raúl Sotelo, Docente de la Escuela de Medicina, Profesor principal de Ciencia y Biblia y Director del Programa Sábados Astronómicos. Está casado y tiene tres hijos.</p>'''
          ),
          GuestCard(
              name: "Pr. Rolando Quinteros",
              schedule: "",
              image: AppImages.guests1,
              issue: 'Líderes que dejan huellas y no heridas',
              review: '''<p>Pastor Rolando F. Quinteros, Zuñiga, nacido en Pucallpa y con formación en Teología y salud pública. Tiene una maestría y estudios doctorales en la Universidad Peruana Unión, Loma Linda y Andrews University.</p>
<p>En su labor como Pastor ha trabajado como Capellán, Profesor en escuela y universidad y fue pastor en varias ciudades del Perú como Lima, Trujillo, Juliaca, Puno y Puerto Maldonado.</p>
<p>Fue Director del Ministerio Joven en la Asociación Peruana Central este, director de bienestar universitario en la UPeU Campus Juliaca y actualmente es el secretario ejecutivo en la Asociación Peruana Central - UPS.</p>
<p>Está casado con la psicóloga Sandra Revelo y tiene dos hijos: Matías de 14 años y Adrián de 11 años. Entre sus pasatiempos favoritos están el deporte, hacer música, cocinar, viajar y disfrutar con amigos de actividades al aire libre.</p>'''
          ),


          GuestCard(
              name: "Lic. Jaime Vilcapoma",
              schedule: "",
              image: AppImages.guests6, // Reemplaza con asset correcto
              issue: "Creación de Contenido para Redes Sociales: IA + IR",
              review: '''<p>Es graduado en Ciencias de la Comunicación y cuenta con una trayectoria profesional en el ámbito institucional y mediático. Con más de 16 años de experiencia trabajando para la Iglesia Adventista del Séptimo Día, ha liderado estrategias de comunicación, producción de contenidos y posicionamiento digital.</p>
<p>Desde hace 14 años forma parte de la Unión Peruana del Norte, donde actualmente se desempeña como Gerente General de Comunicación, liderando proyectos innovadores orientados a la misión a través de los medios y plataformas digitales.</p>
<p>En el ámbito eclesiástico, está investido como líder J.A. y actualmente sirve como Director del Ministerio Joven de la Iglesia Adventista de Villa Unión, en Ñaña - Lima.</p>
<p>Desde este espacio, lidera iniciativas de discipulado, capacitación y movilización juvenil, bajo el enfoque del Plan Maranata (MRNT), fortaleciendo la identidad adventista y motivando a cientos de jóvenes a vivir la misión con pasión, convicción y propósito.</p>'''
          ),
          GuestCard(name: "Pedro Valença", schedule: "", image: AppImages.guests15, issue: 'Autoconocimiento vocal y rutinas para mejorar el rendimiento (solo varones)'),
          GuestCard(
              name: "Joyce Carnassale",
              schedule: "",
              image: AppImages.guests17,
              issue: 'Autoconocimiento vocal y rutinas para mejorar el rendimiento (solo mujeres)',
              review: '''<p>Joyce Carnassale es natural de São Paulo, Brasil. Se graduó en Educación Artística en el Centro Universitario Adventista de São Paulo (Unasp).</p>
<p>Durante su tiempo en el campus, trabajó como directora asistente del coro infantil (conformado por aproximadamente 400 niños), y al año siguiente asumió la dirección general del mismo.</p>
<p>Paralelamente, dirigía el coro del nivel de secundaria como parte del currículo escolar, y también lideraba el coro Canção Jovem, el coro oficial del campus, integrado por niños y adolescentes.</p>
<p>Como cantante, formó parte de los grupos Tom de Vida y Novo Tom. Participó en múltiples grabaciones y colaboraciones especiales, incluyendo el DVD 180 Grados junto a Arautos do Rei.</p>
<p>Tiene 3 producciones como solista, lanzó sencillos recientes y es la creadora del curso Descomplicando o Canto. Actualmente enseña técnica vocal a distancia a niños y adultos.</p>'''
          ),
          GuestCard(name: "Mg. Victoria Sánchez", schedule: "MAS (Ministerio Adventista de Sordos)", image: AppImages.guests19, issue: 'Señas que gritan “Amor” - Ministerio Adventista de Sordos',
              review: '''<p>Licenciada en Comunicaciones por la UPeU, Magíster en Gestión de Proyectos y Voluntariados por la UNaSP, y especialista en Marketing Digital por la Universidad de Lima.</p>
<p>Intérprete en lengua de señas. Actualmente, consejera del Ministerio Adventista de Sordos de la Unión Peruana del Norte, dedica su tiempo y conocimientos para promover la inclusión y el servicio.</p>
<p>Paralelamente, trabaja como estratega de redes sociales para una firma de abogados en Europa.</p>
<p>Combina su pasión por la comunicación y la gestión digital con un compromiso profundo por la comunidad sorda y el voluntariado.</p>'''
          ),
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