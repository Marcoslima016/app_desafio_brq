# Portal da Seguradora — Desafio Técnico Flutter

Aplicação multiplataforma (Web e Mobile) que simula o portal digital de uma seguradora,
desenvolvida como desafio técnico para a vaga de **Desenvolvedor Flutter Pleno**.

> **Candidato:** Marcos Vinicius Lima
> **Status:** 🚧 Em desenvolvimento — este README será expandido conforme a implementação avança.

---

## 📋 Sobre o projeto

O objetivo é entregar um portal de seguros multiplataforma com foco em qualidade de
arquitetura, testabilidade e organização do código.

---

## 🛠 Stack e decisões técnicas

| Item | Escolha |
| --- | --- |
| Framework | Flutter `3.35.0` |
| Plataformas | Web e Mobile (Android / iOS) |
| Arquitetura | Clean Architecture |
| Modularização | [Flutter Modular](https://pub.dev/packages/flutter_modular) |
| Gerência de estado | [BLoC](https://pub.dev/packages/flutter_bloc) |
| Autenticação | Firebase Auth |
| Persistência | Cloud Firestore |
| Processo de desenvolvimento | SDD (Spec-Driven Development) com [OpenSpec](https://github.com/Fission-AI/OpenSpec) |

### Arquitetura

O projeto adota **Clean Architecture** organizada em módulos independentes (Flutter Modular).
Cada módulo de funcionalidade é dividido nas camadas:

```
lib/
├── core/                     # Recursos compartilhados (tema, rotas, DI, erros, helpers)
├── modules/
│   └── <feature>/
│       ├── domain/           # Entidades, contratos de repositório e casos de uso
│       ├── data/             # DTOs, datasources (Firebase) e implementações de repositório
│       ├── presentation/     # BLoCs, páginas e widgets
│       └── <feature>_module.dart
└── main.dart
```

A dependência aponta sempre **de fora para dentro**: `presentation → domain ← data`,
mantendo o domínio livre de dependências de framework ou infraestrutura.

### Desenvolvimento assistido por IA (SDD)

O desenvolvimento segue a prática de **Spec-Driven Development** com o framework **OpenSpec**:
cada mudança relevante nasce de uma especificação versionada, que serve de contrato tanto para
a implementação quanto para a validação. As specs ficam versionadas no repositório
(diretório `openspec/`).

---

## ✅ Requisitos

- **Flutter SDK** `3.35.0` — recomenda-se o uso do [FVM](https://fvm.app/)
- **Dart SDK** — versão acompanhada pelo Flutter 3.35.0
- Conta e projeto configurados no **Firebase** (Auth + Firestore)
- **FlutterFire CLI** — `dart pub global activate flutterfire_cli`
- Para Mobile: Android Studio / Xcode com emulador ou dispositivo físico
- Para Web: navegador baseado em Chromium

---

## 🚀 Executando o projeto

### 1. Clonar e instalar dependências

```bash
git clone <url-do-repositorio>
cd app_desafio_brq
flutter pub get
```

### 2. Configurar o Firebase

As credenciais do Firebase **não são versionadas**. Gere o arquivo de configuração local com:

```bash
flutterfire configure
```

O comando cria o `lib/firebase_options.dart` e os arquivos nativos
(`google-services.json` / `GoogleService-Info.plist`).

### 3. Executar

```bash
# Web
flutter run -d chrome

# Mobile (dispositivo/emulador conectado)
flutter run
```

### 4. Gerar build de produção

```bash
flutter build web --release
flutter build apk --release
```

---

## 🧪 Testes

```bash
# Executa a suíte de testes
flutter test

# Com relatório de cobertura
flutter test --coverage
```

---

## 📄 Licença

Projeto de uso exclusivo para avaliação técnica.
