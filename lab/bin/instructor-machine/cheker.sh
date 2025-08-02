#!/bin/sh

# カラーコードの定義
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# スクリプトの使用法を表示する関数
usage() {
    echo "使用法: $0 <CSVファイル>"
    echo "例: $0 urls.csv"
    exit 1
}

# CSVファイルが引数として指定されているか確認
if [ -z "$1" ]; then
    usage
fi

CSV_FILE="$1"

# CSVファイルが存在するか確認
if [ ! -f "$CSV_FILE" ]; then
    echo "エラー: ファイル '$CSV_FILE' が見つかりません。"
    exit 1
fi

echo "---"
echo "URLの接続ステータスを確認中..."
echo "---"

# CSVファイルを読み込み、各URLのステータスを確認
# IFS (内部フィールドセパレータ) を改行に設定し、行ごとに処理
# -r オプションでバックスラッシュのエスケープを無効にする
while IFS= read -r url; do
    # 空行をスキップ
    if [ -z "$url" ]; then
        continue
    fi

    # curlを使ってHTTPステータスコードを取得
    # -o /dev/null: 出力を破棄
    # -s: サイレントモード（プログレスバーなどを表示しない）
    # -w "%{http_code}\n": HTTPステータスコードを出力
    # --max-time 10: 最大10秒でタイムアウト
    http_code=$(curl -o /dev/null -s -w "%{http_code}\n" --max-time 10 "$url")

    # ステータスコードが200か確認
    if [ "$http_code" -eq 200 ]; then
        echo -e "[${GREEN}OK${NC}] $url (ステータスコード: $http_code)"
    else
        echo -e "[${RED}NG${NC}] $url (ステータスコード: $http_code)"
    fi
done < "$CSV_FILE"

echo "---"
echo "確認完了。"
echo "---"