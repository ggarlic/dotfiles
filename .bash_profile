if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH=$PATH:/usr/local/sbin

# perl for mac
export PATH="$HOME/.perl5/bin:$PATH"
export PERL5LIB="$HOME/.perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="$HOME/.perl5"
export PERL_MB_OPT="--install_base \"$HOME/.perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"

#homebrew python2
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"
export PATH="/usr/local/opt/python@2/bin:$PATH"

#rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export CARGO_HOME="$HOME/.cargo"

#ocaml
test -r $HOME/.opam/opam-init/init.sh && . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

#homebrew racket
export PATH=$PATH:/Applications/Racket\ v7.5/bin

#homebrew haskell
export PATH="/usr/local/opt/ghc@8.6/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH
eval "$(stack --bash-completion-script stack)"
export PATH=$HOME/.cabal/bin:$PATH

#golang
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

