# Ajout d'un fix sur un vieux commit ici un commit situé à 4 commits

```sh
git add .
git commit --fixup HEAD~4
git rebase -i --autosquash HEAD~4
```
