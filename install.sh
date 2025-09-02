#!/bin/bash

# ==============================================================================
#                      Script de Instalação para Fedora
# ==============================================================================
# Este script automatiza a instalação de programas, fontes e a configuração
# dos dotfiles no Fedora. Execute-o após uma instalação limpa do sistema.
# ==============================================================================

# Aborta o script em caso de qualquer erro
set -e

# --- Seção 1: Atualização e Instalação de Programas ---
echo "Iniciando o processo de instalação e atualizando o sistema..."

sudo dnf update -y

echo "Instalando programas e ferramentas..."

# Instala grupos de desenvolvimento
sudo dnf group install -y c-development development-tools

# Lista de pacotes para instalar em um array para fácil manutenção
PROGRAMAS=(
  stow
  neovim
  tmux
  btop
  zsh
  git
  fzf
  zoxide
  fish_indent
  bat
  fd-find
  alacritty
  ripgrep
  python3-neovim
  go
  clang
  bzip2-devel
  libffi-devel
  sqlite-devel
  tk-devel
  clang-format
  clang-tidy
  readline-devel
  util-linux-user
)

# Executa a instalação dos programas do array
sudo dnf install -y "${PROGRAMAS[@]}"

# --- Seção 2: Configuração do Shell (Zsh) ---
echo "Configurando Zsh como seu shell padrão..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clona os plugins do Zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

# --- Seção 3: Instalação de Outras Ferramentas ---
echo "Instalando Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install eza

echo "Instalando e configurando asdf..."
# A URL do asdf pode mudar. Verifique a versão mais recente se necessário.
go install github.com/asdf-vm/asdf/cmd/asdf@v0.18.0

#instalando tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Adiciona plugins e instala versões com asdf
asdf plugin add lua
asdf plugin add lazygit
asdf install lazygit latest
asdf install lua 5.1.5
asdf set -u lua 5.1.5

# --- Seção 4: Configuração dos Dotfiles com Stow ---
echo "Criando links simbólicos para os dotfiles com Stow..."

# Navega até a pasta de dotfiles
cd "$HOME/.dotfiles"

# Usa o stow para cada subdiretório do seu repositório
# Adicione ou remova linhas de acordo com as pastas que você criou
stow zsh
stow nvim
stow alacritty
stow tmux
stow git

# --- Seção 5: Instalação de Fontes ---
echo "Instalando fontes do repositório..."

# Cria a pasta de fontes no diretório do usuário, se não existir
mkdir -p ~/.local/share/fonts

# Copia a fonte AdwaitaMono do repositório para a pasta de fontes local
cp -r "$HOME/.dotfiles"/fonts/FiraCode ~/.local/share/fonts/

# Atualiza o cache de fontes do sistema
fc-cache -f -v

# --- Fim do Script ---
echo "==================================================="
echo "Instalação concluída com sucesso! "
echo "Por favor, reinicie seu terminal ou PC para aplicar as mudanças do shell (Zsh)."
echo "==================================================="
