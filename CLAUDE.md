# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Contexto

Desafio técnico para vaga de Flutter Pleno: "Portal da Seguradora", app multiplataforma (Web + Android/iOS).
O repositório está no estágio inicial — `lib/` contém apenas `main.dart` com um scaffold de `MaterialApp`.
A arquitetura descrita abaixo é o alvo definido no README; ao criar código novo, siga-a em vez de improvisar
uma estrutura diferente.

## Comandos

```bash
flutter pub get
flutter analyze                      # lint (flutter_lints via analysis_options.yaml)
flutter test
flutter test test/widget_test.dart   # arquivo único
flutter test --plain-name "nome do teste"   # teste único por nome
flutter test --coverage

flutter run -d chrome                # web
flutter run                          # mobile (device/emulador conectado)
flutter build web --release
flutter build apk --release
```

Flutter SDK fixado em **3.35.0** (Dart SDK `^3.9.0`). O README recomenda FVM, mas ainda não há `.fvmrc`/`.fvm/`
no repositório — os comandos acima rodam com o `flutter` global.

## Arquitetura alvo

Clean Architecture com módulos independentes via **flutter_modular**; estado com **BLoC**; backend
**Firebase Auth + Cloud Firestore**.

```
lib/
├── core/                  # tema, rotas, DI, erros, helpers compartilhados
├── modules/<feature>/
│   ├── domain/            # entidades, contratos de repositório, use cases
│   ├── data/              # DTOs, datasources (Firebase), impl. de repositório
│   ├── presentation/      # BLoCs, páginas, widgets
│   └── <feature>_module.dart
└── main.dart
```

Regra de dependência: `presentation → domain ← data`. O `domain` não importa Flutter, Firebase, Modular
nem qualquer pacote de infraestrutura — apenas Dart puro. `data` implementa as interfaces declaradas em
`domain`; `presentation` consome use cases, nunca repositórios/datasources diretamente.

Nenhuma dessas dependências está em `pubspec.yaml` ainda (hoje só há `cupertino_icons` + `flutter_lints`).
Ao implementar a primeira feature, adicione `flutter_modular`, `flutter_bloc`, `firebase_core`,
`firebase_auth` e `cloud_firestore`.

## Firebase

Credenciais **não são versionadas**. `lib/firebase_options.dart`, `google-services.json` e
`GoogleService-Info.plist` são gerados localmente por `flutterfire configure` — não commitar nem
criar esses arquivos à mão.

## Processo: Spec-Driven Development (OpenSpec)

O projeto adota SDD com OpenSpec: cada mudança relevante nasce de uma spec versionada em `openspec/`,
que serve de contrato para implementação e validação. O diretório ainda não existe; ao iniciar uma
feature significativa, escreva/atualize a spec antes do código.
