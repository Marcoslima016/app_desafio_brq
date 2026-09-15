# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Este arquivo é específico de `lib/core/`. Para o grafo geral de módulos/DI, ver [../CLAUDE.md](../CLAUDE.md);
para convenções gerais do projeto (nomenclatura de adapters/presenters), ver o `CLAUDE.md` da raiz.

## Papel deste módulo

`lib/core/` é infraestrutura transversal reutilizada por todas as features: navegação, storage seguro e
service locator, hoje. Não tem `domain` de negócio (entidades/use cases de feature) — só contratos de
infraestrutura (`adapters`) e de apresentação (`presenters`) mais suas implementações. Qualquer módulo de
feature que precise de um desses serviços importa `CoreModule`, nunca implementa o próprio.

`CoreModule` ([core.module.dart](core.module.dart)) só declara `exportedBinds` (sem `binds` locais nem
`routes`) — os três serviços abaixo são `addLazySingleton` e ficam disponíveis para qualquer módulo que
importe `CoreModule`.

## Estrutura

- `domain/adapters/` — interfaces `I<Nome>Adapter`, Dart puro:
  - [`IAppNavigatorAdapter`](domain/adapters/i_app_navigator.adapter.dart) — `pushNamed`,
    `pushReplacementNamed`, `navigate`, `pop`, `canPop`.
  - [`ISecureStorageAdapter`](domain/adapters/i_secure_storage.adapter.dart) — `read`/`write`/`delete` por
    `key`.
  - [`IServiceLocatorAdapter`](domain/adapters/i_service_locator.adapter.dart) — `get<B>({key})`,
    `replaceInstance<T>`.
- `domain/presenters/` — [`INavigationHandlerPresenter`](domain/presenters/i_navigation_handler.presenter.dart):
  `navigateToAuthenticatedArea()`, `navigateToLogin()`, `navigateToSignupFromLogin()`. É a única interface
  de mais alto nível aqui — modela *intenção de navegação* (pós-login, pós-boot), enquanto
  `IAppNavigatorAdapter` modela a mecânica de navegação (rota nomeada, stack). Para um novo destino de
  navegação, adicione um método aqui em vez de chamar `IAppNavigatorAdapter` direto de uma `presentation`
  de feature.
- `external/<pacote>/` — uma pasta por dependência externa envolvida, cada uma com seu próprio
  `<pacote>.exports.dart`:
  - `modular/` — [`ModularNavigator`](external/modular/modular_navigator.adapter.dart) (implementa
    `IAppNavigatorAdapter` sobre `Modular.to`) e
    [`ModularServiceLocator`](external/modular/modular_service_locator.adapter.dart) (implementa
    `IServiceLocatorAdapter` sobre `Modular.get`/`Modular.replaceInstance`).
  - `secure_storage/` — [`FlutterSecureStorageAdapter`](external/secure_storage/flutter_secure_storage.adapter.dart)
    implementa `ISecureStorageAdapter` sobre `flutter_secure_storage`; aceita um `FlutterSecureStorage?`
    opcional no construtor (facilita mock em teste).
  - Ao integrar Firebase (`firebase_core`/`firebase_auth`/`cloud_firestore`, ver `CLAUDE.md` raiz), o
    padrão esperado é uma pasta nova `external/firebase/` seguindo o mesmo formato — não misturar com
    `modular/` ou `secure_storage/`.
- `presentation/controllers/` — [`NavigationHandler`](presentation/controllers/navigation_handler.controller.dart)
  implementa `INavigationHandlerPresenter`; expõe `NavigationHandler.I` (acesso estático via
  `APP.I.serviceLocator`) e resolve `IAppNavigatorAdapter` internamente (também via service locator) para
  traduzir cada método de intenção em uma chamada de navegação concreta.

## Coisas não óbvias ao mexer aqui

- **Todo bind aqui é `exportedBinds`, nunca `binds`** — é assim que os adapters ficam visíveis para
  `AuthModule`, `HomeModule` etc. sem que cada um precise redeclarar o bind. Um novo adapter/presenter
  criado em `core/` deve seguir esse mesmo padrão, senão módulos que importam `CoreModule` não vão
  enxergá-lo.
- `adapters.exports.dart` e `external/external.exports.dart` têm uma linha de export apontando para si
  mesmas (ex.: `export 'adapters.exports.dart';` dentro do próprio `adapters.exports.dart`) — resíduo de
  copy-paste do boilerplate, inofensivo mas não replique esse padrão ao criar um barrel novo.
- `NavigationHandler` e `ModularNavigator`/`ModularServiceLocator` são as únicas classes em `lib/core` que
  importam `flutter_modular`/Flutter diretamente — tudo em `domain/` permanece Dart puro, coerente com a
  regra `presentation → domain ← data` descrita no `CLAUDE.md` raiz (aqui sem uma camada `data`, já que
  não há persistência remota neste módulo).
