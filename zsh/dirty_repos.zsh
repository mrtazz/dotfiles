#
# this is a function that takes a file with a list of repos as an argument and
# checks all the repos for pending and unpushed changes
#
function check_dirty_git_repos() {
  local REPO_LIST=$1
  # return if the file list doesn't exist
  [ ! -f ${REPO_LIST} ] && >&2 echo "List file ${REPO_LIST} doesn't exist." && return 0

  for repo in $(cat ${REPO_LIST}); do

    # let's check for changes
    CHANGES=$(git --git-dir=${repo}/.git/ --work-tree=${repo} status --short | wc -l)
    [ ${CHANGES} -ne 0 ] && echo "$fg[red]NOTICE:$reset_color There are pending changes in the repo: (${repo})."

    if git ls-remote --git-dir=${repo}/.git/ --work-tree=${repo} > /dev/null 2>&1 ; then
      REMOTE_BRANCH=$(git symbolic-ref  --git-dir=${repo}/.git/ --work-tree=${repo} HEAD | cut -d "/" -f 3)
      ORIGIN_DIFF=$(git --git-dir=${repo}/.git/ --work-tree=${repo} diff origin/${REMOTE_BRANCH} --stat | wc -l)
      [ ${ORIGIN_DIFF} -ne 0 ] && echo "$fg[red]NOTICE:$reset_color There are unpushed changes in the repo: (${repo})."
    fi

  done
}
