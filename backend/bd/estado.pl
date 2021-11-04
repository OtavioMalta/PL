:- module(
    estado,
    [
	carrega_tab/1,
	estado/3,
	insere/3,
    remove/1,
    atualiza/3,
    sincroniza/0
    ]).

:- use_module(library(persistency)).
:- use_module(chave, []).

:- persistent
		estado(estCod: positive_integer,
                       estNom: string,
                       estQtd:string).

%:- initialization((db_attach('tbl_estado.pl', []),
%               at_halt(db_sync(gc(always))) )).
%:- initialization(db_attach('tbl_estado.pl',[])).
:- initialization(at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

:- dynamic estado/3.

insere(EstCod,EstNom,EstQtd):-
	chave:pk(estado, EstCod),
    with_mutex(estado,
    assert_estado(EstCod,EstNom,EstQtd)).

remove(EstCod):-
    with_mutex(estado,
      retract_estado(EstCod,_EstNom,_EstQtd)).

atualiza(EstCod,EstNom,EstQtd):-
    with_mutex(estado,
               (retractall_estado(EstCod,_EstNom,_EstQtd),
                assert_estado(EstCod,EstNom,EstQtd))).

sincroniza :-
    db_sync(gc(always)).
