# Command for displaying credentials and other information
function creds_description {
  echo "Display credentials for a cluster"
}

function creds_usage {
  errEcho "usage: $(basename ${0}) creds [OPTIONS] [CONTEXT]"
  errEcho
  errEcho "    $(creds_description)"
  errEcho "    CAUTION: This will display the admin password."
  errEcho
  errEcho "    CONTEXT is the name of a kube context that matches a ClusterClaim"
  errEcho
  errEcho "    The following OPTIONS are available:"
  errEcho
  errEcho "    -r    Refresh the credentials by fetching a fresh copy"
  errEcho
  abort
}

function creds {
  OPTIND=1
  while getopts :r o 
  do case "$o" in
    r)  FETCH_FRESH="true";;
    [?]) creds_usage;;
    esac
  done
  shift $(($OPTIND - 1))

  local context=$1
  if [[ -z $context ]]
  then
    context=$(current)
  fi
  case $context in
    cm)
      fatal "Cannot display credentials for the ClusterPool host"
      ;;
    *)
      displayCreds $context $FETCH_FRESH
      ;;
  esac
}