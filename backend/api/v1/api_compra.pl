:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_json)).

:- use_module(bd(compra),[]).

api_compra(get,'',_Pedido):- !,
    envia_tabela_compra.

api_compra(get,AtomId,_Pedido):-
    atom_number(AtomId,Id),
    !,
    envia_tupla_compra(Id).

api_compra(post,_,Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_compra(Dados).

api_compra(put,AtomId,Pedido):-
    atom_number(AtomId,Id),
    http_read_json_dict(Pedido,Dados),!,
    atualiza_tupla_compra(Dados,Id).

api_compra(delete,AtomId,_Pedido):-
    atom_number(AtomId,Id),!,
    compra:remove(Id),
    throw(http_reply(no_content)).

api_compra(Met,Id,_Pedido):-
    throw(http_reply(method_not_allowed(Met,Id))).


insere_tupla_compra(_{
	       baxEsqQtd: BaxEsqQtd,
	       baxa: Baxa,
	       baxEsqPdd: BaxEsqPdd,
	       baxEsqDat: BaxEsqDat,
	       separador: Separador,
	       comEsqQtd: ComEsqQtd,
	       compra: Compra,
	       comesqDat: ComesqDat}):-

    compra:insere(EsqCod,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat)
    -> envia_tupla_compra(EsqCod)
    ; throw(http_reply(bad_request('Informação Ausente'))).

atualiza_tupla_compra(_{baxEsqQtd: BaxEsqQtd,baxa: Baxa,baxEsqPdd: BaxEsqPdd,baxEsqDat: BaxEsqDat,separador: Separador,comEsqQtd: ComEsqQtd,compra: Compra,comesqDat: ComesqDat},EsqCod):-

     compra:atualiza(EsqCod,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat)
    -> envia_tupla_compra(EsqCod)
    ;  throw(http_reply(not_found(EsqCod))).

envia_tupla_compra(EsqCod):-
    compra:compra(EsqCod,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat)
    -> reply_json_dict(_{esqCod: EsqCod,baxEsqQtd: BaxEsqQtd,baxa: Baxa,baxEsqPdd: BaxEsqPdd,baxEsqDat: BaxEsqDat,separador: Separador,comEsqQtd: ComEsqQtd,compra: Compra,comesqDat: ComesqDat})
    ; throw(http_reply(not_found(EsqCod))).

envia_tabela_compra:-
    findall(_{esqCod: EsqCod,
	       baxEsqQtd: BaxEsqQtd,
	       baxa: Baxa,
	       baxEsqPdd: BaxEsqPdd,
	       baxEsqDat: BaxEsqDat,
	       separador: Separador,
	       comEsqQtd: ComEsqQtd,
	       compra: Compra,
	       comesqDat: ComesqDat},
            compra:compra(EsqCod,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat),
            Tuplas),
    reply_json_dict(Tuplas).
