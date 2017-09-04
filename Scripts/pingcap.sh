# !/bin/sh

function build()
{
        target=$1
        if [ $target="" ]; then
                echo "must have one parameter, like tidb tikv or pd"
                exit 1
        fi

        if [ $target="tidb" ]; then
                cd $TIDB_DIR
                make
                cd -
                cp -f $TIDB_DIR/bin/* $HOME/bin/
        elif [ $target="tikv" ]; then
                cd $TIKV_DIR
                make
                cd -
                cp -f $TIKV_DIR/bin/* $HOME/bin/
        elif [ $target="pd" ]; then
                cd $PD_DIR
                make
                cd -
                cp -f $PD_DIR/bin/* $HOME/bin/
        fi
        source ~/.profile
}

function start_pd()
{
        rm -rf $WORK_DIR"/pd"
        $PD_DIR/bin/pd-server --data-dir=$WORK_DIR"/pd" --log-file=$WORK_DIR"/pd.log" &
}

function start_tikv()
{
        rm -rf $WORK_DIR"/tikv"
        $TIKV_DIR/bin/tikv-server --pd="127.0.0.1:2379" --data-dir=$WORK_DIR"/tikv" --log-file=$WORK_DIR"/tikv.log" &
}

function start_tidb()
{
        rm -rf $WORK_DIR"/tidb"
        $TIDB_DIR/bin/tidb-server --store=tikv --path="127.0.0.1:2379" --log-file=$WORK_DIR"/tidb.log" &
}

function start_all()
{
        start_pd
        sleep 5
        start_tikv
        start_tidb
}

function kill_pd()
{
        ps ux |grep $USER |grep pd-server |grep -v grep |awk '{print $2}' |xargs kill -9
}

function kill_tikv()
{
        ps ux |grep $USER |grep tikv-server |grep -v grep |awk '{print $2}' |xargs kill -9
}

function kill_tidb()
{
        ps ux |grep $USER |grep tidb-server |grep -v grep |awk '{print $2}' |xargs kill -9
}

function kill_all()
{
        kill_tidb
        kill_tikv
        kill_pd
}

function connection_tidb()
{
        mysql -h 127.0.0.1 -P 4000 -u root -D test
}

function show_all_process()
{
        ps ux |grep $USER |grep -v grep |grep "\-server"
}
