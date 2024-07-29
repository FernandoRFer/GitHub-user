# Github

Aplicativo desenvolvido em Flutter que permite aos usuários explorar repositórios do GitHub. Ele oferece autenticação externa via OAuth 2, permitindo que os usuários se conectem às suas contas do GitHub e acessem informações sobre repositórios públicos e privados.

Autenticação via OAuth 2 com Deep Link:

Os usuários podem fazer login no aplicativo usando suas contas do GitHub.
O fluxo de autenticação segue o padrão OAuth 2.0.
Quando o usuário inicia o processo de autenticação, o aplicativo redireciona para a página de autorização do GitHub (via deep link).
Após autorização, o GitHub redireciona de volta ao aplicativo com um código de autorização.

Troca do Código de Autorização por Token de Acesso:

O aplicativo envia o código de autorização para o servidor de autenticação (seu backend).
O servidor troca o código por um token de acesso OAuth 2 válido.
O aplicativo armazena esse token de forma segura.

Exploração de Repositórios:
Após autenticar, os usuários podem navegar por uma lista de repositórios públicos do GitHub.
Cada repositório exibe informações como nome, descrição, linguagem principal e número de estrelas.
reference:
https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps



