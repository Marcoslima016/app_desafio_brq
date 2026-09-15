# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Este arquivo é específico de `lib/modules/`. Para o grafo geral de módulos/DI e o fluxo de boot, ver
[../CLAUDE.md](../CLAUDE.md); para convenções gerais do projeto, ver o `CLAUDE.md` da raiz.

## Papel deste diretório

Cada subpasta é uma feature independente (`Module` do `flutter_modular`) montada pelo `AppModule`
([../app/app.module.dart](../app/app.module.dart)). [modules.exports.dart](modules.exports.dart) é só o
barrel que reexporta `auth/auth.exports.dart` e `home/home.exports.dart` — ao adicionar uma feature nova,
ela entra nesse barrel.

## Features existentes hoje

- **`auth/`** ([auth/auth_module.dart](auth/auth_module.dart)) — único módulo com camada `domain`/`data`
  completa (entidade `Session`, `IAuthRepository`, `IAuthLocalDatasource`, `SessionDto`,
  `IRetrieveLastSession`) e um fluxo vertical real (`retrieveLastSession`, ver
  [../CLAUDE.md](../CLAUDE.md)). Tem dois submódulos, cada um com `Module`/`Routes`/`presentation`
  próprios: `modules/login/` e `modules/signup/`. **Ambos são placeholders visuais** (`LoginPage`,
  `SignupPage` só renderizam um `Scaffold` com texto) — sem `binds`, sem BLoC de formulário, sem use case
  de login/cadastro. Ao implementar de verdade, os binds (use cases, eventual datasource remoto) entram em
  `AuthModule.exportedBinds` (mesmo padrão de `RetrieveLastSession` hoje), a menos que sejam exclusivos de
  um submódulo específico.
- **`home/`** ([home/home.module.dart](home/home.module.dart)) — ainda não tem `domain`/`data`, só
  `presentation/pages/home.page.dart` (placeholder) e a rota raiz. É o destino pós-login (o "portal do
  segurado" mencionado no `CLAUDE.md` raiz); ao implementar, siga o mesmo layout de `auth/` (`domain/`,
  `data/`, `presentation/bloc/`), não apenas `presentation/pages/`.

## Esqueleto para uma feature nova

Copiar o formato de `auth/` (a feature mais madura), não o de `home/` (ainda incompleto):

```
modules/<feature>/
├── domain/
│   ├── entities/<nome>.entity.dart (+ entities.exports.dart)
│   ├── repositories/i_<nome>_repository.dart (+ repositories.exports.dart)
│   ├── usecases/<nome>.usecase.dart (+ usecases.exports.dart)
│   └── domain.exports.dart
├── data/
│   ├── dtos/<nome>.dto.dart (fromJson/toJson/toEntity) (+ dtos.exports.dart)
│   ├── datasources/<nome>_datasource.dart (+ datasources.exports.dart)
│   ├── repositories/<nome>_repository.dart (+ repositories.exports.dart)
│   └── data.exports.dart
├── presentation/
│   ├── bloc/<feature>.bloc.dart (+ .event.dart, .state.dart via part, + bloc.exports.dart)
│   └── presentation.exports.dart
├── modules/<sub-feature>/         # opcional — só se a feature tiver sub-telas com rota própria
│   └── (mesmo formato: Module, <Sub>Routes, presentation/pages/)
├── <feature>.routes.dart          # classe <Feature>Routes com os paths já compostos com o prefixo do pai
├── <feature>_module.dart          # nome de arquivo legado; para módulo novo prefira <feature>.module.dart
└── <feature>.exports.dart
```

## Composição de rotas — atenção ao padrão que cada `Routes` segue

`AppModule` monta `'/auth' → AuthModule` e `'/home' → HomeModule`; `AuthModule` monta `'/login' →
LoginModule` e `'/signup' → SignupModule`. O path navegável real de cada rota é sempre prefixo de
montagem + `child`/`root` do módulo filho — mas as classes `<Feature>Routes` documentam esse path de
formas diferentes hoje:

- [`AuthRoutes`](auth/auth.routes.dart) guarda os valores **já compostos**:
  `AuthRoutes.login = '/auth/login'`, `AuthRoutes.signup = '/auth/signup'`.
- [`HomeRoutes.root`](home/home.routes.dart), [`LoginRoutes.root`](auth/modules/login/login.routes.dart) e
  [`SignupRoutes.root`](auth/modules/signup/signup.routes.dart) valem todos `'/'` — o path *relativo* ao
  próprio módulo, sem o prefixo do pai.

Isso é o que causa o gotcha de navegação documentado em [../CLAUDE.md](../CLAUDE.md) (`NavigationHandler`
usando `HomeRoutes.root` como se fosse `'/home'`). Ao criar uma `<Feature>Routes` para uma feature nova ou
submódulo, prefira seguir o padrão de `AuthRoutes` (path já composto com o prefixo definido pelo pai em
`routes()`) — é o único dos quatro hoje que se comporta como a navegação espera.
