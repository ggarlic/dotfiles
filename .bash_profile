if [ -f ~/.bashrc ]; then
    . $HOME/.bashrc
fi

export PATH=$PATH:/usr/local/sbin

# rust
source "$HOME/.cargo/env"
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
export CARGO_HOME="$HOME/.cargo"

# golang
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin
source <(golangci-lint completion bash)

export GOPROXY=http://goproxy.intra.xiaojukeji.com,direct
export GOSUMDB=off
export GO111MODULE=auto

# rpc-tools
export PATH=/Users/ggarlic/.rpc-tools:$PATH

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# rupa/z.sh
source $HOME/.mybashscripts/z.sh
alias zz='z -c'

# haskell
. "$HOME/.ghcup/env"
export PATH=$HOME/.local/bin:$PATH
eval "$(stack --bash-completion-script stack)"
export PATH=$HOME/.cabal/bin:$PATH

if [[ "$OSTYPE" == "darwin"* ]]; then
    # homebrew bottles
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

    # homebrew racket
    export PATH=$PATH:/Applications/Racket\ v8.0/bin

    # perl for mac
    export PATH="$HOME/.perl5/bin:$PATH"
    export PERL5LIB="$HOME/.perl5/lib/perl5"
    export PERL_LOCAL_LIB_ROOT="$HOME/.perl5"
    export PERL_MB_OPT="--install_base \"$HOME/.perl5\""
    export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"
fi
