#!/bin/zsh
RAMFS="/ramfs"

function build()
{
        target=${1}
        if [[ -z ${target} ]]; then
                echo "must have one parameter, like tidb tikv or pd"
                return
        fi

        if [[ ${target} = "tidb" ]]; then
                cd ${TIDB_DIR}
                make
                cd -
                \cp -f ${TIDB_DIR}/bin/tidb-server ${HOME}/.bin/
        elif [[ ${target} = "tikv" ]]; then
                cd ${TIKV_DIR}
                make static_release
                cd -
                \cp -f ${TIKV_DIR}/bin/* ${HOME}/.bin/
        elif [[ ${target} = "pd" ]]; then
                cd ${PD_DIR}
                make
                cd -
                \cp -f ${PD_DIR}/bin/* ${HOME}/.bin/
        else
                echo "invalid parameter, need to be tidb,tikv,pd"
        fi
        source ~/.zshrc
}

function tiinit()
{
        target=${1}
        if [[ -z ${target} ]]; then
                echo "must have one parameter, like mysql,pg"
                return
        fi

        echo "initdb "${target}
        if [[ ${target} = "mysql" ]]; then
                rm -rf ${WORK_DIR}"/mysql"
                mysqld --initialize --datadir=${WORK_DIR}/mysql/
        elif [[ ${target} = "pg" ]]; then
                rm -rf ${WORK_DIR}"/pg"
                initdb -D ${WORK_DIR}/pg
        else
                echo "invalid parameter, need to be mysql,pg"
        fi
}

function start()
{
        target=${1}
        if [[ -z ${target} ]]; then
                echo "must have one parameter, like tidb,tikv,pd,tiall,mysql"
                return
        fi

        start_tidb_cmd="${TIDB_DIR}/bin/tidb-server --config=${WORK_DIR}/tidb.toml --store=tikv --path='127.0.0.1:2379' --log-file=${RAMFS}/tidb.log &"
        start_tikv_cmd="${TIKV_DIR}/bin/tikv-server --pd='127.0.0.1:2379' --data-dir=${WORK_DIR}/tikv --log-file=${WORK_DIR}/tikv.log &"
        start_pd_cmd="${PD_DIR}/bin/pd-server --data-dir='${WORK_DIR}/pd' --log-file='${WORK_DIR}/pd.log' &"

        echo "start "${target}
        if [[ ${target} = "tidb" ]]; then
                rm -rf ${WORK_DIR}"/tidb"
                sh -c "${start_tidb_cmd}"
        elif [[ ${target} = "tikv" ]]; then
                rm -rf ${WORK_DIR}"/tikv"
                sh -c "${start_tikv_cmd}"
        elif [[ ${target} = "pd" ]]; then
                rm -rf ${WORK_DIR}"/pd"
                sh -c "${start_pd_cmd}"
        elif [[ ${target} = "mysql" ]]; then
                if [[ ! -e ${WORK_DIR}/mysql ]]; then
                        mysqld --initialize --datadir=${WORK_DIR}/mysql
                fi
                mysqld --skip-grant-tables --general-log --general-log-file=${WORK_DIR}/myQuery.log --datadir=${WORK_DIR}/mysql 2>&1 >${WORK_DIR}/my.log
        elif [[ ${target} = "pg" ]]; then
                if [[ ! -e ${WORK_DIR}/pg ]]; then
                        intidb -D ${WORK_DIR}/pg
                fi
                pg_ctl -D ${WORK_DIR}/pg -l ${WORK_DIR}/pg.log start
                createdb test
        elif [[ ${target} = "tiall" ]]; then
                rm -rf $WORK_DIR"/pd"
                sh -c "${start_pd_cmd}"
                rm -rf $WORK_DIR"/tikv"
                sh -c "${start_tikv_cmd}"
                sleep 1
                rm -rf $WORK_DIR"/tidb"
                sh -c "${start_tidb_cmd}"
        else
                echo "invalid parameter, need to be tidb,tikv,pd,tiall,mysql"
        fi
}

function tikill()
{
        target=${1}
        if [[ -z ${target} ]]; then
                echo "must have one parameter, like tidb,tikv,pd,all"
                return
        fi

        kill_tidb_cmd="ps ux |grep $USER |grep tidb-server |grep -v grep |awk '{print $2}' |xargs kill -9"
        kill_tikv_cmd="ps ux |grep $USER |grep tikv-server |grep -v grep |awk '{print $2}' |xargs kill -9"
        kill_pd_cmd="ps ux |grep $USER |grep pd-server |grep -v grep |awk '{print $2}' |xargs kill -9"

        echo "kill "${target}
        if [[ ${target} = "tidb" ]]; then
                sh -c "${kill_tidb_cmd}"
        elif [[ ${target} = "tikv" ]]; then
                sh -c "${kill_tikv_cmd}"
        elif [[ ${target} = "pd" ]]; then
                sh -c "${kill_pd_cmd}"
        elif [[ ${target} = "all" ]]; then
                sh -c "${kill_tidb_cmd}"
                sh -c "${kill_tikv_cmd}"
                sh -c "${kill_pd_cmd}"
        else
                echo "invalid parameter, need to be tidb,tikv,pd,all"
        fi
}

function connect()
{
        target=${1}
        if [[ -z ${target} ]]; then
                echo "must have one parameter, like tidb or mysql"
                return
        fi

        if [[ ${target} = "tidb" ]]; then
                mysql -h 127.0.0.1 -P 4000 -u root -D test
        elif [[ ${target} = "mysql" ]]; then
                mysql mysql
        elif [[ ${target} = "pg" ]]; then
                psql test
        fi
}

function xconnect()
{
        target=${1}
        if [[ -z ${target} ]]; then
                echo "must have one parameter, like tidb or mysql"
                return
        fi

        if [[ ${target} = "tidb" ]]; then
                mysqlsh --uri root@localhost:14000/test
        elif [[ ${target} = "mysql" ]]; then
                mysqlsh --uri root@localhost:33060/mysql
        fi
}

function tishow()
{
        ps ux |grep $USER |grep -v grep |grep "\-server" |grep -e "tidb\|tikv\|pd"
}
