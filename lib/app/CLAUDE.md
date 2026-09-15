# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Este arquivo é específico de `lib/app/`. Para o grafo geral de módulos/DI e o fluxo de boot completo
(incluindo a parte que acontece fora daqui, em `AuthBloc`), ver [../CLAUDE.md](../CLAUDE.md); para
convenções gerais do projeto, ver o `CLAUDE.md` da raiz.

## Papel deste módulo

`lib/app/` é o módulo de bootstrap: não é uma feature de negócio, é quem monta o app (`AppModule`),
decide a primeira tela (`InitializeApp`) e hospeda o `MaterialApp.router` (`AppWidget`). Não deveria
crescer com regras de negócio de feature — isso vai em `lib/modules/<feature>/`.

## Estrutura

- [app.module.dart](app.module.dart) — `Module` raiz, importado só por `main.dart`. Importa `CoreModule`,
  `AuthModule`, `HomeModule`; faz bind de `AppBloc` e `IInitializeApp`; registra as rotas `'/'` (placeholder
  `Container` cinza), `'/home'` e `'/auth'`.
- `domain/usecases/` — [`InitializeApp`](domain/usecases/initialize_app.usecase.dart): recebe um
  `RetrieveLastSessionHook` por parâmetro (não por injeção), chama a hook, e delega a navegação para
  `INavigationHandlerPresenter`.
- `domain/hooks/` — [`RetrieveLastSessionHook`](domain/hooks/retrieve_last_session_hook.dart): wrapper de
  `Future<Session?> Function()` em volta de `AuthBloc.I.retrieveLastSession`. É o único ponto em que
  `app/` "conhece" o módulo `auth`, e mesmo assim só via `presentation/bloc/app.state.dart` montando a hook
  — `domain/` deste módulo não importa `auth` em lugar nenhum.
- `presentation/bloc/` — `AppBloc`/`IAppEvent`/`IAppState` (arquivo único com `part`, ver padrão de BLoC no
  CLAUDE.md raiz). Único evento hoje: `InitializeAppEvent`. Estados: `AppInitialState` →
  `AppInitializing` → `AppInitialized` | `AppInitializationFailure(message)`.
- [presentation/app.view.dart](presentation/app.view.dart) — `AppWidget`: dispara `APP.I.boot()` em
  `initState`; envolve `MaterialApp.router` (roteamento vem de `Modular.routerConfig`) em `ScreenUtilInit`.

## Coisas não óbvias ao mexer aqui

- **`APP` (o singleton com `serviceLocator`/`navigationHandler`/`globalContext`) mora em `lib/main.dart`,
  não em `lib/app/`** — apesar do nome parecido. `AppBloc`/`AppModule` usam `APP.I.serviceLocator` mas não
  o definem.
- **Responsividade já é global**: `ScreenUtilInit` (design size `375x667`, `minTextAdapt: true`,
  `splitScreenMode: true`) e o `MediaQuery` com `textScaleFactor` fixado em `1.0` estão só aqui, em
  `AppWidget.build`. Novas telas não devem envolver-se em outro `ScreenUtilInit` — já está resolvido no
  topo da árvore.
- **O padrão de estado "auto-despachante"**: o handler do BLoC (`_onInitializeRequested`) só chama
  `state.initializeApp(emit)` — quem decide o que fazer é o próprio estado atual. Um estado novo do
  `AppBloc` precisa implementar `initializeApp` mesmo que seja um no-op (como `AppInitializing`,
  `AppInitialized` e `AppInitializationFailure` fazem hoje).
- **A rota `'/'` registrada em `AppModule.routes()` é um placeholder** (`Container(color: Colors.grey[800])`),
  não uma página real — nenhum fluxo deveria navegar de volta para ela intencionalmente. Se um dia
  `NavigationHandler` for corrigido para compor `HomeRoutes`/`LoginRoutes` corretamente (ver gotcha em
  [../CLAUDE.md](../CLAUDE.md)), essa rota deixa de ser alcançável por engano.
- `domain/domain.exports.dart` tem uma linha de export apontando para si mesma
  (`export 'domain.exports.dart';`) — resíduo de copy-paste do boilerplate, inofensivo mas não replique o
  padrão ao criar um barrel novo (o mesmo existe em `presentation/presentation.exports.dart` deste módulo).
