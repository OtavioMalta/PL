/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).

:- use_module(bd(observacoesProposta), []).

entradaObs(_):-
    reply_html_page(
        boot5rest,
        [ title('Observações da Proposta')],
        [ div(class(container),
              [ \html_requires(css('entrada.css')),
                \html_requires(js('bookmark.js')),
                \titulo_da_paginaobs('Minhas Obs. Proposta'),
                \tabela_de_bookmarksobs

              ]) ]).

titulo_da_paginaobs(Titulo) -->
    html( div(class('text-center align-items-center w-100'),
              h1('display-3', Titulo))).

tabela_de_bookmarksobs -->
    html(div(class('container-fluid py-3'),
             [
               \cabeca_da_tabelaobs('     ', '/','voltar'),
               \cabeca_da_tabelaobs('Obs da Proposta','/observacoesProposta','Nova Obs. Proposta'),
               \tabelaobs
             ]
            )).


cabeca_da_tabelaobs(Titulo,Link,Nome) -->
    html( div(class('d-flex'),
              [ div(class('me-auto p-2'), h2(b(Titulo))),
                div(class('p-2'),
                    a([ href(Link), class('btn btn-primary')],
                      Nome))
              ]) ).


tabelaobs -->
    html(div(class('table-responsive-md'),
             table(class('table table-striped w-100'),
                   [ \cabecalhoobs,
                     tbody(\corpo_tabelaobs)
                   ]))).

cabecalhoobs -->
    html(thead(tr([ th([scope(col)], '#'),
                    th([scope(col)], 'Cod. Obs'),
                    th([scope(col)], 'Obs'),
					th([scope(col)], 'Data Obs'),
					th([scope(col)], 'Usuario'),
                    th([scope(col)], 'Acoes')
                  ]))).



corpo_tabelaobs -->
    {
        findall( tr([th(scope(row), Id), td(CodObserv), td(Observ), td(DataObserv), td(Usuario), td(Acoes)]),
                 linhaobs(Id, CodObserv, Observ, DataObserv,Usuario, Acoes),
                 Linhas )
    },
    html(Linhas).




linhaobs(Ido,CodObserv, Observ, DataObserv,Usuario, Acoes):-
    observacoesProposta:observacoesProposta(Ido,CodObserv, Observ, DataObserv,Usuario),
    acoesobs(Ido,Acoes).


acoesobs(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/observacoesProposta/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                  href('/api/v1/api_observacoesProposta/~w' - Id),
                  onClick("apagar( event, '/observacoesPropostas' )"),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].


% Ãcones do Bootstrap 5
/*
lapis -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-pencil'),
               viewBox('0 0 16 16')
             ],
             path(d(['M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0',
             ' 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5',
             ' 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4',
             ' 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761',
             ' 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5',
             ' 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z']),
                  []))).

lixeira -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-trash'),
               viewBox('0 0 16 16')
             ],
             [ path(d(['M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1',
                       ' .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5',
                       ' 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z']),
                    []),
               path(['fill-rule'(evenodd),
                     d(['M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0',
                        ' 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1',
                        ' 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4',
                        ' 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882',
                        ' 4H4.118zM2.5 3V2h11v1h-11z'])],
                    [])])).

*/
