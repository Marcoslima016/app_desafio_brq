# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Este arquivo complementa o `CLAUDE.md` da raiz do projeto (que cobre comandos, estrutura de pastas e
convenções gerais de nomenclatura). Aqui o foco é o que só fica claro lendo vários arquivos de `lib/` ao
mesmo tempo: o grafo real de módulos/injeção de dependência do `flutter_modular`, o fluxo de boot e o
estado atual de cada módulo.

## Grafo de módulos e injeção de dependência

`ModularApp(module: AppModule())` ([main.dart](main.dart)) é a raiz. Import chain real (não apenas a
árvore de pastas):

- **`AppModule`** ([app/app.module.dart](app/app.module.dart)) importa `CoreModule`, `AuthModule`,
  `HomeModule`. Faz bind de `AppBloc` e `IInitializeApp`.
- **`CoreModule`** ([core/core.module.dart](core/core.module.dart)) só tem `exportedBinds` (sem binds
  locais): `ISecureStorageAdapter → FlutterSecureStorageAdapter`, `INavigationHandlerPresenter →
  NavigationHandler`, `IAppNavigatorAdapter → ModularNavigator`, todos `addLazySingleton`. Todo módulo que
  precisa desses adapters importa `CoreModule` (não redeclara os binds).
- **`AuthModule`** ([modules/auth/auth_module.dart](modules/auth/auth_module.dart)) importa `CoreModule`.
  `exportedBinds`: `AuthBloc`, `IAuthLocalDatasource → AuthLocalDatasource`, `IAuthRepository →
  AuthRepository`, `IRetrieveLastSession → RetrieveLastSession`. Rotas: monta `LoginModule` em `/login` e
  `SignupModule` em `/signup`.
- **`HomeModule`**, **`LoginModule`**, **`SignupModule`** só importam `CoreModule` e ainda não têm binds
  próprios — cada um só registra a rota raiz para sua page placeholder
  (`HomePage`/`LoginPage`/`SignupPage`).

Ou seja: hoje só existem binds reais em `CoreModule` e `AuthModule`. Ao implementar login/cadastro de
verdade, os use cases/datasources/repositório entram em `AuthModule.exportedBinds` (mesmo padrão de
`RetrieveLastSession`), não em `LoginModule`/`SignupModule` — a menos que sejam exclusivos daquele
submódulo.

## Rotas montadas — cuidado com paths não compostos

`AppModule.routes()` monta `'/home' → HomeModule` e `'/auth' → AuthModule` (que por sua vez monta
`'/login' → LoginModule` e `'/signup' → SignupModule`). O path efetivo de cada rota é o prefixo de
montagem + o `child`/`root` declarado no módulo filho.

As classes `<Feature>Routes` **não seguem o mesmo padrão entre si**:

- `AuthRoutes` ([modules/auth/auth.routes.dart](modules/auth/auth.routes.dart)) guarda os valores **já
  compostos** com o prefixo `/auth` definido pelo pai: `AuthRoutes.login = '/auth/login'`,
  `AuthRoutes.signup = '/auth/signup'`.
- `HomeRoutes.root`, `LoginRoutes.root` e `SignupRoutes.root` valem todos `'/'` — **não** incluem o
  prefixo de montagem (`/home`, `/auth/login`, `/auth/signup`).

Isso importa porque [`NavigationHandler`](core/presentation/controllers/navigation_handler.controller.dart)
navega usando essas constantes diretamente: `navigateToAuthenticatedArea()` chama
`navigator.pushReplacementNamed(HomeRoutes.root)`, ou seja, `pushReplacementNamed('/')` — que resolve para
o `child('/')` do próprio `AppModule` (hoje um `Container` cinza placeholder), **não** para `/home`/`HomePage`.
Ao mexer em navegação, prefira compor o path completo (como `AuthRoutes` já faz) em vez de usar
`HomeRoutes.root`/`LoginRoutes.root`/`SignupRoutes.root` isolados, ou ajuste essas classes para seguir o
mesmo padrão de `AuthRoutes` antes de depender delas.

## Fluxo de boot (estado atual)

1. `main()` roda `ModularApp` + `AppWidget`; `AppWidget.initState` chama `APP.I.boot()`
   ([main.dart](main.dart)).
2. `APP.boot()` monta `serviceLocator` (`ModularServiceLocator`), resolve `navigationHandler` e dispara
   `AppBloc.I.add(const InitializeAppEvent())`.
3. `AppInitialState.initializeApp` ([app/presentation/bloc/app.state.dart](app/presentation/bloc/app.state.dart))
   emite `AppInitializing`, cria um `RetrieveLastSessionHook` embrulhando `AuthBloc.I.retrieveLastSession`,
   e chama `InitializeApp` ([app/domain/usecases/initialize_app.usecase.dart](app/domain/usecases/initialize_app.usecase.dart)).
4. `AuthBloc.retrieveLastSession()` ([modules/auth/presentation/bloc/auth.bloc.dart](modules/auth/presentation/bloc/auth.bloc.dart))
   só dispara `RetrieveLastSessionEvent` se `state.isProcessing`; senão retorna `state.session` já
   conhecido — evita disparar a busca mais de uma vez em paralelo.
5. `AuthInitialState.retrieveLastSession` chama `IRetrieveLastSession` (use case) → `AuthRepository` →
   `AuthLocalDatasource.getLastSession()` → `ISecureStorageAdapter.read(key: 'auth_session')` → decodifica
   JSON em `SessionDto` → `.toEntity()` vira `Session`. Ausência de sessão ⇒ `UnauthorizedState`/`null`.
6. `InitializeApp` decide `navigateToLogin()` ou `navigateToAuthenticatedArea()` conforme `Session?` seja
   `null` ou não (ver ressalva sobre `HomeRoutes.root` acima).

Esse encadeamento (`AppBloc` → `Hook` → `AuthBloc` → use case → repositório → datasource → adapter) é o
exemplo de referência para qualquer fluxo novo que precise ler estado de um módulo a partir de outro sem
acoplar os `Module`s entre si.

## Estado de implementação por módulo

| Módulo/arquivo | Status |
|---|---|
| `core/*` (adapters de navegação, storage, service locator) | Implementado e em uso |
| `modules/auth` — `retrieveLastSession` (bloc, use case, repositório, datasource, DTO) | Implementado (fluxo vertical completo) |
| `modules/auth/modules/login` — `LoginPage`, `LoginModule` | Placeholder visual — sem BLoC de formulário nem use case de login |
| `modules/auth/modules/signup` — `SignupPage`, `SignupModule` | Placeholder visual — sem BLoC/use case de cadastro |
| `modules/home` — `HomePage`, `HomeModule` | Placeholder visual — sem binds, sem conteúdo do "portal do segurado" |
| `AppModule` rota `'/'` | `Container` cinza temporário — nunca é o destino pretendido do fluxo (ver rotas acima) |

## Adapters/presenters disponíveis em `core/`

Interfaces já prontas para reuso (não recrie equivalentes):

- `IAppNavigatorAdapter` — `pushNamed`, `pushReplacementNamed`, `navigate`, `pop`, `canPop` (impl.:
  `ModularNavigator`, usa `Modular.to`).
- `ISecureStorageAdapter` — `read`/`write`/`delete` por `key` (impl.: `FlutterSecureStorageAdapter`).
- `IServiceLocatorAdapter` — `get<B>({key})`, `replaceInstance<T>` (impl.: `ModularServiceLocator`, usa
  `Modular.get`/`Modular.replaceInstance`).
- `INavigationHandlerPresenter` — `navigateToAuthenticatedArea()`, `navigateToLogin()`,
  `navigateToSignupFromLogin()` (impl.: `NavigationHandler`). Para um novo destino de navegação (ex.: pós
  cadastro), adicione o método aqui em vez de chamar `IAppNavigatorAdapter` diretamente da
  `presentation`.
