/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).



/* PÃ¡gina de cadastro de bookmark */
cadastroPess(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Pessoa')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Novo Pessoa'),
                \form_bookmarkpess
              ]) ]).

form_bookmarkpess -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/pessoas' )"),
                action('/api/v1/api_pessoa/')],
              [ \metodo_de_envio('POST'),
			    \campo(fisTipo, 'Tipo', text),
                \campo(fisNom, 'Nome Pessoa', text),
			    \campo(fisRazSoc, 'Raz�o Social', text),
				\campo(fisDatNas, 'Data Nascimento', text),
				\campo(fisSexo, 'Sexo', text),
				\campo(fisCpf, 'CPF', text),
				\campo(fisCnpj, 'CNPJ', text),
				\campo(fisEstNom, 'Estado', text),
				\campo(fisCidNom, 'Cidade', text),
				\campo(fisBaiNom, 'Bairro', text),
				\campo(fisLgrNom, 'Rua', text),
				\campo(fisLgrNro, 'N�', text),
				\campo(fisEmail, 'Email', text),
				\campo(fisFon, 'Fone', text),
                \campo(fisFon2, 'Fone 2', text),
				\campo(fisFax, 'FAX', text),
				\campo(fisCel, 'Celular', text),
                \campo(fisDatReg, 'Data Registro', text),
                \campo(fidIndCad, 'Ind. Cad.', text),
                \enviar_ou_cancelar('/pessoas')
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

/* PÃ¡gina para ediÃ§Ã£o (alteraÃ§Ã£o) de um bookmark  */

editarPess(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( pessoa:pessoa(Id,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad)
    ->
    reply_html_page(
        boot5rest,
        [ title('Pessoa')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Meus Pessoas'),
                \form_bookmarkpess(Id,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkpess(Id,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad) -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/pessoas' )"),
                action('/api/v1/api_pessoa/~w' - Id)],

              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo(fisTipo, 'Tipo', text, FisTipo),
				\campo(fisNom, 'Nome Pessoa', text,FisNom),
				\campo(fisRazSoc, 'Raz�o Social', text,FisRazSoc),
				\campo(fisDatNas, 'Data Nascimento', text,FisDatNas),
				\campo(fisSexo, 'Sexo', text,FisSexo),
				\campo(fisCpf, 'CPF', text,FisCpf),
				\campo(fisCnpj, 'CNPJ', text,FisCnpj),
				\campo(fisEstNom, 'Estado', text,FisEstNom),
				\campo(fisCidNom, 'Cidade', text,FisCidNom),
				\campo(fisBaiNom, 'Bairro', text,FisBaiNom),
				\campo(fisLgrNom, 'Rua', text,FisLgrNom),
				\campo(fisLgrNro, 'N�', text,FisLgrNro),
				\campo(fisEmail, 'Email', text,FisEmail),
				\campo(fisFon, 'Fone', text,FisFon),
				\campo(fisFon2, 'Fone 2', text,FisFon2),
				\campo(fisFax, 'FAX', text,FisFax),
				\campo(fisCel, 'Celular', text,FisCel),
				\campo(fisDatReg, 'Data Registro', text,FisDatReg),
				\campo(fidIndCad, 'Ind. Cad.', text,FidIndCad),
                \enviar_ou_cancelar('/pessoas')
              ])).


mostraPess(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( pessoa:pessoa(Id,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad)
    ->
    reply_html_page(
        boot5rest,
        [ title('Pessoa')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Meus Pessoas'),
                \form_bookmarkmospess(Id,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkmospess(Id,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad)
                     -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/api_pessoa/~w' - Id) ],
              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
               \campo_nao_editavel(id, 'Id', text, Id),
			   \campo_nao_editavel(fisTipo, 'Tipo', text, FisTipo),
			   \campo_nao_editavel(fisNom, 'Nome Pessoa', text,FisNom),
			   \campo_nao_editavel(fisRazSoc, 'Razão Social', text,FisRazSoc),
			   \campo_nao_editavel(fisDatNas, 'Data Nascimento', text,FisDatNas),
			   \campo_nao_editavel(fisSexo, 'Sexo', text,FisSexo),
			   \campo_nao_editavel(fisCpf, 'CPF', text,FisCpf),
			   \campo_nao_editavel(fisCnpj, 'CNPJ', text,FisCnpj),
			   \campo_nao_editavel(fisEstNom, 'Estado', text,FisEstNom),
			   \campo_nao_editavel(fisCidNom, 'Cidade', text,FisCidNom),
			   \campo_nao_editavel(fisBaiNom, 'Bairro', text,FisBaiNom),
			   \campo_nao_editavel(fisLgrNom, 'Rua', text,FisLgrNom),
			   \campo_nao_editavel(fisLgrNro, 'Nº', text,FisLgrNro),
			   \campo_nao_editavel(fisEmail, 'Email', text,FisEmail),
			   \campo_nao_editavel(fisFon, 'Fone', text,FisFon),
			   \campo_nao_editavel(fisFon2, 'Fone 2', text,FisFon2),
			   \campo_nao_editavel(fisFax, 'FAX', text,FisFax),
			   \campo_nao_editavel(fisCel, 'Celular', text,FisCel),
			   \campo_nao_editavel(fisDatReg, 'Data Registro', text,FisDatReg),
			   \campo_nao_editavel(fidIndCad, 'Ind. Cad.', text,FidIndCad),
                \enviar_ou_cancelar('/pessoas')
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
                       % name(Nome),%  nÃ£o Ã© para enviar o id
                       value(Valor),
                       readonly ])
             ] )).

metodo_de_envio(Metodo) -->
    html(input([type(hidden), name('_metodo'), value(Metodo)])).
*/
