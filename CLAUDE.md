# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Contexto

Desafio técnico para vaga de Flutter Pleno: "Portal da Seguradora", app multiplataforma (Web + Android/iOS).
O boilerplate de bootstrap (DI, módulos, tema/responsividade, adapters de navegação/storage) está montado e o
módulo `auth` já tem um primeiro fluxo vertical completo — `AuthBloc.retrieveLastSession` lê a sessão persistida
em `flutter_secure_storage` (via `IAuthRepository`/`IAuthLocalDatasource`/`SessionDto`) e `InitializeApp` usa
esse resultado para decidir entre `navigateToLogin()` e `navigateToAuthenticatedArea()` na abertura do app.
As telas de negócio em si (`LoginPage`, `SignupPage`, `HomePage`) ainda são placeholders visuais sem BLoC de
formulário nem casos de uso de autenticação (login/cadastro real, portal do segurado etc.) — isso é o que falta
implementar. Ao criar código novo, siga os padrões já estabelecidos (ver "Convenções") em vez de improvisar uma
estrutura diferente.

## Comandos

```bash
flutter pub get
flutter analyze                      # lint (flutter_lints via analysis_options.yaml)
flutter test
flutter test --plain-name "nome do teste"   # teste único por nome
flutter test --coverage

flutter run -d chrome                # web
flutter run                          # mobile (device/emulador conectado)
flutter build web --release
flutter build apk --release
```

Não há testes no repositório no momento (`test/widget_test.dart` do scaffold padrão foi removido e nada o
substituiu ainda; `test/` está vazio).

O README recomenda Flutter `3.35.0` via FVM, mas ainda não há `.fvmrc`/`.fvm/` no repositório — os comandos
acima rodam com o `flutter` global. O `environment.sdk` do `pubspec.yaml` está fixado no SDK Dart local
(`^3.6.0-149.3.beta`); confira `pubspec.yaml` antes de assumir a versão.

## Arquitetura alvo

Clean Architecture com módulos independentes via **flutter_modular**; estado com **BLoC**; backend
**Firebase Auth + Cloud Firestore** (ainda não integrado — hoje a sessão é só local, via `flutter_secure_storage`).

```
lib/
├── core/
│   ├── domain/
│   │   ├── adapters/          # interfaces I<Nome>Adapter (navigator, secure storage, service locator)
│   │   └── presenters/        # interfaces I<Nome>Presenter (ex.: navegação pós-autenticação)
│   ├── external/               # implementações concretas dos adapters (Modular, flutter_secure_storage)
│   └── presentation/
│       └── controllers/        # implementações dos presenters (ex.: NavigationHandler)
├── app/                        # bootstrap (AppModule, AppBloc, AppWidget)
│   └── domain/
│       ├── hooks/               # Hooks que desacoplam o AppBloc de outros BLoCs
│       └── usecases/            # ex.: InitializeApp
├── modules/<feature>/
│   ├── domain/                 # entidades, contratos (I<Nome>Repository), use cases
│   ├── data/                    # DTOs, datasources, implementações de repositório
│   ├── presentation/            # BLoC da feature
│   ├── modules/<sub-feature>/   # submódulos com Module/Routes/presentation próprios (ex.: auth/modules/login)
│   └── <feature>_module.dart (ou <feature>.module.dart em código novo)
└── main.dart
```

Regra de dependência: `presentation → domain ← data`. O `domain` não importa Flutter, Firebase, Modular
nem qualquer pacote de infraestrutura — apenas Dart puro. `data` implementa as interfaces declaradas em
`domain`; `presentation` consome use cases, nunca repositórios/datasources diretamente.

## Convenções do boilerplate

Estes padrões já estão em uso em `lib/app`, `lib/core` e `lib/modules/auth` — siga-os ao criar módulos novos:

- **Barrel exports**: cada pasta tem um `<pasta>.exports.dart` que reexporta seus arquivos/subpastas.
  `lib/lib.exports.dart` é o barrel raiz; a maior parte do código importa `package:app_desafio_brq/lib.exports.dart`
  em vez de arquivos individuais.
- **Módulos (flutter_modular)**: um `Module` por feature em `modules/<feature>/`. A nomenclatura do arquivo
  ainda está inconsistente no repo (`auth_module.dart` vs `app.module.dart`/`login.module.dart`/`home.module.dart`) —
  prefira o padrão `<feature>.module.dart` usado nos módulos mais recentes para código novo.
- **Submódulos**: uma feature pode ter submódulos próprios em `modules/<feature>/modules/<sub>/`, cada um com seu
  `Module`, sua classe `<Sub>Routes` e sua própria `presentation/` (ex.: `auth/modules/login`, `auth/modules/signup`).
  O módulo pai monta as rotas do filho via `r.module('/<sub>', module: SubModule())` em `routes()`.
- **Rotas**: cada módulo (e submódulo) expõe uma classe `<Feature>Routes` só com `static const String`, já
  compostas com o path de montagem definido pelo pai (ex.: `AuthRoutes.login = '/auth/login'`, montado a partir
  de `AppModule.routes` + `AuthModule.routes` + `LoginModule.routes`).
- **Adapters**: interface `I<Nome>Adapter` em `core/domain/adapters/`; implementação concreta `<Nome>Adapter`
  em `core/external/<pasta>/<nome>.adapter.dart` (ex.: `ModularNavigator` implementa `IAppNavigatorAdapter`,
  `FlutterSecureStorageAdapter` implementa `ISecureStorageAdapter`), registrada no `CoreModule.exportedBinds`.
  `presentation`/`domain` dependem só da interface — nunca de `Modular.get`/`flutter_secure_storage` diretamente.
- **Presenters/Controllers**: interface `I<Nome>Presenter` em `core/domain/presenters/` (ex.:
  `INavigationHandlerPresenter`); implementação em `core/presentation/controllers/<nome>.controller.dart`
  (ex.: `NavigationHandler`), com acesso estático `<Nome>.I` via `APP.I.serviceLocator.get<...>()`.
- **BLoC**: um arquivo `<feature>.bloc.dart` com `part '<feature>.event.dart'` e `part '<feature>.state.dart'`
  (states como `sealed class` com subclasses `final class`), reexportados por `bloc.exports.dart`. Cada BLoC expõe
  um acesso estático `XBloc.I` via `APP.I.serviceLocator.get<XBloc>()`. O estado base declara os métodos que
  reagem a cada evento (ex.: `Future<void> initializeApp(Emitter<IAppState> emit)`), e cada subclasse implementa
  seu próprio comportamento; o handler do BLoC só delega (`state.initializeApp(emit)`), evitando `switch`/`if`
  sobre o tipo do estado.
- **Hooks**: quando um BLoC precisa do resultado de uma operação exposta por outro BLoC sem depender dele
  diretamente, usa-se um `<Nome>Hook` (`domain/hooks/<nome>_hook.dart`) que embrulha uma função — ex.:
  `RetrieveLastSessionHook` embrulha `AuthBloc.I.retrieveLastSession` para ser consumido por `InitializeApp`
  sem que o `app` module importe `AuthBloc` diretamente.
- **Use cases**: interface `I<Nome>` + implementação `<Nome>`, ambas no mesmo arquivo `<nome>.usecase.dart` dentro
  de `domain/usecases/`, registradas no `Module.binds`/`exportedBinds`.
- **Repositórios e datasources**: interface `I<Nome>Repository`/`I<Nome>Datasource` (ex.: `IAuthRepository`,
  `IAuthLocalDatasource`); implementação concreta com o mesmo nome sem o `I`, em arquivo snake_case sem sufixo
  de tipo (`auth_repository.dart`, `auth_local_datasource.dart`) — note que esse é um sufixo diferente do usado
  pelos use cases (`.usecase.dart`).
- **DTOs**: `<Nome>Dto` em `data/dtos/<nome>.dto.dart`, com `fromJson`/`toJson` e um método `toEntity()` que
  converte para a entidade correspondente em `domain/entities`.
- **Singleton `APP`** ([lib/main.dart](lib/main.dart)): ponto global de acesso a `serviceLocator`,
  `navigationHandler` e `globalContext`; `APP.I.boot()` (chamado em `AppWidget.initState`) monta o
  `serviceLocator`, resolve o `navigationHandler` e dispara `AppBloc.I.add(const InitializeAppEvent())`.

## Dependências

Já presentes em `pubspec.yaml`: `flutter_modular`, `flutter_bloc`, `flutter_screenutil`, `flutter_secure_storage`.
Ainda faltam `firebase_core`, `firebase_auth` e `cloud_firestore` — adicione ao implementar a primeira feature
que precise de backend remoto (hoje a sessão só é lida localmente, nunca criada por um login real).

## Firebase

Credenciais **não são versionadas**. `lib/firebase_options.dart`, `google-services.json` e
`GoogleService-Info.plist` são gerados localmente por `flutterfire configure` — não commitar nem
criar esses arquivos à mão.

## Processo: Spec-Driven Development (OpenSpec)

O projeto adota SDD com OpenSpec: cada mudança relevante nasce de uma spec versionada em `openspec/`,
que serve de contrato para implementação e validação. O diretório ainda não existe; ao iniciar uma
feature significativa, escreva/atualize a spec antes do código.
