/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).

:- use_module(bd(proposta), []).

entradaProposta(_):-
    reply_html_page(
        boot5rest,
        [ title('Propostas')],
        [ div(class(container),
              [ \html_requires(css('entrada.css')),
                \html_requires(js('bookmark.js')),
                \titulo_da_paginaPro('Propostas '),
                \tabela_de_bookmarksPro

              ]) ]).

titulo_da_paginaPro(Titulo) -->
    html( div(class('text-center align-items-center w-100'),
              h1('display-3', Titulo))).

tabela_de_bookmarksPro -->
    html(div(class('container-fluid py-3'),
             [
               \cabeca_da_tabelaPro('     ', '/','voltar'),
               \cabeca_da_tabelaPro('Propostas', '/proposta','Nova Proposta'),
               \tabelapro
             ]
            )).


cabeca_da_tabelaPro(Titulo,Link,Nome) -->
    html( div(class('d-flex'),
              [ div(class('me-auto p-2'), h2(b(Titulo))),
                div(class('p-2'),
                    a([ href(Link), class('btn btn-primary')],
                      Nome))
              ]) ).

tabelapro -->
    html(div(class('table-responsive-md'),
             table(class('table table-striped w-100'),
                   [ \cabecalhopro,
                     tbody(\corpo_tabelapro)
                   ]))).

cabecalhopro -->
    html(thead(tr([ th([scope(col)], '#'),
                    th([scope(col)], 'Codigo do Cliente'),
                    th([scope(col)], 'Descrição'),
                    th([scope(col)], 'Status'),
                    th([scope(col)], 'Acoes')
                  ]))).



corpo_tabelapro -->
    {
        findall( tr([th(scope(row), Id), td(CodigoCliente), td(Descricao),td(Status),td(Acoes)]),
                 linhapro(Id, CodigoCliente, Descricao,Status, Acoes),
                 Linhas )
    },
    html(Linhas).




linhapro(Id, CodigoCliente, Descricao, Status, Acoes):-
    proposta:proposta(Id,CodigoCliente,_,Descricao,_,Status,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),
    acoespro(Id,Acoes).

acoespro(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/proposta/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                  href('/api/v1/api_proposta/~w' - Id),
                  onClick("apagar( event, '/propostas' )"),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].
