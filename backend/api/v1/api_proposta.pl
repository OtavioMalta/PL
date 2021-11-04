:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_json)).

:- use_module(bd(proposta),[]).


api_proposta(get,'',_Pedido):- !,
    envia_tabelaPro.

api_proposta(get,AtomId,_Pedido):-
    atom_number(AtomId,Id),
    !,
    envia_tuplaPro(Id).

api_proposta(post,_,Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tuplaPro(Dados).

api_proposta(put,AtomId,Pedido):-
    atom_number(AtomId,Id),
    http_read_json_dict(Pedido,Dados),!,
    atualiza_tuplaPro(Dados,Id).

api_proposta(delete,AtomId,_Pedido):-
    atom_number(AtomId,Id),!,
    proposta:remove(Id),
    throw(http_reply(no_content)).

api_proposta(Met,Id,_Pedido):-
    throw(http_reply(method_not_allowed(Met,Id))).

insere_tuplaPro(_{ emiConfig:EmiConfig,emiIndJur:EmiIndJur,emiIndFis:EmiIndFis,cliCod:CliCod,emiNom:EmiNom,emiDes:EmiDes,emiTipAber:EmiTipAber,emiStatus:EmiStatus,emiPrjNes:EmiPrjNes,emiMtpQtd:EmiMtpQtd,emiDatAbe:EmiDatAbe,emiObsQtd:EmiObsQtd,emiCtrlCor:EmiCtrlCor,orcTipo:OrcTipo,orcDatReg:OrcDatReg,orcSolCod:OrcSolCod,orcSolNom:OrcSolNom,orcSolNro:OrcSolNro,orcSolCid:OrcSolCid,orcSolBai:OrcSolBai,orcSolLgr:OrcSolLgr,orcSolCas:OrcSolCas,orcFon1:OrcFon1,orcFax:OrcFax,orcCel:OrcCel,orcFunCod:OrcFunCod,orcFunNom:OrcFunNom,orcVlrIm1:OrcVlrIm1,orcVlrIpi:OrcVlrIpi,orcVlrIcms:OrcVlrIcms,orcVlrIss:OrcVlrIss,orcSumTot:OrcSumTot,orcSumPer:OrcSumPer,orcVlrPar:OrcVlrPar,orcNroPer:OrcNroPer,orcTmp:OrcTmp,orcTmpTot:OrcTmpTot,emiPrjCod:EmiPrjCod,emiPrjNom:EmiPrjNom,emiPrjIni:EmiPrjIni,emiPrjFim:EmiPrjFim,emiAcaDes:EmiAcaDes,emiMtpPro:EmiMtpPro,orcQtdLar:OrcQtdLar,orcQtdCom:OrcQtdCom,orcQtdPro:OrcQtdPro,orcQtdPer:OrcQtdPer,orcQtdAdd:OrcQtdAdd,orcVlrMet:OrcVlrMet,emiPagFor:EmiPagFor,emiPagQtd:EmiPagQtd,emiPagIni:EmiPagIni,emiPagFim:EmiPagFim,emiObsApr:EmiObsApr,emiSolOpe:EmiSolOpe,emiAcaInd:EmiAcaInd,emiEncado:EmiEncado,emiEncAux:EmiEncAux}):-
    proposta:insere(EmiCod,EmiConfig,EmiIndJur,EmiIndFis,CliCod,EmiNom,EmiDes,EmiTipAber,EmiStatus,EmiPrjNes,EmiMtpQtd,EmiDatAbe,EmiObsQtd,EmiCtrlCor,OrcTipo,OrcDatReg,OrcSolCod,OrcSolNom,OrcSolNro,OrcSolCid,OrcSolBai,OrcSolLgr,OrcSolCas,OrcFon1,OrcFax,OrcCel,OrcFunCod,OrcFunNom,OrcVlrIm1,OrcVlrIpi,OrcVlrIcms,OrcVlrIss,OrcSumTot,OrcSumPer,OrcVlrPar,OrcNroPer,OrcTmp,OrcTmpTot,EmiPrjCod,EmiPrjNom,EmiPrjIni,EmiPrjFim,EmiAcaDes,EmiMtpPro,OrcQtdLar,OrcQtdCom,OrcQtdPro,OrcQtdPer,OrcQtdAdd,OrcVlrMet,EmiPagFor,EmiPagQtd,EmiPagIni,EmiPagFim,EmiObsApr,EmiSolOpe,EmiAcaInd,EmiEncado,EmiEncAux)
    -> envia_tuplaPro(EmiCod)
    ; throw(http_reply(bad_request('Informação Ausente'))).

atualiza_tuplaPro(_{ emiConfig:EmiConfig,emiIndJur:EmiIndJur,emiIndFis:EmiIndFis,cliCod:CliCod,emiNom:EmiNom,emiDes:EmiDes,emiTipAber:EmiTipAber,emiStatus:EmiStatus,emiPrjNes:EmiPrjNes,emiMtpQtd:EmiMtpQtd,emiDatAbe:EmiDatAbe,emiObsQtd:EmiObsQtd,emiCtrlCor:EmiCtrlCor,orcTipo:OrcTipo,orcDatReg:OrcDatReg,orcSolCod:OrcSolCod,orcSolNom:OrcSolNom,orcSolNro:OrcSolNro,orcSolCid:OrcSolCid,orcSolBai:OrcSolBai,orcSolLgr:OrcSolLgr,orcSolCas:OrcSolCas,orcFon1:OrcFon1,orcFax:OrcFax,orcCel:OrcCel,orcFunCod:OrcFunCod,orcFunNom:OrcFunNom,orcVlrIm1:OrcVlrIm1,orcVlrIpi:OrcVlrIpi,orcVlrIcms:OrcVlrIcms,orcVlrIss:OrcVlrIss,orcSumTot:OrcSumTot,orcSumPer:OrcSumPer,orcVlrPar:OrcVlrPar,orcNroPer:OrcNroPer,orcTmp:OrcTmp,orcTmpTot:OrcTmpTot,emiPrjCod:EmiPrjCod,emiPrjNom:EmiPrjNom,emiPrjIni:EmiPrjIni,emiPrjFim:EmiPrjFim,emiAcaDes:EmiAcaDes,emiMtpPro:EmiMtpPro,orcQtdLar:OrcQtdLar,orcQtdCom:OrcQtdCom,orcQtdPro:OrcQtdPro,orcQtdPer:OrcQtdPer,orcQtdAdd:OrcQtdAdd,orcVlrMet:OrcVlrMet,emiPagFor:EmiPagFor,emiPagQtd:EmiPagQtd,emiPagIni:EmiPagIni,emiPagFim:EmiPagFim,emiObsApr:EmiObsApr,emiSolOpe:EmiSolOpe,emiAcaInd:EmiAcaInd,emiEncado:EmiEncado,emiEncAux:EmiEncAux},EmiCod):-
    proposta:atualiza(EmiCod,EmiConfig,EmiIndJur,EmiIndFis,CliCod,EmiNom,EmiDes,EmiTipAber,EmiStatus,EmiPrjNes,EmiMtpQtd,EmiDatAbe,EmiObsQtd,EmiCtrlCor,OrcTipo,OrcDatReg,OrcSolCod,OrcSolNom,OrcSolNro,OrcSolCid,OrcSolBai,OrcSolLgr,OrcSolCas,OrcFon1,OrcFax,OrcCel,OrcFunCod,OrcFunNom,OrcVlrIm1,OrcVlrIpi,OrcVlrIcms,OrcVlrIss,OrcSumTot,OrcSumPer,OrcVlrPar,OrcNroPer,OrcTmp,OrcTmpTot,EmiPrjCod,EmiPrjNom,EmiPrjIni,EmiPrjFim,EmiAcaDes,EmiMtpPro,OrcQtdLar,OrcQtdCom,OrcQtdPro,OrcQtdPer,OrcQtdAdd,OrcVlrMet,EmiPagFor,EmiPagQtd,EmiPagIni,EmiPagFim,EmiObsApr,EmiSolOpe,EmiAcaInd,EmiEncado,EmiEncAux)
    -> envia_tuplaPro(EmiCod)
    ;  throw(http_reply(not_found(EmiCod))).

envia_tuplaPro(EmiCod):-
    proposta:proposta(EmiCod,EmiConfig,EmiIndJur,EmiIndFis,CliCod,EmiNom,EmiDes,EmiTipAber,EmiStatus,EmiPrjNes,EmiMtpQtd,EmiDatAbe,EmiObsQtd,EmiCtrlCor,OrcTipo,OrcDatReg,OrcSolCod,OrcSolNom,OrcSolNro,OrcSolCid,OrcSolBai,OrcSolLgr,OrcSolCas,OrcFon1,OrcFax,OrcCel,OrcFunCod,OrcFunNom,OrcVlrIm1,OrcVlrIpi,OrcVlrIcms,OrcVlrIss,OrcSumTot,OrcSumPer,OrcVlrPar,OrcNroPer,OrcTmp,OrcTmpTot,EmiPrjCod,EmiPrjNom,EmiPrjIni,EmiPrjFim,EmiAcaDes,EmiMtpPro,OrcQtdLar,OrcQtdCom,OrcQtdPro,OrcQtdPer,OrcQtdAdd,OrcVlrMet,EmiPagFor,EmiPagQtd,EmiPagIni,EmiPagFim,EmiObsApr,EmiSolOpe,EmiAcaInd,EmiEncado,EmiEncAux)
    -> reply_json_dict(_{emiCod:EmiCod,emiConfig:EmiConfig,emiIndJur:EmiIndJur,emiIndFis:EmiIndFis,cliCod:CliCod,emiNom:EmiNom,emiDes:EmiDes,emiTipAber:EmiTipAber,emiStatus:EmiStatus,emiPrjNes:EmiPrjNes,emiMtpQtd:EmiMtpQtd,emiDatAbe:EmiDatAbe,emiObsQtd:EmiObsQtd,emiCtrlCor:EmiCtrlCor,orcTipo:OrcTipo,orcDatReg:OrcDatReg,orcSolCod:OrcSolCod,orcSolNom:OrcSolNom,orcSolNro:OrcSolNro,orcSolCid:OrcSolCid,orcSolBai:OrcSolBai,orcSolLgr:OrcSolLgr,orcSolCas:OrcSolCas,orcFon1:OrcFon1,orcFax:OrcFax,orcCel:OrcCel,orcFunCod:OrcFunCod,orcFunNom:OrcFunNom,orcVlrIm1:OrcVlrIm1,orcVlrIpi:OrcVlrIpi,orcVlrIcms:OrcVlrIcms,orcVlrIss:OrcVlrIss,orcSumTot:OrcSumTot,orcSumPer:OrcSumPer,orcVlrPar:OrcVlrPar,orcNroPer:OrcNroPer,orcTmp:OrcTmp,orcTmpTot:OrcTmpTot,emiPrjCod:EmiPrjCod,emiPrjNom:EmiPrjNom,emiPrjIni:EmiPrjIni,emiPrjFim:EmiPrjFim,emiAcaDes:EmiAcaDes,emiMtpPro:EmiMtpPro,orcQtdLar:OrcQtdLar,orcQtdCom:OrcQtdCom,orcQtdPro:OrcQtdPro,orcQtdPer:OrcQtdPer,orcQtdAdd:OrcQtdAdd,orcVlrMet:OrcVlrMet,emiPagFor:EmiPagFor,emiPagQtd:EmiPagQtd,emiPagIni:EmiPagIni,emiPagFim:EmiPagFim,emiObsApr:EmiObsApr,emiSolOpe:EmiSolOpe,emiAcaInd:EmiAcaInd,emiEncado:EmiEncado,emiEncAux:EmiEncAux})
    ; throw(http_reply(not_found(EmiCod))).

envia_tabelaPro:-
    findall(_{ emiCod:EmiCod,emiConfig:EmiConfig,emiIndJur:EmiIndJur,emiIndFis:EmiIndFis,cliCod:CliCod,emiNom:EmiNom,emiDes:EmiDes,emiTipAber:EmiTipAber,emiStatus:EmiStatus,emiPrjNes:EmiPrjNes,emiMtpQtd:EmiMtpQtd,emiDatAbe:EmiDatAbe,emiObsQtd:EmiObsQtd,emiCtrlCor:EmiCtrlCor,orcTipo:OrcTipo,orcDatReg:OrcDatReg,orcSolCod:OrcSolCod,orcSolNom:OrcSolNom,orcSolNro:OrcSolNro,orcSolCid:OrcSolCid,orcSolBai:OrcSolBai,orcSolLgr:OrcSolLgr,orcSolCas:OrcSolCas,orcFon1:OrcFon1,orcFax:OrcFax,orcCel:OrcCel,orcFunCod:OrcFunCod,orcFunNom:OrcFunNom,orcVlrIm1:OrcVlrIm1,orcVlrIpi:OrcVlrIpi,orcVlrIcms:OrcVlrIcms,orcVlrIss:OrcVlrIss,orcSumTot:OrcSumTot,orcSumPer:OrcSumPer,orcVlrPar:OrcVlrPar,orcNroPer:OrcNroPer,orcTmp:OrcTmp,orcTmpTot:OrcTmpTot,emiPrjCod:EmiPrjCod,emiPrjNom:EmiPrjNom,emiPrjIni:EmiPrjIni,emiPrjFim:EmiPrjFim,emiAcaDes:EmiAcaDes,emiMtpPro:EmiMtpPro,orcQtdLar:OrcQtdLar,orcQtdCom:OrcQtdCom,orcQtdPro:OrcQtdPro,orcQtdPer:OrcQtdPer,orcQtdAdd:OrcQtdAdd,orcVlrMet:OrcVlrMet,emiPagFor:EmiPagFor,emiPagQtd:EmiPagQtd,emiPagIni:EmiPagIni,emiPagFim:EmiPagFim,emiObsApr:EmiObsApr,emiSolOpe:EmiSolOpe,emiAcaInd:EmiAcaInd,emiEncado:EmiEncado,emiEncAux:EmiEncAux},
            proposta:proposta(emiCod:EmiCod,emiConfig:EmiConfig,emiIndJur:EmiIndJur,emiIndFis:EmiIndFis,cliCod:CliCod,emiNom:EmiNom,emiDes:EmiDes,emiTipAber:EmiTipAber,emiStatus:EmiStatus,emiPrjNes:EmiPrjNes,emiMtpQtd:EmiMtpQtd,emiDatAbe:EmiDatAbe,emiObsQtd:EmiObsQtd,emiCtrlCor:EmiCtrlCor,orcTipo:OrcTipo,orcDatReg:OrcDatReg,orcSolCod:OrcSolCod,orcSolNom:OrcSolNom,orcSolNro:OrcSolNro,orcSolCid:OrcSolCid,orcSolBai:OrcSolBai,orcSolLgr:OrcSolLgr,orcSolCas:OrcSolCas,orcFon1:OrcFon1,orcFax:OrcFax,orcCel:OrcCel,orcFunCod:OrcFunCod,orcFumNom:OrcFunNom,orcVlrIm1:OrcVlrIm1,orcVlrIpi:OrcVlrIpi,orcVlrIcms:OrcVlrIcms,orcVlrIss:OrcVlrIss,orcSumTot:OrcSumTot,orcSumPer:OrcSumPer,orcVlrPar:OrcVlrPar,orcNroPer:OrcNroPer,orcTmp:OrcTmp,orcTmpTot:OrcTmpTot,emiPrjCod:EmiPrjCod,emiPrjNom:EmiPrjNom,emiPrjIni:EmiPrjIni,emiPrjFim:EmiPrjFim,emiAcaDes:EmiAcaDes,emiMtpPro:EmiMtpPro,orcQtdLar:OrcQtdLar,orcQtdCom:OrcQtdCom,orcQtdPro:OrcQtdPro,orcQtdPer:OrcQtdPer,orcQtdAdd:OrcQtdAdd,orcVlrMet:OrcVlrMet,emiPagFor:EmiPagFor,emiPagQtd:EmiPagQtd,emiPagIni:EmiPagIni,emiPagFim:EmiPagFim,emiObsApr:EmiObsApr,emiSolOpe:EmiSolOpe,emiAcaInd:EmiAcaInd,emiEncado:EmiEncado,emiEncAux:EmiEncAux),
            Tuplas),
    reply_json_dict(Tuplas).


