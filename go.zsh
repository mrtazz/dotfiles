# test if we have go installed and want to set up the env
GO=$(which go 2> /dev/null)
rc=$?
if [[ $rc -eq 0 ]]; then

  export GOPATH=$HOME/code/go
  if [ ! -d $GOPATH ] ;then mkdir -p $GOPATH ; fi

  # Customize to your needs...
  export PATH=$GOPATH/bin:$PATH

fi

# let's try the vendor stuff
export GO15VENDOREXPERIMENT=1
