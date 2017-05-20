## 本ブログの構成

http://jkkitakita.com

1. Concept
  1. 自分の人生のメモを通して、社会に貢献すること
2. Category
  1. mylife ：私の人生
  2. tech： 技術系
3. Tag
  - 主に、Mylifeで使用するTag
    1. philosophy： 課題
    2. dialy： 日記
    3. moyamoya： 何だか、もやもやしていること
  - 主に、Techで使用するTag
    1. 技術要素毎

## 新規投稿手順

1. 新規記事作成
```
$ hugo new post/YYYYMMDD.md
```
2. 1.で生成したmdファイルを編集（記事編集）
3. ローカルでサーバー起動して、確認
```
$ hugo server
# ブラウザから、http://localhost:1313 にアクセス
```
4. 完成したら、コミットして、リモートにpush
5. 下記コマンドを実行して、投稿
```
$ ./deploy.sh
```
5. 自分の記事が更新されていることを確認
http://jkkitakita.com
