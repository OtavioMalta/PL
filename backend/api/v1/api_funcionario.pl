:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_json)).

:- use_module(bd(funcionario),[]).


api_funcionario(get,'',_Pedido):- !,
    envia_tabelaFun.

api_funcionario(get,AtomId,_Pedido):-
    atom_number(AtomId,Id),
    !,
    envia_tuplaFun(Id).

api_funcionario(post,_,Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tuplaFun(Dados).

api_funcionario(put,AtomId,Pedido):-
    atom_number(AtomId,Id),
    http_read_json_dict(Pedido,Dados),!,
    atualiza_tuplaFun(Dados,Id).

api_funcionario(delete,AtomId,_Pedido):-
    atom_number(AtomId,Id),!,
    funcionario:remove(Id),
    throw(http_reply(no_content)).

api_funcionario(Met,Id,_Pedido):-
    throw(http_reply(method_not_allowed(Met,Id))).

insere_tuplaFun(_{ funNome:FunNome,funCpf:FunCpf,funLgr:FunLgr,funSexo:FunSexo,funCid:FunCid,funEst:FunEst,funFon:FunFon,funEmail:FunEmail}):-
    funcionario:insere(FunCod,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail)
    -> envia_tuplaFun(FunCod)
    ; throw(http_reply(bad_request('Informação Ausente'))).

atualiza_tuplaFun(_{ funNome:FunNome,funCpf:FunCpf,funLgr:FunLgr,funSexo:FunSexo,funCid:FunCid,funEst:FunEst,funFon:FunFon,funEmail:FunEmail},FunCod):-
    funcionario:atualiza(FunCod,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail)
    -> envia_tuplaFun(FunCod)
    ;  throw(http_reply(not_found(FunCod))).

envia_tuplaFun(FunCod):-
    funcionario:funcionario(FunCod,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail)
    -> reply_json_dict(_{ funCod:FunCod,funNome:FunNome,funCpf:FunCpf,funLgr:FunLgr,funSexo:FunSexo,funCid:FunCid,funEst:FunEst,funFon:FunFon,funEmail:FunEmail})
    ; throw(http_reply(not_found(FunCod))).

envia_tabelaFun:-
    findall(_{ funCod:FunCod,funNome:FunNome,funCpf:FunCpf,funLgr:FunLgr,funSexo:FunSexo,funCid:FunCid,funEst:FunEst,funFon:FunFon,funEmail:FunEmail},
            funcionario:funcionario(FunCod,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail),
            Tuplas),
    reply_json_dict(Tuplas).


