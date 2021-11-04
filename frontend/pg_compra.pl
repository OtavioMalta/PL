/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).



/* Página de cadastro de bookmark */
cadastroCompra(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Compra')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Nova Compra'),
                \form_bookmarkcp
              ]) ]).

form_bookmarkcp -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/compras' )"),
                action('/api/v1/api_compra/') ],
              [ \metodo_de_envio('POST'),
                \campo(baxEsqQtd, 'Quantidade baxa no estoque', text),
                \campo(baxa, 'Baxado', text),
                \campo(baxEsqPdd, 'Numero do pedido', text),
                \campo(baxEsqDat, 'Data da baxa', text),
                \campo(separador, 'Separador', text),
                \campo(comEsqQtd, 'Quantidade comprada', text),
                \campo(compra, 'O que foi comprado', text),
                \campo(comesqDat, 'Data da compra', text),

                \enviar_ou_cancelarcp('/compras')
              ])).

enviar_ou_cancelarcp(RotaDeRetorno) -->
    html(div([ class('btn-group'), role(group), 'aria-label'('Enviar ou cancelar')],
             [ button([ type(submit),
                        class('btn btn-outline-primary')], 'Enviar'),
               a([ href(RotaDeRetorno),
                   class('ms-3 btn btn-outline-danger')], 'Cancelar')
            ])).


/*
campo(Nome, Titulo, Tipo) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label') ], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome)])
             ] )).
*/


/* Página para edição (alteração) de um bookmark  */

editarCompra(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( compra:compra(Id,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat)    ->
    reply_html_page(
        boot5rest,
        [ title('Compra')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Editar Compra'),
                \form_bookmarkcp(Id,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkcp(Id,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat) -->
     html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/compras' )"),
                action('/api/v1/api_compra/~w' - Id) ],
              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo(baxEsqQtd, 'Quantidade baxa no estoque', text,BaxEsqQtd),
                \campo(baxa, 'Baxado', text,Baxa),
                \campo(baxEsqPdd, 'Numero do pedido', text,BaxEsqPdd),
                \campo(baxEsqDat, 'Data da baxa', text,BaxEsqDat),
                \campo(separador, 'Separador', text,Separador),
                \campo(comEsqQtd, 'Quantidade comprada', text,ComEsqQtd),
                \campo(compra, 'O que foi comprado', text,Compra),
                \campo(comesqDat, 'Data da compra', text,ComesqDat),
                \enviar_ou_cancelarcp('/compras')
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
                       % name(Nome),%  não é para enviar o id
                       value(Valor),
                       readonly ])
             ] )).

metodo_de_envio(Metodo) -->
    html(input([type(hidden), name('_metodo'), value(Metodo)])).
*/
