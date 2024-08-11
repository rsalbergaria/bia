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