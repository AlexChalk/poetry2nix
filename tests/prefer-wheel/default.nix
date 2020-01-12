{ lib, poetry2nix, python3 }:

poetry2nix.mkPoetryApplication {
  python = python3;
  pyproject = ./pyproject.toml;
  poetrylock = ./poetry.lock;
  src = lib.cleanSource ./.;
  overrides = [
    poetry2nix.defaultPoetryOverrides
    # This is also in overrides.nix but repeated for completeness
    (
      self: super: {
        maturin = super.maturin.override {
          preferWheel = true;
        };
      }
    )

  ];
}
