{ lib, poetry2nix, python3 }:
let
  drv = poetry2nix.mkPoetryApplication {
    python = python3;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
    src = lib.cleanSource ./.;
    overrides = poetry2nix.overrides.withDefaults
      # This is also in /overrides but repeated for completeness
      (
        self: super: {
          maturin = super.maturin.override {
            preferWheel = true;
          };
        }
      );
  };
  isWheelAttr = drv.passthru.python.pkgs.maturin.src.isWheel or false;
in
  assert isWheelAttr; drv
