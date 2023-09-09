#!/bin/bash 

run() {
    local file=$1
    echo "run script: $file"
    bash $file 
    if [ $? != 0 ]; then
        echo "Check Mode faild: $JOB_SRP"
        reboot
    fi
}

run_job() {
    local in=$1
    if [ -d "$in" ];then
        echo "run dir: $in"
        JOBS=$(ls "$in/")
        for job in $JOBS; do
            local JOB_SRP=$in/$job
            run $JOB_SRP
        done
    fi
    
    if [ -f "$in" ];then
        run $in
    fi
}

run_job $@ >> /var/tmp/deepin-installer-checkmode.log  2>&1 # 用于执行目录下或者独立的脚本文件，会将脚本输出的日志写入到安装日志中
