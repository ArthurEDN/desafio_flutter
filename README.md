# Desafio Técnico - Flutter Developer

## 📱 Sobre o Projeto

Este projeto implementa um aplicativo de seguros com as seguintes funcionalidades:

- **Tela de Login** com autenticação Firebase
- **Tela Home** com dashboard principal
- **Menu Lateral (Drawer)** com navegação completa
- **Responsividade** para mobile e web

## 🚀 Funcionalidades Implementadas

### ✅ Tela de Login
- Campos de CPF e Senha com validação
- Botões "Entrar" e "Cadastrar"
- Checkbox "Lembrar sempre"
- Link "Esqueceu a senha?"
- Ícones de redes sociais ilustrativos
- **Autenticação funcional com Firebase**

### ✅ Tela Home
- Exibição do nome do usuário logado
- Área "Cotar e Contratar" com ícones:
  - Automóvel
  - Residência
  - Vida
  - Acidentes Pessoais
- Seções:
  - Minha Família (adicionar membros)
  - Contratados (lista com mensagem quando vazia)

### ✅ Menu Lateral (Drawer)
- Avatar e nome do usuário
- Itens de navegação:
  - Home / Seguros
  - Minhas Contratações
  - Meus Sinistros
  - Minha Família
  - Meus Bens
  - Pagamentos
  - Coberturas
  - Validar Boleto
  - Telefones Importantes
  - Configurações

### ✅ Responsividade
- Compatível com mobile e web
- Layout adaptativo para diferentes tamanhos de tela

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework principal
- **Firebase** - Autenticação e banco de dados
  - `firebase_core: ^3.14.0`
  - `firebase_auth: ^5.6.0`
  - `cloud_firestore: ^5.6.0`
- **Gerenciamento de Estado** - BLoC Pattern
  - `bloc: ^9.0.0`
  - `flutter_bloc: ^9.1.1`
- **Roteamento** - GoRouter
  - `go_router: ^15.2.3`
- **Utilitários**
  - `cupertino_icons: ^1.0.8`
  - `google_fonts: ^6.2.1`
  - `equatable: ^2.0.7`
  - `forms: ^0.8.0`

## 📋 Pré-requisitos

- Flutter SDK (versão 3.0 ou superior)
- Dart SDK
- Android Studio / VS Code
- Configuração do Firebase (arquivo `google-services.json` para Android e `GoogleService-Info.plist` para iOS)

## 🔧 Instalação e Execução

### 1. Clone o repositório
```bash
git clone https://github.com/ArthurEDN/desafio_flutter
cd [NOME_DA_PASTA]
```

### 2. Instale as dependências
```bash
flutter pub get
```

### 3. Configuração do Firebase

#### Opção A: Usar Firebase já configurado (Recomendado para teste)
O projeto já possui configuração Firebase funcional. Apenas execute:
```bash
flutter pub get
flutter run
```

#### Opção B: Configurar seu próprio Firebase
Se preferir usar seu próprio projeto Firebase:
- Crie um projeto no [Firebase Console](https://console.firebase.google.com/)
- Adicione seu app Android/iOS/Web
- Substitua os arquivos de configuração:
  - `android/app/google-services.json` (Android)
  - `ios/Runner/GoogleService-Info.plist` (iOS)
  - `lib/shared/firebase_options.dart` (Web)
- Configure a autenticação por email/senha no Firebase Auth

### 4. Execute o aplicativo

#### Mobile (Android/iOS)
```bash
flutter run
```

#### Web
```bash
flutter run -d chrome
```

## 🏗️ Estrutura do Projeto

```
lib/
├── domain/
│   ├── models/        # Modelos de dados
│   ├── repositories/  # Interfaces dos repositórios
│   └── auth/         # Entidades de autenticação
├── data/
│   ├── repositories/  # Implementação dos repositórios
│   └── auth/         # Repositório de autenticação
├── presentation/
│   ├── auth/         # Telas e BLoC de autenticação
│   │   ├── bloc/     # Estados e eventos de auth
│   │   └── screens/  # Telas de login, registro, etc.
│   ├── forgot_password/ # Funcionalidade esqueci senha
│   │   ├── bloc/
│   │   └── screens/
│   ├── login/        # Tela de login específica
│   │   ├── bloc/
│   │   └── screens/
│   ├── register/     # Tela de registro
│   │   ├── bloc/
│   │   └── screens/
│   └── home/         # Tela principal
│       ├── bloc/
│       └── screens/
├── shared/
│   ├── widgets/      # Componentes reutilizáveis
│   └── firebase_options.dart # Configurações Firebase
└── main.dart         # Ponto de entrada da aplicação
```

## 🎯 Diferenciais Implementados

- ✅ **Firebase Authentication** - Sistema completo de autenticação
- ✅ **State Management** - Implementado com BLoC Pattern
- ✅ **Responsividade** - Funciona em mobile e web
- ✅ **Estrutura Limpa** - Organização seguindo Clean Architecture
- ✅ **Validação de Formulários** - Campos validados adequadamente

## ❌ Funcionalidades Não Implementadas

- ❌ **WebView** - Não implementada para o card "Automóvel"
- ❌ **Deploy Web** - Não foi feito deploy para Firebase Hosting/Vercel
- ❌ **Testes Automatizados** - Não foram implementados testes

## 🚀 Próximos Passos

Para completar o desafio, as próximas implementações seriam:

1. **WebView Integration**
   ```yaml
   dependencies:
     webview_flutter: ^4.4.1
   ```

2. **Deploy para Web**
   - Firebase Hosting
   - Vercel
   - GitHub Pages

3. **Testes Automatizados**
   - Unit Tests
   - Widget Tests
   - Integration Tests

---

**Desenvolvido como parte do desafio técnico para Flutter Developer** 🚀