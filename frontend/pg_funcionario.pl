/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).



/* PÃ¡gina de cadastro de bookmark */
cadastroFun(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Funcionario')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Novo Funcionario'),
                \form_bookmarkfun
              ]) ]).

form_bookmarkfun -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/funcionarios' )"),
                action('/api/v1/api_funcionario/')],
              [ \metodo_de_envio('POST'),
                \campo(funNome, 'Nome do Funcionario', text),
                \campo(funCpf, 'CPF do Funcionario', text),
                \campo(funLgr, 'Logradouro', text),
                \campo(funSexo, 'Sexo', text),
                \campo(funCid, 'Cidade', text),
                \campo(funEst, 'Estado', text),
                \campo(funFon, 'Telefone', text),
                \campo(funEmail, 'Email', text),
                \enviar_ou_cancelarfun('/funcionarios')
              ])).


enviar_ou_cancelarfun(RotaDeRetorno) -->
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


/* PÃ¡gina para ediÃ§Ã£o (alteraÃ§Ã£o) de um bookmark  */

editarFun(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( funcionario:funcionario(Id,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail)
    ->
    reply_html_page(
        boot5rest,
        [ title('Funcionario')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Funcionarios'),
                \form_bookmarkfun(Id, FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkfun(Id, FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail) -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/funcionarios' )"),
                action('/api/v1/api_funcionario/~w' - Id)],

              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo(funNome, 'Nome do Funcionario', text,FunNome),
                \campo(funCpf, 'CPF do Funcionario', text,FunCpf),
                \campo(funLgr, 'Logradouro', text,FunLgr),
                \campo(funSexo, 'Sexo', text,FunSexo),
                \campo(funCid, 'Cidade', text,FunCid),
                \campo(funEst, 'Estado', text,FunEst),
                \campo(funFon, 'Telefone', text,FunFon),
                \campo(funEmail, 'Email', text,FunEmail),
                \enviar_ou_cancelarfun('/funcionarios')
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
