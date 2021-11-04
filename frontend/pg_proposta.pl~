/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).



/* PÃ¡gina de cadastro de bookmark */
cadastroProposta(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Proposta')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Nova Proposta'),
                \form_bookmarkpro
              ]) ]).

form_bookmarkpro -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/propostas' )"),
                action('/api/v1/api_proposta/') ],
              [ \metodo_de_envio('POST'),
                \campo(emiConfig, 'Configuração', text),
                \campo(emiIndJur, 'Ind. Jurídica', text),
                \campo(emiIndFis, 'Ind. Física', text),
                \campo(cliCod, 'Código do cliente', text),
                \campo(emiNom, 'Emissão', text),
                \campo(emiDes, 'Descrição', text),
                \campo(emiTipAber, 'Tipo de abertura', text),
                \campo(emiStatus, 'Status', text),
                \campo(emiPrjNes, 'Necessita projeto', text),
                \campo(emiMtpQtd, 'Quantidade Mtp', text),
                \campo(emiDatAbe, 'Data de abertura', text),
                \campo(emiObsQtd, 'Quantidade de observação', text),
                \campo(emiCtrlCor, 'Cor', text),
                \campo(orcTipo, 'Tipo de Orçamento', text),
                \campo(orcDatReg, 'Data Orçaamento', text),
                \campo(orcSolCod, 'Código Solicitante', text),
                \campo(orcSolNom, 'Nome Solicitante', text),
                \campo(orcSolNro, 'CPF/CNPJ Solicitante', text),
                \campo(orcSolCid, 'Cidade', text),
                \campo(orcSolBai, 'Bairro', text),
                \campo(orcSolLgr, 'Logradouro', text),
                \campo(orcSolCas, 'Numero', text),
                \campo(orcFon1, 'Telefone', text),
                \campo(orcFax, 'Fax', text),
                \campo(orcCel, 'Celular', text),
                \campo(orcFunCod, 'Código do Funcionário', text),
                \campo(orcFunNom, 'Nome', text),
                \campo(orcVlrIm1, 'Valor Imposto', text),
                \campo(orcVlrIpi, 'IPI', text),
                \campo(orcVlrIcms, 'ICMS', text),
                \campo(orcVlrIss, 'ISS', text),
                \campo(orcSumTot, 'Soma total de metros', text),
                \campo(orcSumPer, 'Soma total dos percentuais', text),
                \campo(orcVlrPar, 'Total de metros', text),
                \campo(orcNroPer, 'Percentagem', text),
                \campo(orcTmp, 'Tipo de tempo', text),
                \campo(orcTmpTot, 'Quantidade Tempo', text),
                \campo(emiPrjCod, 'Projetista', text),
                \campo(emiPrjNom, 'Nome', text),
                \campo(emiPrjIni, 'Inicio', text),
                \campo(emiPrjFim, 'Final', text),
                \campo(emiAcaDes, 'Descrição do acabamento', text),
                \campo(emiMtpPro, 'Valor com add metros', text),
                \campo(orcQtdLar, 'Largura', text),
                \campo(orcQtdCom, 'Comprimento', text),
                \campo(orcQtdPro, 'Profundidade', text),
                \campo(orcQtdPer, 'Total de metros', text),
                \campo(orcQtdAdd, 'Quantidade em metros add', text),
                \campo(orcVlrMet, 'Valor do metro', text),
                \campo(emiPagFor, 'Forma de pagamento', text),
                \campo(emiPagQtd, 'Quantidade de parcelas', text),
                \campo(emiPagIni, 'Data Pagamento', text),
                \campo(emiPagFim, 'Data Pagamento', text),
                \campo(emiObsApr, 'Observação do aprovador', text),
                \campo(emiSolOpe, 'Solicitação operacional', text),
                \campo(emiAcaInd, 'Acabamento', text),
                \campo(emiEncado, 'Encerrar', text),
                \campo(emiEncAux, 'Encerrar Definitivo', text),


                \enviar_ou_cancelarpro('/propostas')
              ])).

enviar_ou_cancelarpro(RotaDeRetorno) -->
    html(div([ class('btn-group'), role(group), 'aria-label'('Enviar ou cancelar')],
             [ button([ type(submit),
                        class('btn btn-outline-primary')], 'Enviar'),
               a([ href(RotaDeRetorno),
                   class('ms-3 btn btn-outline-danger')], 'Cancelar')
            ])).


/*
campo(Nome, Titulo, Tipo) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label') ], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome)])
             ] )).
*/


/* PÃ¡gina para ediÃ§Ã£o (alteraÃ§Ã£o) de um bookmark  */

editarProposta(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( proposta:proposta(Id,EmiConfig,EmiIndJur,EmiIndFis,CliCod,EmiNom,EmiDes,EmiTipAber,EmiStatus,EmiPrjNes,EmiMtpQtd,EmiDatAbe,EmiObsQtd,EmiCtrlCor,OrcTipo,OrcDatReg,OrcSolCod,OrcSolNom,OrcSolNro,OrcSolCid,OrcSolBai,OrcSolLgr,OrcSolCas,OrcFon1,OrcFax,OrcCel,OrcFunCod,OrcFunNom,OrcVlrIm1,OrcVlrIpi,OrcVlrIcms,OrcVlrIss,OrcSumTot,OrcSumPer,OrcVlrPar,OrcNroPer,OrcTmp,OrcTmpTot,EmiPrjCod,EmiPrjNom,EmiPrjIni,EmiPrjFim,EmiAcaDes,EmiMtpPro,OrcQtdLar,OrcQtdCom,OrcQtdPro,OrcQtdPer,OrcQtdAdd,OrcVlrMet,EmiPagFor,EmiPagQtd,EmiPagIni,EmiPagFim,EmiObsApr,EmiSolOpe,EmiAcaInd,EmiEncado,EmiEncAux)    ->
    reply_html_page(
        boot5rest,
        [ title('Proposta')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Editar Proposta'),
                \form_bookmarkpro(Id,EmiConfig,EmiIndJur,EmiIndFis,CliCod,EmiNom,EmiDes,EmiTipAber,EmiStatus,EmiPrjNes,EmiMtpQtd,EmiDatAbe,EmiObsQtd,EmiCtrlCor,OrcTipo,OrcDatReg,OrcSolCod,OrcSolNom,OrcSolNro,OrcSolCid,OrcSolBai,OrcSolLgr,OrcSolCas,OrcFon1,OrcFax,OrcCel,OrcFunCod,OrcFunNom,OrcVlrIm1,OrcVlrIpi,OrcVlrIcms,OrcVlrIss,OrcSumTot,OrcSumPer,OrcVlrPar,OrcNroPer,OrcTmp,OrcTmpTot,EmiPrjCod,EmiPrjNom,EmiPrjIni,EmiPrjFim,EmiAcaDes,EmiMtpPro,OrcQtdLar,OrcQtdCom,OrcQtdPro,OrcQtdPer,OrcQtdAdd,OrcVlrMet,EmiPagFor,EmiPagQtd,EmiPagIni,EmiPagFim,EmiObsApr,EmiSolOpe,EmiAcaInd,EmiEncado,EmiEncAux)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkpro(Id,EmiConfig,EmiIndJur,EmiIndFis,CliCod,EmiNom,EmiDes,EmiTipAber,EmiStatus,EmiPrjNes,EmiMtpQtd,EmiDatAbe,EmiObsQtd,EmiCtrlCor,OrcTipo,OrcDatReg,OrcSolCod,OrcSolNom,OrcSolNro,OrcSolCid,OrcSolBai,OrcSolLgr,OrcSolCas,OrcFon1,OrcFax,OrcCel,OrcFunCod,OrcFunNom,OrcVlrIm1,OrcVlrIpi,OrcVlrIcms,OrcVlrIss,OrcSumTot,OrcSumPer,OrcVlrPar,OrcNroPer,OrcTmp,OrcTmpTot,EmiPrjCod,EmiPrjNom,EmiPrjIni,EmiPrjFim,EmiAcaDes,EmiMtpPro,OrcQtdLar,OrcQtdCom,OrcQtdPro,OrcQtdPer,OrcQtdAdd,OrcVlrMet,EmiPagFor,EmiPagQtd,EmiPagIni,EmiPagFim,EmiObsApr,EmiSolOpe,EmiAcaInd,EmiEncado,EmiEncAux) -->
     html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/propostas' )"),
                action('/api/v1/api_proposta/~w' - Id) ],
              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo(emiConfig, 'Configuração', text,EmiConfig),
                \campo(emiIndJur, 'Ind. JurÃ­dica', text,EmiIndJur),
                \campo(emiIndFis, 'Ind. Física', text,EmiIndFis),
                \campo(cliCod, 'Código do cliente', text,CliCod),
                \campo(emiNom, 'Emissão', text,EmiNom),
                \campo(emiDes, 'Descrição', text,EmiDes),
                \campo(emiTipAber, 'Tipo de abertura', text,EmiTipAber),
                \campo(emiStatus, 'Status', text,EmiStatus),
                \campo(emiPrjNes, 'Necessita projeto', text,EmiPrjNes),
                \campo(emiMtpQtd, 'Quantidade Mtp', text,EmiMtpQtd),
                \campo(emiDatAbe, 'Data de abertura', text,EmiDatAbe),
                \campo(emiObsQtd, 'Quantidade de observação', text,EmiObsQtd),
                \campo(emiCtrlCor, 'Cor', text,EmiCtrlCor),
                \campo(orcTipo, 'Tipo de Orçamento', text,OrcTipo),
                \campo(orcDatReg, 'Data Orçaamento', text,OrcDatReg),
                \campo(orcSolCod, 'Código Solicitante', text,OrcSolCod),
                \campo(orcSolNom, 'Nome Solicitante', text,OrcSolNom),
                \campo(orcSolNro, 'CPF/CNPJ Solicitante', text,OrcSolNro),
                \campo(orcSolCid, 'Cidade', text,OrcSolCid),
                \campo(orcSolBai, 'Bairro', text,OrcSolBai),
                \campo(orcSolLgr, 'Logradouro', text,OrcSolLgr),
                \campo(orcSolCas, 'Numero', text,OrcSolCas),
                \campo(orcFon1, 'Telefone', text,OrcFon1),
                \campo(orcFax, 'Fax', text,OrcFax),
                \campo(orcCel, 'Celular', text,OrcCel),
                \campo(orcFunCod, 'Código do Funcionário', text,OrcFunCod),
                \campo(orcFunNom, 'Nome', text,OrcFunNom),
                \campo(orcVlrIm1, 'Valor Imposto', text,OrcVlrIm1),
                \campo(orcVlrIpi, 'IPI', text,OrcVlrIpi),
                \campo(orcVlrIcms, 'ICMS', text,OrcVlrIcms),
                \campo(orcVlrIss, 'ISS', text,OrcVlrIss),
                \campo(orcSumTot, 'Soma total de metros', text,OrcSumTot),
                \campo(orcSumPer, 'Soma total dos percentuais', text,OrcSumPer),
                \campo(orcVlrPar, 'Total de metros', text,OrcVlrPar),
                \campo(orcNroPer, 'Percentagem', text,OrcNroPer),
                \campo(orcTmp, 'Tipo de tempo', text,OrcTmp),
                \campo(orcTmpTot, 'Quantidade Tempo', text,OrcTmpTot),
                \campo(emiPrjCod, 'Projetista', text,EmiPrjCod),
                \campo(emiPrjNom, 'Nome', text,EmiPrjNom),
                \campo(emiPrjIni, 'Inicio', text,EmiPrjIni),
                \campo(emiPrjFim, 'Final', text,EmiPrjFim),
                \campo(emiAcaDes, 'Descrição do acabamento', text,EmiAcaDes),
                \campo(emiMtpPro, 'Valor com add metros', text,EmiMtpPro),
                \campo(orcQtdLar, 'Largura', text,OrcQtdLar),
                \campo(orcQtdCom, 'Comprimento', text,OrcQtdCom),
                \campo(orcQtdPro, 'Profundidade', text,OrcQtdPro),
                \campo(orcQtdPer, 'Total de metros', text,OrcQtdPer),
                \campo(orcQtdAdd, 'Quantidade em metros add', text,OrcQtdAdd),
                \campo(orcVlrMet, 'Valor do metro', text,OrcVlrMet),
                \campo(emiPagFor, 'Forma de pagamento', text,EmiPagFor),
                \campo(emiPagQtd, 'Quantidade de parcelas', text,EmiPagQtd),
                \campo(emiPagIni, 'Data Pagamento', text,EmiPagIni),
                \campo(emiPagFim, 'Data Pagamento', text,EmiPagFim),
                \campo(emiObsApr, 'Observação do aprovador', text,EmiObsApr),
                \campo(emiSolOpe, 'Solicitação operacional', text,EmiSolOpe),
                \campo(emiAcaInd, 'Acabamento', text,EmiAcaInd),
                \campo(emiEncado, 'Encerrar', text,EmiEncado),
                \campo(emiEncAux, 'Encerrar Definitivo', text,EmiEncAux),

                \enviar_ou_cancelarpro('/propostas')
              ])).
/*
campo(Nome, Titulo, Tipo, Valor) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label')], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome), value(Valor)])
             ] )).

campo_nao_editavel(Nome, Titulo, Tipo, Valor) -->
    html(div(class('mb-3 w-25'),
             [ label([ for(Nome), class('form-label')], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome),
                       % name(Nome),%  nÃ£o Ã© para enviar o id
                       value(Valor),
                       readonly ])
             ] )).

metodo_de_envio(Metodo) -->
    html(input([type(hidden), name('_metodo'), value(Metodo)])).
*/
