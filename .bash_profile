

#export JAVA_HOME=/usr/lib/jvm/default-java

export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_HOME=$HOME/.android

# The following is to resolve incompatibility between
# emulator libstdc++ and system library equivalent

export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1


# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

export HOMEBREW_GITHUB_API_TOKEN="my_api_toke_here"

export QSYS_ROOTDIR="/home/jsr/intelFPGA_lite/17.1/quartus/sopc_builder/bin"

alias tks='tmux kill-session -t jsr-dev'
alias tns='tmux new-session -s jsr-dev'
alias sshsr='ssh -l dpr -X -L 50037:localhost:5037 192.168.1.104'

alias start-studio-remote-adb='ANDROID_ADB_SERVER_PORT=50037 ~/Downloads/android-studio-3.1-beta1/android-studio/bin/studio.sh'
