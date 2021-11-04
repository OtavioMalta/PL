/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).



/* PÃƒÂ¡gina de cadastro de bookmark */
cadastroObs(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Obs. Proposta')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Novo Obs. Proposta'),
                \form_bookmarkobs
              ]) ]).

form_bookmarkobs -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/observacoesPropostas' )"),
                action('/api/v1/api_observacoesProposta/')],
              [ \metodo_de_envio('POST'),
                \campo(emiObsCod, 'Cod. Obs.', text),
                \campo(emiObs, 'Observação', text),
                \campo(emiDatObs, 'Data', text),
                \campo(emiUsuCod, 'Usuário', text),
                \enviar_ou_cancelar('/observacoesPropostas')
              ])).

/*
enviar_ou_cancelar(RotaDeRetorno) -->
    html(div([ class('btn-group'), role(group), 'aria-label'('Enviar ou cancelar')],
             [ button([ type(submit),
                        class('btn btn-outline-primary')], 'Enviar'),
               a([ href(RotaDeRetorno),
                   class('ms-3 btn btn-outline-danger')], 'Cancelar')
            ])).




campo(Nome, Titulo, Tipo) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label') ], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome)])
             ] )).

*/

/* PÃƒÂ¡gina para ediÃƒÂ§ÃƒÂ£o (alteraÃƒÂ§ÃƒÂ£o) de um bookmark  */

editarObs(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( observacoesProposta:observacoesProposta(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    ->
    reply_html_page(
        boot5rest,
        [ title('Obs. Proposta')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Meus Obs. Proposta'),
                \form_bookmarkobs(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkobs(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod) -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/observacoesPropostas' )"),
                action('/api/v1/api_observacoesProposta/~w' - Id)],

              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo(emiObsCod, 'Cod. Obs', text, EmiObsCod),
                \campo(emiObs, 'Observação', text, EmiObs),
                \campo(emiDatObs, 'Data', text, EmiDatObs),
                \campo(emiUsuCod, 'Usuário', text, EmiUsuCod),
                \enviar_ou_cancelar('/observacoesPropostas')
              ])).


mostraObs(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    (observacoesProposta:observacoesProposta(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    ->
    reply_html_page(
        boot5rest,
        [ title('Obs. Proposta')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Minhas Obs. Proposta'),
                \form_bookmarkmosobs(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkmosobs(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod) -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/api_observacoesProposta/~w' - Id) ],
              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo_nao_editavel(emiObsCod, 'Cod. Obs', text, EmiObsCod),
                \campo_nao_editavel(emiObs, 'Observação', text, EmiObs),
          \campo_nao_editavel(emiDatObs, 'Data', text, EmiDatObs),
             \campo_nao_editavel(emiUsuCod, 'Usuário', integer, EmiUsuCod),
                \enviar_ou_cancelar('/observacoesPropostas')
              ])).
/*
campo(Nome, Titulo, Tipo, Valor) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label')], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome), value(Valor)])
             ] )).

campo_nao_editavel(Nome, Titulo, Tipo, Valor) -->
    html(div(class('mb-3 w-25'),
             [ label([ for(Nome), class('form-label')], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome),
                       % name(Nome),%  nÃƒÂ£o ÃƒÂ© para enviar o id
                       value(Valor),
                       readonly ])
             ] )).

metodo_de_envio(Metodo) -->
    html(input([type(hidden), name('_metodo'), value(Metodo)])).
*/
