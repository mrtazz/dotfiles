# test if we have go installed and want to set up the env
GO=$(which go 2> /dev/null)
rc=$?
if [[ $rc -eq 0 ]]; then

  export GOPATH=$HOME/development/go
  if [ ! -d $GOPATH ] ;then mkdir -p $GOPATH ; fi
  export GOROOT=`${GO} env GOROOT`

  # Customize to your needs...
  export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

fi
