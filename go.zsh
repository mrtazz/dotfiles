# test if we have go installed and want to set up the env
GO=$(which go 2> /dev/null)
rc=$?
if [[ $rc -eq 0 ]]; then

  # clean out $GOROOT/bin from existing $PATH. This is mostly so when go is
  # upgraded, it doesn't keep the old path in there in tmux. In order to
  # remove the subpath we use the array representation $path to remove the
  # matching entry. Also unset $GOROOT after so it can be reset further down.
  # We don't do anything with $GOPATH as it's not dependent on the go version.
  path=( "${path[@]/${GOROOT}/bin}" )
  unset GOROOT

  export GOPATH=$HOME/code/go
  if [ ! -d $GOPATH ] ;then mkdir -p $GOPATH ; fi
  export GOROOT=$(${GO} env GOROOT)

  # Customize to your needs...
  export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

fi

# let's try the vendor stuff
export GO15VENDOREXPERIMENT=1
