--- Projeto de Grafo: Serviço de Streaming
Este projeto modela um grafo de conhecimento para um serviço de streaming, com o objetivo de representar usuários, filmes, séries, gêneros, atores e diretores, além de seus relacionamentos.
A estrutura foi projetada para permitir consultas e recomendações com base em preferências e conexões entre os elementos.

--- Estrutura do Grafo

- Nós (Nodes)
- User: representa um usuário do sistema.
- Movie: representa um filme.
- Series: representa uma série.
- Genre: representa um gênero de conteúdo.
- Actor: representa um ator ou atriz.
- Director: representa um diretor ou diretora.

--- Relacionamentos (Edges)
- WATCHED: conecta um User a um Movie ou Series, com uma propriedade rating (nota de avaliação).
- ACTED_IN: conecta um Actor a um Movie ou Series.
- DIRECTED: conecta um Director a um Movie ou Series.
- IN_GENRE: conecta um Movie ou Series a um Genre.

--- Conteúdo
Script Cypher que cria os nós, relacionamentos e constraints no banco de dados Neo4j.
Imagem com o esboço visual do grafo, representando as entidades e conexões.
