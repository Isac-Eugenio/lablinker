# Launch Page

## Descrição
A **Launch Page** é a tela inicial de entrada do aplicativo, responsável por apresentar uma animação de abertura com o nome do app e o subtítulo. Ela serve como uma introdução visual e direciona o usuário para a **Home View** após a animação.

## Funcionalidades

1. **Animação do Título**
    - O nome do aplicativo ("LabLinker") aparece letra por letra.
    - Cada letra realiza uma animação de tamanho e posição (efeito "wave").

2. **Subtítulo**
    - Exibe o subtítulo ou lema do aplicativo ("O Poder do Maker").
    - Surge após a animação do título, com efeito de fade-in.

3. **Toque para Continuar**
    - Texto piscante "Toque para continuar".
    - Ao tocar em qualquer parte da tela, o usuário é redirecionado para a Home View.

4. **Controle de Animações**
    - Usa `AnimationController` para sequenciar letras, efeito wave e piscamento do texto.
    - Verifica `mounted` para evitar erros durante a atualização do estado.

## Estrutura de Arquivos

- **launch_page.dart**: Tela principal de abertura do app com animação de título e subtítulo.

## Dependências

- `flutter/material.dart`: Componentes básicos do Flutter.
- `flutter_animate`: Animações das letras e efeitos visuais.
- `Routes`: Para navegação até a Home View.

## Observações
- A tela não possui interação além do toque para continuar.
- Serve como introdução visual, reforçando a identidade do aplicativo.
- A animação é totalmente assíncrona e sequencial.
