:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_json)).

:- use_module(bd(estado),[]).

api_estado(get,'',_Pedido):- !,
    envia_tabelaest.

api_estado(get,AtomId,_Pedido):-
    atom_number(AtomId,Id),
    !,
    envia_tuplaest(Id).

api_estado(post,_,Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tuplaest(Dados).

api_estado(put,AtomId,Pedido):-
    atom_number(AtomId,Id),
    http_read_json_dict(Pedido,Dados),!,
    atualiza_tuplaest(Dados,Id).

api_estado(delete,AtomId,_Pedido):-
    atom_number(AtomId,Id),!,
    estado:remove(Id),
    throw(http_reply(no_content)).

api_estado(Met,Id,_Pedido):-
    throw(http_reply(method_not_allowed(Met,Id))).

insere_tuplaest(_{ estNom:EstNom, estQtd: EstQtd}):-
    estado:insere(EstCod,EstNom,EstQtd)
    -> envia_tuplaest(EstCod)
    ; throw(http_reply(bad_request('Informação ausente'))).

atualiza_tuplaest(_{ estNom:EstNom, estQtd: EstQtd},EstCod):-
    estado:atualiza(EstCod,EstNom,EstQtd)
    -> envia_tuplaest(EstCod)
    ;  throw(http_reply(not_found(EstCod))).

envia_tuplaest(EstCod):-
    estado:estado(EstCod,EstNom,EstQtd)
    -> reply_json_dict(_{ estCod:EstCod, estNom:EstNom,estQtd: EstQtd})
    ; throw(http_reply(not_found(EstCod))).

envia_tabelaest:-
    findall(_{estCod:EstCod, estNom:EstNom, estQtd: EstQtd},
            estado:estado(EstCod,EstNom,EstQtd),
            Tuplas),
    reply_json_dict(Tuplas).


