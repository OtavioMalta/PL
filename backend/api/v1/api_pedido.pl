:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_json)).

:- use_module(bd(pedido),[]).

api_pedido(get,'',_Pedido):- !,
    envia_tabelaped.

api_pedido(get,AtomId,_Pedido):-
    atom_number(AtomId,Id),
    !,
    envia_tuplaped(Id).

api_pedido(post,_,Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tuplaped(Dados).

api_pedido(put,AtomId,Pedido):-
    atom_number(AtomId,Id),
    http_read_json_dict(Pedido,Dados),!,
    atualiza_tuplaped(Dados,Id).

api_pedido(delete,AtomId,_Pedido):-
    atom_number(AtomId,Id),!,
    pedido:remove(Id),
    throw(http_reply(no_content)).

api_pedido(Met,Id,_Pedido):-
    throw(http_reply(method_not_allowed(Met,Id))).

insere_tuplaped(_{emiObsCod: EmiObsCod, emiObs:EmiObs, emiDatObs: EmiDatObs,emiUsuCod: EmiUsuCod}):-
    pedido:insere(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    -> envia_tuplaped(EmiCod)
    ; throw(http_reply(bad_request('Informação Ausente'))).

atualiza_tuplaped(_{emiObsCod: EmiObsCod, emiObs:EmiObs, emiDatObs: EmiDatObs,emiUsuCod: EmiUsuCod},EmiCod):-
    pedido:atualiza(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    -> envia_tuplaped(EmiCod)
    ;  throw(http_reply(not_found(EmiCod))).

envia_tuplaped(EmiCod):-
    pedido:pedido(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    -> reply_json_dict(_{ emiCod:EmiCod,emiObsCod: EmiObsCod, emiObs:EmiObs, emiDatObs: EmiDatObs,emiUsuCod: EmiUsuCod})
    ; throw(http_reply(not_found(EmiCod))).

envia_tabelaped:-
    findall(_{emiCod:EmiCod, emiObsCod: EmiObsCod, emiObs:EmiObs, emiDatObs: EmiDatObs,emiUsuCod: EmiUsuCod},
            pedido:pedido(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod),
            Tuplas),
    reply_json_dict(Tuplas).


