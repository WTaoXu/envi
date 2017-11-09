# project envi
BASE=$GITHUB_DIR"/wentaoxu/envi"
PINGCAP_DIR=$GOPATH"/src/github.com/pingcap"
TIDB_DIR=$PINGCAP_DIR"/tidb"
TIKV_DIR=$PINGCAP_DIR"/tikv"
PD_DIR=$PINGCAP_DIR"/pd"
WORK_DIR=$HOME"/WorkPlace"
SCRIPT_DIR=$BASE"/Scripts"

# go envi
export GOROOT="/usr/local/go"
export GOPATH="/Users/xuwentao/Projects"

# common envi
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
PATH="/usr/local/go/bin:${PATH}"
PATH="/usr/local/bin:${PATH}"
PATH="/usr/local/mysql/bin:${PATH}"
PATH="/usr/local/pgsql/bin:${PATH}"
PATH="$HOME/.bin:${PATH}"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$BASE/.bin:${PATH}"
export PATH

#sudo launchctl limit maxfiles 100000 500000
#sudo ulimit -n 100000

# alias
alias python="/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6"

alias rm='rm -i'
alias cp='cp -i'                                                         
alias mv='mv -i'

alias ls='ls -G'                                                         
alias ll='ls -l'                                                         
alias la='ls -A'                                                         
alias l='ls -CF'

alias gcc='/usr/local/bin/gcc-7'
alias cc='/usr/local/bin/gcc-7'
alias g++='/usr/local/bin/g++-7'
alias c++='/usr/local/bin/c++-7'

alias ctags='/usr/local/bin/ctags'

# source other file
source $BASE/Scripts/set_env.sh
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
