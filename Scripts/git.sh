#!/bin/zsh

GITHUB="https://github.com/"

function git-ck-remote()
{
        if test -z $1; then
                echo -e "Usage:\n"
                echo -e "\tgit-ck-remote [username]:[reponame]:[pr-branch]\n"
                echo -e "The argument can be copied directly from github PR page."
                echo -e "The local branch name would be [github-reponame]/[pr-branch]."
                exit 0;
        fi

        username=$(echo $1 | cut -d':' -f1)
        reponame=$(echo $1 | cut -d':' -f2)
        branch=$(echo $1 | cut -d':' -f3)
        local_branch=${username}/${branch}
        fork="https://github.com/${username}/${reponame}"
        exists=`git show-ref refs/heads/$local_branch`
        if [ -n ${exits} ]; then
                git pull ${fork} ${branch}:${local_branch}
        else
                git fetch ${fork} ${branch}:${local_branch}
                git checkout ${local_branch}
        fi
}

function git-pull-remote()
{
        if test -z $1; then
                echo -e "Usage:\n"
                echo -e "\tgit-ck-remote [username]:[reponame]:[pr-branch]\n"
                echo -e "The argument can be copied directly from github PR page."
                echo -e "The local branch name would be [github-reponame]/[pr-branch]."
                exit 0;
        fi

        username=$(echo $1 | cut -d':' -f1)
        reponame=$(echo $1 | cut -d':' -f2)
        branch=$(echo $1 | cut -d':' -f3)
        local_branch=${username}/${branch}
        fork="https://github.com/${username}/${reponame}"
        git pull ${fork} ${branch}:${local_branch}
}

function git-push-remote()
{
        if test -z $1; then
                echo -e "Usage:\n"
                echo -e "\tgit-ck-remote [username]:[reponame]:[pr-branch]\n"
                echo -e "The argument can be copied directly from github PR page."
                echo -e "The local branch name would be [github-reponame]/[pr-branch]."
                exit 0;
        fi

        username=$(echo $1 | cut -d':' -f1)
        reponame=$(echo $1 | cut -d':' -f2)
        branch=$(echo $1 | cut -d':' -f3)
        local_branch=${username}/${branch}
        fork="https://github.com/${username}/${reponame}"
        git push ${fork} ${branch}:${local_branch}
}
