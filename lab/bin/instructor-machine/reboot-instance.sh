#!/bin/bash

# スクリプトの使用方法を表示
if [ -z "$1" ]; then
  echo "使用方法: $0 <プライベートIPアドレス>"
  exit 1
fi

PRIVATE_IP=$1

echo "プライベートIPアドレス $PRIVATE_IP を持つインスタンスを検索しています..."

# プライベートIPアドレスからインスタンスIDを検索
INSTANCE_ID=$(aws ec2 describe-instances \
  --filters "Name=private-ip-address,Values=$PRIVATE_IP" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text)

# インスタンスIDが見つからなかった場合の処理
if [ -z "$INSTANCE_ID" ]; then
  echo "エラー: プライベートIPアドレス $PRIVATE_IP に該当するインスタンスは見つかりませんでした。"
  exit 1
fi

echo "インスタンスID: $INSTANCE_ID が見つかりました。"
echo "インスタンスを再起動します..."

# インスタンスを再起動
aws ec2 reboot-instances --instance-ids "$INSTANCE_ID"

if [ $? -eq 0 ]; then
  echo "インスタンス $INSTANCE_ID の再起動コマンドが正常に送信されました。"
else
  echo "エラー: インスタンス $INSTANCE_ID の再起動に失敗しました。"
  exit 1
fi