:- module(
       compra,
       [
        carrega_tab/1,
        compra/9,
        insere/9,
        remove/1,
        atualiza/9,
        sincroniza/0
       ]).

:- use_module(library(persistency)).
:- use_module(chave, []).

:- persistent
    compra(esqCod: positive_integer,
           baxEsqQtd:string,
           baxa: string,
           baxEsqPdd: string,
           baxEsqDat: string,
           separador: string,
           comEsqQtd: string,
           compra: string,
           comesqDat: string).

%:- initialization(db_attach('tbl_compra.pl',[])).
:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

:- dynamic compra/9.

insere(EsqCod,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat):-
    chave:pk(compra, EsqCod),
    with_mutex(compra,
    assert_compra(EsqCod,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat)).

remove(EsqCod):-
    with_mutex(compra,
      retract_compra(EsqCod,_BaxEsqQtd,_Baxa,_BaxEsqPdd,_BaxEsqDat,_Separador,_ComEsqQtd,_Compra,_ComesqDat)).

atualiza(EsqCod,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat):-
    with_mutex(compra,
              (retractall_compra(EsqCod,_BaxEsqQtd,_Baxa,_BaxEsqPdd,_BaxEsqDat,_Separador,_ComEsqQtd,_Compra,_ComesqDat),
                assert_compra(EsqCod,BaxEsqQtd,Baxa,BaxEsqPdd,BaxEsqDat,Separador,ComEsqQtd,Compra,ComesqDat)
              )
               ).

sincroniza :-
    db_sync(gc(always)).


