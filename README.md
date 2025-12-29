# SQLite Exercício 01
- Crie as tabelas: `produtos`, `clientes` e `compras`.
- Nenhuma coluna da tabela pode ser nula.
- Defina o tipo de dado de cada coluna (INTEGER ou TEXT).
- A tabela produtos deve ter as colunas `id`, `nome`, `preco`
- A tabela clientes deve ter as colunas `id`, `nome`, `email`
- A tabela compras deve ter as colunas `id`, `cliente_id`, `produto_id`, `data`

**Insira os seguintes dados na tabela produtos:**
1. Notebook, 1000
2. Smartphone, 500
3. Tablet, 300

**Insira os seguintes dados na tabela clientes:**
1. Maria, maria@email.com
2. João, joao@email.com

**Insira os seguintes dados na tabela compras:**
1. João comprou o Notebook no dia 2049-01-01
2. Maria comprou o Smartphone no dia 2049-01-02
3. João comprou o Tablet no dia 2049-01-03

**Tarefas**
- [x] Selecione todos os dados da tabela produtos.
- [x] Selecione apenas o nome de todos os produtos que custam mais que 400.
- [x] Selecione todos os itens comprados por João.

# Modelagem Exercício 02
Crie possíveis tabelas para os JSON's abaixo.

Defina os tipos de dados, chaves primárias e estrangeiras, relacionamentos entre as tabelas e as restrições necessárias.
```
Considerações:

- Use STRICT.

- CURRENT_TIMESTAMP retorna a data e hora atual.

- PRIMARY KEY (id1, id2) define uma chave primária composta.

- O SLUG do curso precisa ser único
/api/javascript-basico

- O SLUG da aula precisa ser único em relação ao curso.
/api/javascript-basico/variaveis-let-const

- Se o usuário for deletado, as aulas concluídas e certificados desse usuário também devem ser removidas.

- O campo "free" na tabela de aulas deve ser um booleano.

```
`Users`
```json
{
  "id": 42,
  "name": "André",
  "password": "senha123",
  "email": "andre@email.com",
  "created": "2049-06-14 12:34:56"
}
```
`Courses`
```json
{
  "id": 1,
  "slug": "javascript-basico",
  "title": "JavaScript Básico",
  "description": "Aprenda os fundamentos da linguagem JavaScript.",
  "aulas": 20,
  "horas": 5,
  "created": "2049-06-14 12:34:56"
}
```
`Lessons`
```json
{
  "id": 101,
  "course_id": 1,
  "slug": "variaveis-let-const",
  "title": "Variáveis: let e const",
  "materia": "Fundamentos",
  "materia_slug": "fundamentos",
  "seconds": 480,
  "video": "variaveis.mp4",
  "description": "Entenda a diferença entre let, const e var.",
  "lesson_order": 3,
  "free": 1,
  "created": "2049-06-14 12:35:10"
}
```
`Lessons Completed`
```json
{
  "user_id": 42,
  "course_id": 1,
  "lesson_id": 101,
  "completed": "2049-06-15 08:20:05"
}
```
`Certificates`
```json
{
  "id": "aq32scsqd",
  "user_id": 42,
  "course_id": 1,
  "completed": "2049-06-15 09:10:00"
}
```