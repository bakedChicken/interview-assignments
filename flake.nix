{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];

      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem =
        { pkgs, lib, system, ... }:
        let
          # The Android SDK is unfree and needs its license accepted.
          pkgs' = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              android_sdk.accept_license = true;
            };
          };

          # Every JavaScript project here predates Node 18; pin one LTS for all of them.
          nodejs = pkgs.nodejs_22;

          # tinkoff-homeworks, tinkoff-fintech-converter-android-app and
          # yandex-school/android-app use AGP 3.1-3.3, which needs JDK 8 and SDK 27/28.
          androidSdk =
            (pkgs'.androidenv.composeAndroidPackages {
              platformVersions = [
                "27"
                "28"
              ];
              buildToolsVersions = [ "28.0.3" ];
              includeEmulator = false;
              includeNDK = false;
            }).androidsdk;

          android = {
            languages.java = {
              enable = true;
              jdk.package = pkgs.jdk8;
            };
            languages.kotlin.enable = true;

            env = {
              ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
              ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            };

            packages = [ androidSdk ];
          };

          node = {
            languages.javascript = {
              enable = true;
              package = nodejs;
              npm.enable = true;
              yarn.enable = true;
            };
          };
        in
        {
          formatter = pkgs.nixfmt-tree;

          packages.gamestats = (pkgs.buildGoModule.override { go = pkgs.go_1_27; }) {
            pname = "gamestats";
            version = "0.1.0";
            src = ./kontur-game-stats/gamestats;
            env.CGO_ENABLED = 1;

            vendorHash = "sha256-IUyZTlMqht5sx010M3kc96okTBsRrL1e+6m1VVWvK0k=";
          };

          packages.modernized-server = pkgs.buildDotnetModule {
            pname = "kontur-gamestats-server";
            version = "0.1.0";
            src = ./kontur-game-stats/Kontur.GameStats.Modern;
            projectFile = "Server/Server.csproj";
            nugetDeps = ./kontur-game-stats/Kontur.GameStats.Modern/deps.json;
            dotnet-sdk = pkgs.dotnet-sdk_10;
            dotnet-runtime = pkgs.dotnet-aspnetcore_10;
            meta.mainProgram = "Server";
          };

          packages.modernized-data-generator = pkgs.buildDotnetModule {
            pname = "kontur-gamestats-data-generator";
            version = "0.1.0";
            src = ./kontur-game-stats/Kontur.GameStats.Modern;
            projectFile = "DataGenerator/DataGenerator.csproj";
            nugetDeps = ./kontur-game-stats/Kontur.GameStats.Modern/deps.json;
            dotnet-sdk = pkgs.dotnet-sdk_10;
            dotnet-runtime = pkgs.dotnet-aspnetcore_10;
            executables = [ "DataGenerator" ];
            meta.mainProgram = "DataGenerator";
          };

          devenv.shells.default = {
            enterShell = ''
              echo "Welcome to the interview assignments monorepo!"
              echo "Project shells: gamestats modernized android yandex-school ios node n26 news-aggregator contest"
            '';

            languages.nix.enable = true;

            packages = with pkgs; [
              go-swagger
            ];

            processes = {
              openapi.exec = ''swagger serve "$(git rev-parse --show-toplevel)/kontur-game-stats/openapi.yaml"'';
            };
          };

          devenv.shells.modernized = {
            enterShell = ''
              echo "Welcome to the .NET shell!"
              dotnet --version
            '';

            languages.dotnet = {
              enable = true;
              package = pkgs.dotnet-sdk_10;
            };
          };

          devenv.shells.gamestats = {
            enterShell = ''
              echo "Welcome to the Go shell!"
              go version
              sqlite3 --version
            '';

            languages.go.enable = true;
            languages.go.package = pkgs.go_1_27;

            packages = with pkgs; [
              sqlite
            ];
          };

          devenv.shells.android = {
            imports = [
              android
            ];

            enterShell = ''
              echo "Welcome to the Android shell! Build with ./gradlew assembleDebug"
              java -version
            '';
          };

          devenv.shells.yandex-school = {
            imports = [
              android
              node
            ];

            enterShell = ''
              echo "Welcome to the Yandex School shell! Run the mock server with: devenv up"
            '';

            processes.mock-server.exec = ''
              cd "$(git rev-parse --show-toplevel)/yandex-school/mock-server"
              yarn install --frozen-lockfile
              yarn start
            '';
          };

          devenv.shells.ios = {
            enterShell = ''
              echo "Welcome to the iOS shell! Xcode itself comes from the system; run pod install first."
            '';

            packages = lib.optionals pkgs.stdenv.hostPlatform.isDarwin (
              with pkgs;
              [
                cocoapods
                swiftlint
                swiftformat
              ]
            );
          };

          devenv.shells.node = {
            imports = [
              node
            ];

            enterShell = ''
              echo "Welcome to the Node.js shell!"
              node --version
            '';
          };

          devenv.shells.n26 = {
            imports = [
              node
            ];

            enterShell = ''
              echo "Welcome to the N26 shell! Start PostgreSQL with: devenv up"
            '';

            services.postgres = {
              enable = true;
              listen_addresses = "127.0.0.1";
              initialScript = ''
                CREATE ROLE postgres WITH LOGIN SUPERUSER PASSWORD 'postgres';
              '';
            };
          };

          devenv.shells.news-aggregator = {
            enterShell = ''
              echo "Welcome to the news aggregator Go shell!"
              go version
            '';

            languages.go.enable = true;
          };

          devenv.shells.contest = {
            imports = [
              node
            ];

            enterShell = ''
              echo "Welcome to the contest shell! Run e.g.: python3 contest-a.py < input.txt"
            '';

            languages.python.enable = true;
          };
        };
    };
}
