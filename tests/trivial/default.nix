{ lib, poetry2nix, python3 }:

poetry2nix.mkPoetryApplication {
  python = python3;
  pyproject = ./pyproject.toml;
  poetrylock = ./poetry.lock;
  src = lib.cleanSource ./.;

  overrides = [
    poetry2nix.defaultPoetryOverrides
    (
      self: super: {
        maturin = (builtins.trace (lib.functionArgs super.maturin.override) super.maturin.override) {
          preferWheel = true;
        };
      }
    )

  ];

}
