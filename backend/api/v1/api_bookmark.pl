/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).


:- use_module(bd(bookmark), []).

api_bookmark(get, '', _Pedido):- !,
    envia_tabelabook.

api_bookmark(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tuplabook(Id).

api_bookmark(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tuplabook(Dados).

api_bookmark(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tuplabook(Dados, Id).

api_bookmark(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    bookmark:remove(Id),
    throw(http_reply(no_content)).


api_bookmark(Mtodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Mtodo, Id))).


insere_tuplabook( _{ t�tulo:T�tulo, url:URL}):-
    % Validar URL antes de inserir
    bookmark:insere(Id, T�tulo, URL)
    -> envia_tuplabook(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_tuplabook( _{ t�tulo:T�tulo, url:URL}, Id):-
       bookmark:atualiza(Id, T�tulo, URL)
    -> envia_tuplabook(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tuplabook(Id):-
       bookmark:bookmark(Id, _T�tulo, _URL)
    -> reply_json_dict( _{id:Id, t�tulo:"teste", url:"h:"} )
    ;  throw(http_reply(not_found(Id))).


envia_tabelabook:-
    findall( _{id:Id, t�tulo:T�tulo, url:URL},
             bookmark:bookmark(Id,T�tulo,URL),
             Tuplas ),
    reply_json_dict(Tuplas).
