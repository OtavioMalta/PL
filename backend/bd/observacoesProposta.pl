
:- module(
    observacoesProposta,
    [
        observacoesProposta/5,
	carrega_tab/1,
	insere/5,
    remove/1,
    atualiza/5,
    sincroniza/0
    ]).

:- use_module(library(persistency)).
:- use_module(chave, []).

:- persistent
observacoesProposta(
		emiCod: positive_integer,
       emiObsCod:  string,
       emiObs: string,
	   emiDatObs: string,
	   emiUsuCod: string).

%:- initialization((db_attach('tbl_observacoesProposta', []),
%               at_halt(db_sync(gc(always))) )).
:- initialization(at_halt(db_sync(gc(always))) ).
carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

:- dynamic observacoesProposta/5.

insere(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod):-
	chave:pk(observacoesProposta, EmiCod),
    with_mutex(observacoesProposta,
    assert_observacoesProposta(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)).

remove(EmiCod):-
    with_mutex(observacoesProposta,
      retract_observacoesProposta(EmiCod,_,_,_,_)).

atualiza(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod):-
    with_mutex(observacoesProposta,
               (retractall_observacoesProposta(EmiCod,_,_,_,_),
                assert_observacoesProposta(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod))).

sincroniza :-
    db_sync(gc(always)).
