{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule (finalAttrs: {
  pname = "dash0";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "dash0hq";
    repo = "dash0-cli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-WUX7yQldYHMTMPlhJOwvm9HjsrwBNgIv7ms3tGAqQdY=";
  };

  ldflags = [
    "-s"
    "-w"
    "-X main.version=v${finalAttrs.version} -X main.date=0000-00-00"
  ];

  vendorHash = "sha256-sDOdXubL8v3683u1T5nuavR2cgCUq2D44eAepoLDbJE=";
})
