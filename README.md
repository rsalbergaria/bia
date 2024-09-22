## Projeto base para o evento Bootcamp Imersão AWS que irei realizar.

### Período do evento: 05 a 11 de Agosto/2024 (Online e ao Vivo às 20h)

[>> Página de Inscrição do evento](https://org.imersaoaws.com.br/github/readme)

#### Para rodar as migrations no container ####
```
docker compose exec server bash -c 'npx sequelize db:create'
docker compose exec server bash -c 'npx sequelize db:migrate'
```

```
git remote add upstream https://github.com/henrylle/bia.git
git fetch upstream
git rebase upstream/main
```