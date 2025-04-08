# nixos flake

my nixos flake. don't shout at me this is my first time using nix{,os}.

## structure

```
nixos/
├── hosts/
│   └── nixos/
├── modules/
│   ├── system/
│   │   ├── packages/
│   │   │   ├── global.nix
│   │   │   ├── system.nix
│   │   │   └── fonts.nix
│   │   ├── programs/
│   │   └── services/
│   └── users/
│       └── iris/
│           ├── desktop/
│           ├── packages/
│           ├── programs/
│           └── scripts/
├── pkgs/
└── overlays/
```

## usage

i use [github:casey/just](https://github.com/casey/just) for running commands.

```sh
git clone https://github.com/irimoe/flake.git
cd flake
just switch
```

**tip!** check the [`justfile`](justfile) or run `just --list` for more commands!

### common tasks

- `just switch` - apply configuration
- `just build` - build without applying
- `just update` - update flake inputs
- `just gc` - run garbage collection
- `just check` - check flake for errors

## copying

this repository is licensed under the copyleft gnu general public license version 3.0.
all files in this repository are licensed under the same license unless explicitly stated otherwise.
see [COPYING](COPYING) for more information.
