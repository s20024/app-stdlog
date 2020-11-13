#!/bin/sh

#　今いるディレクトリパスの取得
path=`pwd`

# アプリケーションの説明の表示
eog 1.png

# Windowsで実行した場合のエラー処理
if [ $? -ne 0 ]
then
        echo "Ubuntu以外で実行されました。"
        echo "今いるディレクトリ内にある画像ファイル(1~5)までを読んで以下に進んでください"

        # 上のやつを読む時間を待つための処理
        sleep 20
fi

# 実行していいかの判断
read -p "実行してよろしいですか？  yes(y)/no(n):" judge

if [ "$judge" = "y" ]; then

    # 今日のデータの取得]
    today=`date "+%y:%m:%d"`

    #　ホームディレクトリの下に隠しディレクトリの作成＆移動
    mkdir -p ~/.stdlog
    cd ~/.stdlog

    #githubからshellscriptのダウンロード
    git clone --depth 1 https://github.com/s20024/stdlog.git
    # ダウンロードしたものを移動
    mv stdlog/* .
    #　いらないディレクトリとREADME.mdの削除
    rm -rf stdlog README.md

    # 必要なファイルの作成
    touch stdlog_breaktime stdlog_in

    # todayファイルの作成
    echo "$today" > stdlog_today

    #　ホームディレクトリにstdlogディレクトリの作成＆移動
    cd ~/
    mkdir -p stdlog
    cd stdlog

    #　data.csvの作成＆最初の記入
    touch data.csv 
    echo "year_month_day,study_time_hour,study_time_minute" > data.csv

    # 今日のデータの入力（一応）
    echo "$today,0,0" >> data.csv



    #　.bashrcに記入（開いたときに読み込まれるから次回からaliasを打たなくていい）
    echo "
alias in=\". ~/.stdlog/in.sh\"
alias out=\". ~/.stdlog/out.sh\"
alias breaktime=\". ~/.stdlog/breaktime.sh\"
    " >> ~/.bashrc

    #　一応.bashrc の再読込
    . ~/.bashrc

    #　最初にいた位置に帰宅ｗ
    cd $path

    #　必要なくなったこのディレクトリの削除
    cd .. 
    rm -rf app-stdlog
fi