# test if we have go installed and want to set up the env
which go 2> /dev/null
rc=$?
if [[ $rc -eq 0 ]]; then

  export GOPATH=$HOME/development/go
  if [ ! -d $GOPATH ] ;then mkdir -p $GOPATH ; fi
  export GOROOT=`/usr/local/bin/go env GOROOT`

  # Customize to your needs...
  export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

fi
