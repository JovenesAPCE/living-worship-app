import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Privacidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Política de Privacidad', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Última actualización: 15 de mayo de 2025'),
              SizedBox(height: 16),
              Text('Esta Política de Privacidad describe nuestras políticas y procedimientos sobre la recopilación, uso y divulgación de su información cuando utiliza el Servicio y le informa sobre sus derechos de privacidad y cómo la ley lo protege.'),
              SizedBox(height: 8),
              Text('Usamos sus datos personales para proporcionar y mejorar el Servicio. Al usar el Servicio, usted acepta la recopilación y el uso de la información de acuerdo con esta Política de Privacidad. Esta Política de Privacidad ha sido creada con la ayuda del generador de políticas de privacidad.'),
              SizedBox(height: 24),
              Text('Interpretación y Definiciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Las palabras cuya letra inicial está en mayúscula tienen significados definidos bajo las siguientes condiciones. Las siguientes definiciones tendrán el mismo significado independientemente de que aparezcan en singular o en plural.'),
              SizedBox(height: 16),
              Text('Definiciones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              BulletList(items: [
                'Cuenta: significa una cuenta única creada para que usted acceda a nuestro Servicio o partes del mismo.',
                'Afiliado: significa una entidad que controla, es controlada por o está bajo control común con una parte.',
                'Aplicación: se refiere a Living Worship, el programa de software proporcionado por la Compañía.',
                'Compañía: se refiere a Living Worship.',
                'País: se refiere a Perú.',
                'Dispositivo: significa cualquier dispositivo que pueda acceder al Servicio como una computadora, un teléfono móvil o una tableta digital.',
                'Datos Personales: cualquier información relacionada con una persona identificada o identificable.',
                'Servicio: se refiere a la Aplicación.',
                'Proveedor de Servicios: cualquier persona física o jurídica que procese los datos en nombre de la Compañía.',
                'Datos de Uso: datos recopilados automáticamente.',
                'Usted: el individuo que accede o utiliza el Servicio.'
              ]),
              SizedBox(height: 24),
              Text('Recopilación y uso de sus datos personales', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Tipos de datos recopilados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Datos personales: mientras utiliza nuestro Servicio, podemos pedirle que nos proporcione cierta información de identificación personal que puede usarse para contactarlo o identificarlo. Esta información puede incluir su dirección de correo electrónico, nombre y apellido, número de teléfono y datos de uso.'),
              SizedBox(height: 8),
              Text('Datos de uso: recopilados automáticamente cuando se utiliza el Servicio. Esto incluye dirección IP, tipo de navegador, páginas visitadas, fecha y hora, tiempo de permanencia, identificadores únicos y otros datos de diagnóstico. También puede incluir información sobre su dispositivo móvil y sistema operativo.'),
              SizedBox(height: 24),
              Text('Uso de sus datos personales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              BulletList(items: [
                'Para proporcionar y mantener nuestro Servicio.',
                'Para gestionar su cuenta.',
                'Para el cumplimiento de un contrato.',
                'Para contactarlo a través de correo electrónico, llamadas telefónicas, SMS, notificaciones push, etc.',
                'Para proporcionarle noticias, ofertas especiales e información relevante, salvo que se haya excluido.',
                'Para gestionar sus solicitudes.',
                'Para transferencias comerciales (fusiones, ventas, etc.).',
                'Para otros propósitos como análisis de datos, marketing y mejora de servicios.'
              ]),
              SizedBox(height: 16),
              Text('Podemos compartir su información personal en los siguientes casos:', style: TextStyle(fontWeight: FontWeight.bold)),
              BulletList(items: [
                'Con proveedores de servicios.',
                'En transferencias comerciales.',
                'Con afiliados.',
                'Con socios comerciales.',
                'Con otros usuarios (en áreas públicas).',
                'Con su consentimiento.'
              ]),
              SizedBox(height: 24),
              Text('Retención de sus datos personales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('La Compañía conservará sus Datos Personales solo durante el tiempo necesario para los fines establecidos y para cumplir con obligaciones legales.'),
              SizedBox(height: 24),
              Text('Transferencia de sus datos personales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Su información puede transferirse y mantenerse en computadoras fuera de su jurisdicción. Al enviar su información, usted acepta dicha transferencia. Tomaremos todas las medidas necesarias para asegurar el tratamiento seguro de su información.'),
              SizedBox(height: 24),
              Text('Eliminar sus datos personales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Tiene derecho a eliminar o solicitar la eliminación de sus datos. Puede hacerlo desde la aplicación o contactándonos directamente.'),
              SizedBox(height: 24),
              Text('Divulgación de sus datos personales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              BulletList(items: [
                'Transacciones comerciales.',
                'Cumplimiento legal.',
                'Protección contra responsabilidades legales o peligros.',
                'Seguridad pública o del usuario.'
              ]),
              SizedBox(height: 24),
              Text('Seguridad de sus datos personales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Nos esforzamos por usar medios comercialmente aceptables para proteger su información, aunque ningún método es 100% seguro.'),
              SizedBox(height: 24),
              Text('Privacidad de menores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('No recopilamos conscientemente información de menores de 13 años. Si usted es padre o tutor y sabe que su hijo nos proporcionó datos personales, contáctenos.'),
              SizedBox(height: 24),
              Text('Enlaces a otros sitios web', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Nuestro Servicio puede contener enlaces a otros sitios que no son operados por nosotros. No nos responsabilizamos de sus prácticas de privacidad.'),
              SizedBox(height: 24),
              Text('Cambios a esta Política de Privacidad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Podemos actualizar esta política. Notificaremos los cambios importantes y actualizaremos la fecha al inicio de este documento.'),
              SizedBox(height: 24),
              Text('Contáctanos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Si tiene preguntas sobre esta Política de Privacidad, puede contactarnos por correo electrónico: jovenesapce@gmail.com')
            ],
          ),
        ),
      ),
    );
    }

}

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('\u2022 ', style: TextStyle(fontSize: 16)),
            Expanded(child: Text(item)),
          ],
        ),
      ))
          .toList(),
    );
  }
}
