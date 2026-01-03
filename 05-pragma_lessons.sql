PRAGMA pragma_list; -- Mostra uma lista com todas as opções.
PRAGMA table_list; -- Mostra uma lista com todas as tabelas do banco.
PRAGMA function_list; -- Mostra todas as funções dispoiveis.
PRAGMA page_size; -- Mostra o tamanho da página. (Dá para modificar)
PRAGMA page_count; -- Mostra a quantidade de páginas do banco de acordo com os dados gravados.
PRAGMA foreign_keys; -- Mostra se as foreign keys estão ativas. (Pode ser alterado com o comando PRAGMA foreign_keys = 1, (valores podem ser 0, 1, ON, OFF))
PRAGMA journal_mode; -- Para web é sempre bom deixar no modo WAL. (Permite mais leituras consecutivas)
PRAGMA synchronous; -- Quando se usa o journal_mode = WAL é recomendado deixar o synchronous = NORMAL.
PRAGMA busy_timeout; -- Tempo que o SQLite espera para ocorrer uma ação.
PRAGMA cache_size; -- Tamanho do cache do banco, valores positivos multiplicam o tamanho da página.
PRAGMA temp_store; -- Onde indicies e tabelas temporárias devem ser armazenadas.
PRAGMA analysis_limit = 1000; --limita o número de linhas.
PRAGMA optimize = 0x10002; -- Início da conexão.
PRAGMA optimize; -- Rodar uma vez por dia.
VACUUM; -- Recria o banco de dados, limpando espaçoes vazios.