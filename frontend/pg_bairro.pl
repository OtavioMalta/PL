/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).



/* PÃ¡gina de cadastro de bookmark */
cadastroBai(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Bairro')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Novo Bairro'),
                \form_bookmarkbai
              ]) ]).

form_bookmarkbai -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/bairros' )"),
                action('/api/v1/api_bairro/')],
              [ \metodo_de_envio('POST'),
                \campo(baiNom, 'Nome do Bairro', text),
                \campo(baiCep, 'CEP do Bairro', text),
                \campo(baiNomAbre, 'Abreviação do Nome', text),
                \campo(baiQtd, 'Quantidade de Bairro', text),
                \enviar_ou_cancelar('/bairros')
              ])).


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



/* PÃ¡gina para ediÃ§Ã£o (alteraÃ§Ã£o) de um bookmark  */

editarBai(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( bairro:bairro(Id,BaiNom,BaiCep,BaiNomAbre,BaiQtd)
    ->
    reply_html_page(
        boot5rest,
        [ title('Bairro')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Meus Bairros'),
                \form_bookmarkbai(Id, BaiNom,BaiCep,BaiNomAbre,BaiQtd)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkbai(Id, BaiNom,BaiCep,BaiNomAbre,BaiQtd) -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/bairros' )"),
                action('/api/v1/api_bairro/~w' - Id)],

              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo(baiNom, 'Nome do Bairro', text, BaiNom),
                \campo(baiCep, 'CEP do Bairro', text, BaiCep),
                \campo(baiNomAbre, 'Abreviação do Nome', text, BaiNomAbre),
                \campo(baiQtd, 'Quantidade de Bairro', text, BaiQtd),
                \enviar_ou_cancelar('/bairros')
              ])).


mostraBai(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( bairro:bairro(Id,BaiNom,BaiCep,BaiNomAbre,BaiQtd)
    ->
    reply_html_page(
        boot5rest,
        [ title('Bairro')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Meus Bairros'),
                \form_bookmarkmosbai(Id, BaiNom,BaiCep,BaiNomAbre,BaiQtd)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkmosbai(Id, BaiNom,BaiCep,BaiNomAbre,BaiQtd) -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/api_bairro/~w' - Id) ],
              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo_nao_editavel(baiNom, 'Nome do Bairro', text, BaiNom),
                \campo_nao_editavel(baiCep, 'CEP do Bairro', integer, BaiCep),
          \campo_nao_editavel(baiNomAbre, 'Abreviação do Nome', text, BaiNomAbre),
             \campo_nao_editavel(baiQtd, 'Quantidade de Bairro', integer, BaiQtd),
                \enviar_ou_cancelar('/bairros')
              ])).

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
                       % name(Nome),%  nÃ£o Ã© para enviar o id
                       value(Valor),
                       readonly ])
             ] )).

metodo_de_envio(Metodo) -->
    html(input([type(hidden), name('_metodo'), value(Metodo)])).
