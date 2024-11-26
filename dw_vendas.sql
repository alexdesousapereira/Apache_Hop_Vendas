CREATE TABLE "dproduto" (
  "cdproduto" integer PRIMARY KEY,
  "custo_unitario" numeric(15,2),
  "fornecedor" varchar(20),
  "grupo_produto" varchar(20),
  "linha_produto" varchar(10),
  "url" varchar(200)
);

CREATE TABLE "dvendedor" (
  "cdvendedor" integer PRIMARY KEY,
  "vendedor" varchar(20),
  "equipe_vendas" varchar(14),
  "foto" varchar(200)
);

CREATE TABLE "fmetas" (
  "Data" timestamp PRIMARY KEY,
  "cd_vendedor" integer,
  "meta_faturamento" numeric(18,2),
  "meta_margem_bruta" numeric(18,2),
  "meta_notas_emitidas" numeric(18,2)
);

CREATE TABLE "fvendas" (
  "Data" timestamp,
  "nfe" numeric,
  "cd_produto" integer,
  "cd_vendedor" integer,
  "qtd_itens" integer,
  "preco_unitario" numeric(20,2),
  "valor_venda" numeric(18,2),
  PRIMARY KEY ("Data", "nfe", "cd_produto", "cd_vendedor")
);
