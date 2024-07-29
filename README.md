## Projeto base para o evento Bootcamp Imersão AWS que irei realizar.

### Período do evento: 03 a 09 de Junho/2024 (Online e ao Vivo às 20h)

[>> Página de Inscrição do evento](https://org.imersaoaws.com.br/github/readme)

#### Para rodar as migrations no container ####
```
docker compose exec server bash -c 'npx sequelize db:create'
docker compose exec server bash -c 'npx sequelize db:migrate'
```
#Deploy da aula Imersão AWS PRO

### Rebase Project ###

- git remote add upstream https://github.com/henrylle/bia
- git fetch upstream
- git checkout main
- git rebase upstream/main

Lidar com conflitos se houver:

git add .
git rebase --continue

Forçar o push

git push -f origin main