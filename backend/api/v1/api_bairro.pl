:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_json)).

:- use_module(bd(bairro),[]).


api_bairro(get,'',_Pedido):- !,
    envia_tabela_bairro.

api_bairro(get,AtomId,_Pedido):-
    atom_number(AtomId,Id),
    !,
    envia_tupla_bairro(Id).

api_bairro(post,_,Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_bairro(Dados).

api_bairro(put,AtomId,Pedido):-
    atom_number(AtomId,Id),
    http_read_json_dict(Pedido,Dados),!,
    atualiza_tupla_bairro(Dados,Id).

api_bairro(delete,AtomId,_Pedido):-
    atom_number(AtomId,Id),!,
    bairro:remove(Id),
    throw(http_reply(no_content)).

api_bairro(Met,Id,_Pedido):-
    throw(http_reply(method_not_allowed(Met,Id))).

insere_tupla_bairro(_{ baiNom:BaiNom, baiCep: BaiCep, baiNomAbre: BaiNomAbre, baiQtd: BaiQtd}):-
    bairro:insere(BaiCod,BaiNom,BaiCep,BaiNomAbre,BaiQtd)
    -> envia_tupla_bairro(BaiCod)
    ; throw(http_reply(bad_request('Informação Ausente'))).

atualiza_tupla_bairro(_{ baiNom:BaiNom, baiCep: BaiCep, baiNomAbre: BaiNomAbre, baiQtd: BaiQtd},BaiCod):-
    bairro:atualiza(BaiCod,BaiNom,BaiCep,BaiNomAbre,BaiQtd)
    -> envia_tupla_bairro(BaiCod)
    ;  throw(http_reply(not_found(BaiCod))).

envia_tupla_bairro(BaiCod):-
    bairro:bairro(BaiCod,BaiNom,BaiCep,BaiNomAbre,BaiQtd)
    -> reply_json_dict(_{ baiCod:BaiCod, baiNom:BaiNom, baiCep: BaiCep, baiNomAbre: BaiNomAbre, baiQtd: BaiQtd})
    ; throw(http_reply(not_found(BaiCod))).

envia_tabela_bairro:-
    findall(_{ baiCod:BaiCod, baiNom:BaiNom, baiCep: BaiCep, baiNomAbre: BaiNomAbre, baiQtd: BaiQtd},
            bairro:bairro(BaiCod,BaiNom,BaiCep,BaiNomAbre,BaiQtd),
            Tuplas),
    reply_json_dict(Tuplas).


