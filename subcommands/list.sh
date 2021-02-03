# Command for listing resources
function list_description {
  echo "List ClusterPools, ClusterClaims, and ClusterDeployments"
}

function list_usage {
  errEcho "usage: $(basename ${0}) list pools|claims|clusters"
  errEcho
  errEcho "    $(list_description)"
  errEcho "    Each resource type supports a number of aliases (singular and plural)"
  errEcho "    and is case-insensitve"
  errEcho
  errEcho "    pools (cp, ClusterPool)"
  errEcho "    claims (cc, ClusterClaim)"
  errEcho "    clusters (cd, ClusterDeployment)"
  errEcho
  abort
}

function list {
  case $(echo "$1" | tr '[:upper:]' '[:lower:]') in
    pool*|cp*|clusterpool*)
      ocWithContext cm get ClusterPools
      ;;
    claim*|cc*|clusterclaim*)
      ocWithContext cm get ClusterClaims -o custom-columns="$CLUSTERCLAIM_CUSTOM_COLUMNS"
      ;;
    cluster*|cd*|clusterdeployment*)
      ocWithContext cm get ClusterDeployments -A -L hibernate
      ;;
    *)
      list_usage
      ;;
  esac
}