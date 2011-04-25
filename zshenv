# make compilers happy
export ARCHFLAGS='-arch x86_64'

# go compiler appeasement
export GOROOT=/Users/qrush/go/src
export GOBIN=/Users/qrush/go/src/bin
export GOARCH=386
export GOOS=darwin
export PATH=$PATH:/Users/qrush/go/src/bin

# favor homebrew
export PATH=/usr/local/bin:$PATH

# bring in android tools
export PATH=$PATH:/Users/qrush/Dev/android/platform-tools
export PATH=$PATH:/Users/qrush/Dev/android/tools
export ANDROID_SDK=/Users/qrush/Dev/android

# code swarm it up
export PATH=$PATH:/Users/qrush/Dev/java/code_swarm/bin

# RVM woot!
if [[ -s /Users/qrush/.rvm/scripts/rvm ]] ; then source /Users/qrush/.rvm/scripts/rvm ; fi

# load history
export HISTFILE=~/.history

# put home and dev dir on cdpath
cdpath=(~ ~/Dev)
typeset -gU cdpath
