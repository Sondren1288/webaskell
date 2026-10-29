## Mostly document for future nix flakes or similar

## Run tools
ghcid (works like a --watch flag)
```sh
ghcid --command "cabal repl" --run=main
```
can add `--warnings` or `-W` if there are warnings. Does not launch with warnings by default. 
