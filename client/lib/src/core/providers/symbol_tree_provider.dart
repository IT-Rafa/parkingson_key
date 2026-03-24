import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

final symbolTreeProvider = Provider<List<PhraseNode>>((ref) {
  return [
    PhraseNode(
      id: 'sym_punctuation',
      title: 'Puntuación',
      isCategory: true,
      children: [
        PhraseNode(id: 'sym_p_dot', title: '.'),
        PhraseNode(id: 'sym_p_comma', title: ','),
        PhraseNode(id: 'sym_p_middledot', title: '·'),
        PhraseNode(id: 'sym_p_semicolon', title: ';'),
        PhraseNode(id: 'sym_p_colon', title: ':'),
        PhraseNode(id: 'sym_p_hyphen', title: '-'),
        PhraseNode(id: 'sym_p_underscore', title: '_'),
        PhraseNode(id: 'sym_p_ellipsis', title: '…'),
      ],
    ),
    PhraseNode(
      id: 'sym_intonation',
      title: 'Entonación',
      isCategory: true,
      children: [
        PhraseNode(id: 'sym_i_exclamdown', title: '¡'),
        PhraseNode(id: 'sym_i_exclamation', title: '!'),
        PhraseNode(id: 'sym_i_questiondown', title: '¿'),
        PhraseNode(id: 'sym_i_question', title: '?'),
      ],
    ),
    PhraseNode(
      id: 'sym_grouping',
      title: 'Agrupación',
      isCategory: true,
      children: [
        PhraseNode(id: 'sym_g_doublequote', title: '"'),
        PhraseNode(id: 'sym_g_singlequote', title: "'"),
        PhraseNode(id: 'sym_g_lparen', title: '('),
        PhraseNode(id: 'sym_g_rparen', title: ')'),
        PhraseNode(id: 'sym_g_lbracket', title: '['),
        PhraseNode(id: 'sym_g_rbracket', title: ']'),
        PhraseNode(id: 'sym_g_lbrace', title: '{'),
        PhraseNode(id: 'sym_g_rbrace', title: '}'),
      ],
    ),
    PhraseNode(
      id: 'sym_math',
      title: 'Matemáticos',
      isCategory: true,
      children: [
        PhraseNode(id: 'sym_m_plus', title: '+'),
        PhraseNode(id: 'sym_m_minus', title: '-'),
        PhraseNode(id: 'sym_m_asterisk', title: '*'),
        PhraseNode(id: 'sym_m_slash', title: '/'),
        PhraseNode(id: 'sym_m_caret', title: '^'),
        PhraseNode(id: 'sym_m_equals', title: '='),
        PhraseNode(id: 'sym_m_percent', title: '%'),
        PhraseNode(id: 'sym_m_degree', title: 'º'),
        PhraseNode(id: 'sym_m_ordinal_a', title: 'ª'),
      ],
    ),
    PhraseNode(
      id: 'sym_social',
      title: 'Social',
      isCategory: true,
      children: [
        PhraseNode(id: 'sym_s_at', title: '@'),
        PhraseNode(id: 'sym_s_hash', title: '#'),
      ],
    ),
    PhraseNode(
      id: 'sym_money',
      title: 'Dinero',
      isCategory: true,
      children: [
        PhraseNode(id: 'sym_m_euro', title: '€'),
        PhraseNode(id: 'sym_m_dollar', title: '\$'),
      ],
    ),
    PhraseNode(
      id: 'sym_other',
      title: 'Otros',
      isCategory: true,
      children: [
        PhraseNode(id: 'sym_o_ampersand', title: '&'),
        PhraseNode(id: 'sym_o_tilde', title: '~'),
        PhraseNode(id: 'sym_o_backslash', title: '\\'),
        PhraseNode(id: 'sym_o_pipe', title: '|'),
      ],
    ),
  ];
});
