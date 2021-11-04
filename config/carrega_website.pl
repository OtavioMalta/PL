% Configuração do servidor


% Carrega o servidor e as rotas

:- load_files([ servidor,
                rotas
              ],
              [ silent(true),
                if(not_loaded) ]).

% Inicializa o servidor para ouvir a porta 9000
:- initialization( servidor(8000) ).


% Carrega o frontend

:- load_files([ gabarito(bootstrap5),  % gabarito usando Bootstrap 5
                gabarito(boot5rest),   % Bootstrap 5 com API REST
                frontend(pg_bairro),
                frontend(pg_entrada),
                frontend(pg_compra),
                frontend(pg_bookmark),
                frontend(pag_bairro),
                frontend(pag_compra),
                frontend(pg_estado),
                frontend(pag_estado),
                frontend(pg_observacoesProposta),
                frontend(pag_observacoesProposta),
                frontend(pg_pedido),
                frontend(pag_pedido),
                frontend(pg_pessoa),
                frontend(pag_pessoa),
                frontend(pg_funcionario),
                frontend(pag_funcionario),
                frontend(pg_proposta),
                frontend(pag_proposta)


              ],
              [ silent(true),
                if(not_loaded) ]).


% Carrega o backend

:- load_files([
                api1(api_bairro),
                api1(api_compra),
                api1(api_bookmark),
                api1(api_estado),
                api1(api_observacoesProposta),
                api1(api_pedido),
                api1(api_pessoa),
                api1(api_funcionario),
                api1(api_proposta)


              ],
              [ silent(true),
                if(not_loaded),
                imports([]) ]).
