import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_provider.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

Future<void> initDefaultPhrases(WidgetRef ref) async {
  final treeNotifier = ref.read(phraseTreeProvider.notifier);

  // Evita reiniciar si ya hay frases
  if (ref.read(phraseTreeProvider).isNotEmpty) return;

  // Función de ayuda para traducir automáticamente
  String trText(String key) => key.tr();

  final defaultTree = <PhraseNode>[
    PhraseNode(
      id: 'cotidiano',
      title: trText('Cotidiano'),
      isCategory: true,
      children: [
        PhraseNode(
          id: 'comer',
          title: trText('Comer'),
          isCategory: true,
          children: [
            PhraseNode(
                id: 'hora_comida',
                title: trText('Es la hora de la comida'),
                children: []),
            PhraseNode(
                id: 'ya_dieron_comida',
                title: trText('Ya me dieron la comida'),
                children: []),
          ],
        ),
        PhraseNode(
          id: 'medicinas',
          title: trText('Medicinas'),
          isCategory: true,
          children: [
            PhraseNode(
                id: 'ya_dieron_medicinas',
                title: trText('Ya me dieron las medicinas'),
                children: []),
            PhraseNode(
                id: 'faltan_medicinas',
                title: trText('Me faltan las medicinas'),
                children: []),
          ],
        ),
        PhraseNode(
          id: 'distraccion',
          title: trText('Distracción'),
          isCategory: true,
          children: [
            PhraseNode(
                id: 'cambia_tv',
                title: trText('Cambia el canal de la tv'),
                children: []),
            PhraseNode(
                id: 'pon_libro', title: trText('Ponme el libro'), children: []),
            PhraseNode(
                id: 'ajusta_libro',
                title: trText('Ajusta el libro'),
                children: []),
            PhraseNode(
                id: 'libro_acabo',
                title: trText('El libro se acabo'),
                children: []),
          ],
        ),
      ],
    ),
    PhraseNode(
      id: 'estado',
      title: trText('Estado'),
      isCategory: true,
      children: [
        PhraseNode(
          id: 'postura',
          title: trText('Postura'),
          isCategory: true,
          children: [
            PhraseNode(
                id: 'cambiar_postura',
                title: trText('Quiero cambiar de postura'),
                children: []),
            PhraseNode(
                id: 'ajustar_silla',
                title: trText('Ajusta mi silla'),
                children: []),
            PhraseNode(
                id: 'ajustar_almohada',
                title: trText('Ajusta la almohada'),
                children: []),
            PhraseNode(
                id: 'colchon_antiescaras',
                title: trText('El colchon antiescaras está mal hinchado'),
                children: []),
          ],
        ),
        PhraseNode(
          id: 'dolor',
          title: trText('Dolor'),
          isCategory: true,
          children: [
            PhraseNode(id: 'me_duele', title: trText('Me duele'), children: []),
          ],
        ),
        PhraseNode(
          id: 'estado_general',
          title: trText('Estado'),
          isCategory: true,
          children: [
            PhraseNode(
                id: 'tengo_frio', title: trText('Tengo frío'), children: []),
            PhraseNode(
                id: 'tengo_calor', title: trText('Tengo calor'), children: []),
          ],
        ),
      ],
    ),
    PhraseNode(
      id: 'horario',
      title: trText('Horario'),
      isCategory: true,
      children: [
        PhraseNode(
            id: 'preparacion_cita',
            title: trText('Tenemos que prepararnos para la cita'),
            children: []),
        PhraseNode(
            id: 'cita_medico',
            title: trText('Tengo cita con médico'),
            children: []),
        PhraseNode(
            id: 'cita_amigas',
            title: trText('Tengo cita con amigas'),
            children: []),
      ],
    ),
    PhraseNode(
      id: 'palabras',
      title: trText('Palabras'),
      isCategory: true,
      children: [
        PhraseNode(
          id: 'cuerpo',
          title: trText('Cuerpo'),
          isCategory: true,
          children: [
            PhraseNode(id: 'cabeza', title: trText('Cabeza'), children: []),
            PhraseNode(id: 'oreja', title: trText('Oreja'), children: []),
            PhraseNode(id: 'espalda', title: trText('Espalda'), children: []),
            PhraseNode(id: 'brazo', title: trText('Brazo'), children: []),
            PhraseNode(id: 'pierna', title: trText('Pierna'), children: []),
            PhraseNode(id: 'culo', title: trText('Culo'), children: []),
          ],
        ),
        PhraseNode(
          id: 'medicinas_palabras',
          title: trText('Medicinas'),
          isCategory: true,
          children: [],
        ),
        PhraseNode(
          id: 'muebles',
          title: trText('Muebles'),
          isCategory: true,
          children: [
            PhraseNode(
              id: 'armario_grande',
              title: trText('Armario grande'),
              isCategory: true,
              children: [
                PhraseNode(
                    id: 'armario_derecha_arriba',
                    title: trText('Armario, lado derecho, arriba de todo'),
                    children: []),
                PhraseNode(
                    id: 'armario_derecha_perchas',
                    title: trText('Armario, lado derecho, perchas'),
                    children: []),
                PhraseNode(
                    id: 'armario_derecha_cajon',
                    title: trText('Armario, lado derecho, cajon'),
                    children: []),
                PhraseNode(
                    id: 'armario_izquierda_arriba',
                    title: trText('Armario, lado izquierdo, arriba de todo'),
                    children: []),
                PhraseNode(
                    id: 'armario_izquierda_perchas',
                    title: trText('Armario, lado izquierdo, perchas'),
                    children: []),
                PhraseNode(
                    id: 'armario_izquierda_cajon',
                    title: trText('Armario, lado izquierdo, cajon'),
                    children: []),
              ],
            ),
            PhraseNode(
              id: 'mueble_cajones',
              title: trText('Mueble cajones'),
              isCategory: true,
              children: [
                PhraseNode(
                    id: 'mueble_peq_izq_1',
                    title: trText('mueble pequeño al lado izquierdo'),
                    children: []),
                PhraseNode(
                    id: 'mueble_peq_izq_2',
                    title: trText('mueble pequeño al lado izquierdo'),
                    children: []),
              ],
            ),
            PhraseNode(
              id: 'habitaciones',
              title: trText('Habitaciones'),
              isCategory: true,
              children: [
                PhraseNode(
                    id: 'mi_habitacion',
                    title: trText('Mi habitación'),
                    children: []),
                PhraseNode(
                    id: 'mi_bano', title: trText('Mi baño'), children: []),
                PhraseNode(
                    id: 'habitacion_rafa',
                    title: trText('Habitación de Rafa'),
                    children: []),
                PhraseNode(
                    id: 'habitacion_berto',
                    title: trText('Habitación de Berto'),
                    children: []),
                PhraseNode(
                    id: 'habitacion_ninos',
                    title: trText('Habitación de niños'),
                    children: []),
                PhraseNode(
                    id: 'pasillo', title: trText('Pasillo'), children: []),
                PhraseNode(id: 'bano', title: trText('Baño'), children: []),
                PhraseNode(id: 'salon', title: trText('Salón'), children: []),
                PhraseNode(id: 'cocina', title: trText('Cocina'), children: []),
              ],
            ),
          ],
        ),
      ],
    ),
    PhraseNode(
      id: 'direccion',
      title: trText('Dirección'),
      isCategory: true,
      children: [
        PhraseNode(
            id: 'izquierda', title: trText('A la izquierda'), children: []),
        PhraseNode(id: 'derecha', title: trText('A la derecha'), children: []),
        PhraseNode(id: 'arriba', title: trText('Arriba'), children: []),
        PhraseNode(id: 'abajo', title: trText('Abajo'), children: []),
      ],
    ),
    // Añadir más nodos siguiendo la misma estructura...
  ];

  await treeNotifier.saveTree(defaultTree);
}
