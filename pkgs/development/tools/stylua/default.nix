{ lib
, rustPlatform
, fetchFromGitHub
  # lua54 implies lua52/lua53
, features ? [ "lua54" "luau" ]
}:

rustPlatform.buildRustPackage rec {
  pname = "stylua";
  version = "0.15.0";

  src = fetchFromGitHub {
    owner = "johnnymorganz";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-x4/DmFi/6bIQVn8sfSFEOJIv4Zd/3oHKXbrd6yIsSYU=";
  };

  cargoSha256 = "sha256-lY18so+uG3yri18zd29B479nl0l1C0F1mw+sPrccRQs=";

  # remove cargo config so it can find the linker on aarch64-unknown-linux-gnu
  postPatch = ''
    rm .cargo/config.toml
  '';

  buildFeatures = features;

  meta = with lib; {
    description = "An opinionated Lua code formatter";
    homepage = "https://github.com/johnnymorganz/stylua";
    changelog = "https://github.com/johnnymorganz/stylua/blob/v${version}/CHANGELOG.md";
    license = licenses.mpl20;
    maintainers = with maintainers; [ figsoda ];
  };
}
