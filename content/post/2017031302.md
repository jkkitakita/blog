+++
thumbnailImage = "/images/hugo.png"
coverImage = "//pixabay.com/get/e83db7062af21c2ad65a5854e24b4f97e471ebc818b5194897f9c27ca2e5_640.jpg"
date = "2017-03-12T13:39:17+09:00"
title = "HugoとGithub Pagesでブログ開設。新規投稿時の画像を引っ張ってくるシェルスクリプトを書いてみた。"
tags = ["hugo", "Github pages"]
categories = ["tech"]
metaAlignment = "center"
archives = ["","",""]
thumbnailImagePosition = "left"
isCJKLanguage = true

+++

## 1. 本記事のゴール

1. HugoとGithub Pagesを使って、ブログを開設する
2. 新規投稿時のシェルスクリプトを考える。

## 2. 前提

1. 私は、新卒二年目（もうすぐ、三年目）
2. インフラエンジニアをやった後、現在、スクラムマスター。
3. なので、そこまで、技術的な知識はない。

## 3. はじめていきましょう！

> 1. HugoとGithub Pagesを使って、ブログを開設する

### Hugo

![hugo](/images/hugo.png)

### Github Pages

{{< youtube 2MsN8gpT6jY >}}

もうここは
色々な方々がブログでまとめてくださっているので問題ないかなと。
yewtonさんの記事が参考になりそうです。
（参考にさせていただきました。ありがとうございます。）
https://www.yewton.net/2016/02/02/blog-with-hugo/

とりあえず、私のHugo + Github Pagesの構成は
[こちら](https://github.com/jkkitakita/blog "JK's memo")。

残課題として、ドメイン周りとか整理する必要があるかも？</br>
誰かアドバイスがあれば、お願いいたします。。。

```
~ ❯❯❯ dig jkkitakita.com

; <<>> DiG 9.8.3-P1 <<>> jkkitakita.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2013
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 4, ADDITIONAL: 8

;; QUESTION SECTION:
;jkkitakita.com.			IN	A

;; ANSWER SECTION:
jkkitakita.com.		300	IN	A	192.30.252.153
jkkitakita.com.		300	IN	A	192.30.252.154

;; AUTHORITY SECTION:
jkkitakita.com.		93078	IN	NS	ns-1622.awsdns-10.co.uk.
jkkitakita.com.		93078	IN	NS	ns-1310.awsdns-35.org.
jkkitakita.com.		93078	IN	NS	ns-708.awsdns-24.net.
jkkitakita.com.		93078	IN	NS	ns-191.awsdns-23.com.

;; ADDITIONAL SECTION:
ns-191.awsdns-23.com.	40099	IN	AAAA	2600:9000:5300:bf00::1
ns-708.awsdns-24.net.	38549	IN	AAAA	2600:9000:5302:c400::1
ns-1310.awsdns-35.org.	59218	IN	AAAA	2600:9000:5305:1e00::1
ns-1622.awsdns-10.co.uk. 66592	IN	AAAA	2600:9000:5306:5600::1
ns-191.awsdns-23.com.	40099	IN	A	205.251.192.191
ns-708.awsdns-24.net.	38549	IN	A	205.251.194.196
ns-1310.awsdns-35.org.	59218	IN	A	205.251.197.30
ns-1622.awsdns-10.co.uk. 46709	IN	A	205.251.198.86

;; Query time: 16 msec
;; SERVER: 2400:2410:8be2:1d00:1111:1111:1111:1111#53(2400:2410:8be2:1d00:1111:1111:1111:1111)
;; WHEN: Sun Mar 12 23:57:59 2017
;; MSG SIZE  rcvd: 377
```

{{< alert success >}}
#### memo

1. Hugo関連
  1. themeは、kakawaitさんのhugo-tranquilpeak-themeを使わせてもらった。
  https://themes.gohugo.io/hugo-tranquilpeak-theme/
  1. そのままだと、archivesページがうまく表示されなかったので、layout/taxonomy/archive.htmlを作成した。（themes/hugo-tranquilpeak-theme/layouts/taxonomy/archive.terms.htmlから複製）
  1. 日本語（ja）だとやっぱり色々だめかな。（ex.placeholderでないとか。）
  ↓は、にしておいた方が良さそう。
      1. `languageCode = "en-us"`
      1. `defaultContentLanguage = "en-us"`
1. ドメイン関連
  1. `192.30.252.153`、`192.30.252.154`は、Github Pagesのドメイン
  https://help.github.com/articles/setting-up-an-apex-domain/
  2. ドメインは、お名前.comで管理
  3. DNS関連は、AWS Route53。（Aレコード）

3. 残課題
  1. サブドメインの方が、Github Pagesとしては、良い？
  https://help.github.com/articles/about-supported-custom-domains/
  2. CDNの整備
  3. Hugoの知識不足。
  4. ネタ不足。笑
{{< /alert >}}

>2.新規投稿時のシェルスクリプトを考える。

なんかただ作成するだけだと寂しいから</br>
「綺麗な画像が欲しい！」と思って</br>
無料画像的なのを引っ張ってくるスクリプトつくってみた。</br>
（これダメだったら、誰か指摘してください。。笑）</br>

ざっくりやったことの流れ

1. pixabayにアカウント登録
2. APIkey発行
3. シェルの作成
  4. 記事作成（hugo new）
  5. curl で 画像を取得
  6. hugo用にワンライナーで整形
  7. sedで新規作成した記事へ挿入
8. 完成


```post.sh
#!bin/bash

num=`expr $RANDOM % 20`
DATE_TIME=`date '+%Y%m%d%H%M'`

hugo new post/$1.md
image=`curl 'https://pixabay.com/api/?key=${Key}&q=landscape&image_type=photo&pretty=true' | jq -r '.hits['$num'].webformatURL' | cut -c7-`

gsed -i -e "2i coverImage = \"$image\"" content/post/$DATE_TIME.md
gsed -i -e "2i thumbnailImage = \"$image\"" content/post/$DATE_TIME.md
```


{{< alert success >}}
#### memo

1. ランダムで20個生成する感じになっているが、同じ画像が出ることがある。
2. sedでうまくいかなかったので、gsedをinstallした。</br>
（参考）http://cross-black777.hatenablog.com/entry/2015/02/23/214337
3. そもそもブログの画像、ライセンス、著作権の勉強しないとかなと思った。</br>
"(/へ＼*)"))ｳｩ､ﾋｯｸ
4. Hugoさんのlogoは、なんかいけそうだと思ったので、使わせてもらいました。
{{< /alert >}}
