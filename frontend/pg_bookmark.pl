
/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).

:- use_module(bd(bookmark),[]).

mostraAlunos(_):-
    reply_html_page(
        boot5rest,
        [ title('Programacao Logica')],
        [ div(class(container),
              [ \html_requires(css('entrada.css')),
                \html_requires(js('bookmark.js')),
                \line,
                \titulo_da_paginaal(' Alunos '),
                \line,
                \tabela_de_bookmarksal

              ]) ]).

titulo_da_paginaal(Titulo) -->
    html( div(class('text-center align-items-center w-100'),
              h1('display-3', Titulo))).

tabela_de_bookmarksal -->
    html(div(class('container-fluid py-3'),
             [
               \cabeca_da_tabelaal('     ', '/','voltar'),
               \tabelaal
             ]
            )).


cabeca_da_tabelaal(Titulo,Link,Nome) -->
    html( div(class('d-flex'),
              [ div(class('me-auto p-2'), h2(b(Titulo))),
                div(class('p-2'),
                    a([ href(Link), class('btn btn-primary')],
                      Nome))
              ]) ).


tabelaal -->
    html(div(class('table-responsive-md'),
             table(class('table table-striped w-100'),
                   [ \cabecalhoal,
                     tbody(\corpo_tabelaal)
                   ]))).

cabecalhoal -->
    html(thead(tr([ th([scope(col)], 'Matricula'),
                    th([scope(col)], 'Nome')

                  ]))).



corpo_tabelaal -->
    html(tr([th(scope(row), "12011BSI226"), td("Felipe Harrison ")])),
    html(tr([th(scope(row), "11511BSI265"), td("Mariana Alves")])),
    html(tr([th(scope(row), "12011BSI291"), td("Ot�vio Malta")])).

