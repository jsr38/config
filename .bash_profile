
export M2_HOME=/usr/local/apache-maven-3.2.3
export M2=$M2_HOME/bin

export JAVA_HOME=$(/usr/libexec/java_home)

export PG_HOME=/Library/PostgreSQL/9.3

export ANDROID_SDK_HOME=/Users/jsr/Downloads/adt-bundle-mac-x86_64-20140702/sdk

export M2_REPO=/Users/jsr/.m2/repository

export HOMEBREW_EDITOR="emacs -nw"

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

export PATH=$M2:$PG_HOME/bin:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH

export HOMEBREW_GITHUB_API_TOKEN="my_api_toke_here"
