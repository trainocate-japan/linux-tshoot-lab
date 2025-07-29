# Linuxトラブルシューティング実践　ラボガイド
- Linuxトラブルシューティング実践のラボガイドと講師向け資料

## 演習ガイド
- TBW
### 執筆用環境のビルド
> vscodeのnodeコンテナではyarn buildに失敗しますんで注意（詳細は未調査）
- ubuntu等の環境を vm もしくは container で作成
- install node.js and npm by `sudo apt install nodejs npm`
- install yarn  by `cd guide && sudo npm install -g yarn`
- install vuepress by `yarn add -D vuepress`

### 執筆中の動作確認
```
yarn dev
```

### 公開用ページのビルド
- docsディレクトリに成果物を出力
```
yarn build
```

- SSLでエラーの場合は以下で対応できるかも
```
NODE_OPTIONS='--openssl-legacy-provider' yarn build
```
- docsディレクトリに成果物ができているので、mainブランチにコミットしてプッシュ 

## 演習環境
- AWSでのみ実施可能
### 演習環境構築

