# Home View

## Descrição
A **Home View** é a tela principal do aplicativo e serve como hub de navegação para todas as funcionalidades. Ela organiza os módulos do app (Gamepad, Consoles, IOT, Configurações) em um menu visual e adaptativo.

## Funcionalidades

1. **Menu Adaptativo**
    - Exibe itens usando o `AdaptiveGridMenu`.
    - Ajusta automaticamente o número de colunas conforme a quantidade de itens.
    - Mantém espaçamento e proporção consistentes entre os itens.

2. **Navegação**
    - Cada item do menu é um `ItemPageWidget` que leva a uma view específica.
    - Suporte a navegação para:
        - Gamepad
        - Consoles
        - IOT
        - Configurações

3. **Interface Responsiva**
    - Layout adaptável a diferentes tamanhos de tela.
    - Mantém consistência visual e usabilidade em telas pequenas e grandes.

## Estrutura de Arquivos

- **home_view.dart**: Tela principal com o menu adaptativo.
- **adaptive_grid_menu.dart**: Widget que organiza os itens em grid.
- **item_page_widget.dart**: Widget para cada item do menu, com ícone, título e navegação.

## Dependências

- `flutter/material.dart`: Componentes básicos do Flutter.
- Rotas definidas em `Routes` para navegação interna.

## Observações
- A view é modular e independente, podendo ser facilmente atualizada ou expandida.
- Serve como hub central do aplicativo para acesso rápido às principais funcionalidades.
