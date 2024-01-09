if [ -f ~/.bashrc ]; then
    . $HOME/.bashrc
fi

append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

# rust
[ -f ~/.cargo/env ] && . "$HOME/.cargo/env"
# export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
export CARGO_HOME="$HOME/.cargo"

# golang
export GOPATH=$HOME/dev/go
append_path $GOPATH/bin
#source <(golangci-lint completion bash) # it's slow for bash initializing

# fzf
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    [ -f ~/.fzf.zsh ] && . ~/.fzf.zsh
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
   # assume Bash
    [ -f ~/.fzf.bash ] && . ~/.fzf.bash
fi
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# rupa/z.sh
source $HOME/.mybashscripts/z.sh
alias zz='z -c'

# haskell
append_path $HOME/.local/bin
append_path $HOME/.cabal/bin
[ -f ~/.ghcup/env ] && . "$HOME/.ghcup/env" && eval "$(stack --bash-completion-script stack)"

if [[ "$OSTYPE" == "darwin"* ]]; then

    export PATH=$PATH:/usr/local/sbin

    # homebrew bottles
    #export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles 
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"

    # homebrew racket
    append_path "/Applications/Racket v8.11.1/bin"

    # perl for mac
    append_path $HOME/.perl5/bin
    export PERL5LIB="$HOME/.perl5/lib/perl5"
    export PERL_LOCAL_LIB_ROOT="$HOME/.perl5"
    export PERL_MB_OPT="--install_base \"$HOME/.perl5\""
    export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"

    export GOPROXY=http://goproxy.intra.xiaojukeji.com,direct
    export GOSUMDB=off
    export GO111MODULE=auto

    # java
    export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_331.jdk/Contents/Home'
    append_path $JAVA_HOME/bin
    export MAVEN_HOME=/Users/ggarlic/.local/bin/apache-maven-3.6.3
    append_path $MAVEN_HOME/bin

    # rpc-tools
    append_path $HOME/.rpc-tools
fi
