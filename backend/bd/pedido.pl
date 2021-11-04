
:- module(
    pedido,
    [
     carrega_tab/1,
        pedido/5,
     insere/5,
    remove/1,
    atualiza/5,
    sincroniza/0
    ]).

:- use_module(library(persistency)).
:- use_module(chave, []).

:- persistent
pedido(
		emiCod: positive_integer,
       emiObsCod:  string,
       emiObs: string,
	   emiDatObs: string,
	   emiUsuCod: string).

%:- initialization((db_attach('tbl_pedido', []),
%               at_halt(db_sync(gc(always))) )).

:- initialization(at_halt(db_sync(gc(always))) ).
carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

:- dynamic pedido/5.

insere(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod):-
	chave:pk(pedido, EmiCod),
    with_mutex(pedido,
    assert_pedido(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)).

remove(EmiCod):-
    with_mutex(pedido,
      retract_pedido(EmiCod,_,_,_,_)).

atualiza(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod):-
    with_mutex(pedido,
               (retractall_pedido(EmiCod,_,_,_,_),
                assert_pedido(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod))).

sincroniza :-
    db_sync(gc(always)).
