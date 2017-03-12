+++
thumbnailImage = "//pixabay.com/get/e83db7062af21c2ad65a5854e24b4f97e471ebc818b5194897f9c27ca2e5_640.jpg"
coverImage = "//pixabay.com/get/e83db7062af21c2ad65a5854e24b4f97e471ebc818b5194897f9c27ca2e5_640.jpg"
date = "2017-03-12T13:39:17+09:00"
title = "Hugo/Github Pagesでブログ開設。また、新規投稿時のシェルスクリプトを書いてみた。"
tags = ["hugo", "Github pages"]
categories = ["tech"]
metaAlignment = "center"
archives = ["","",""]
thumbnailImagePosition = "left"

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

これはもう
色々な方々がブログでまとめてくださっているので問題ないかなと。
とりあえず↓が私のブログ

https://github.com/jkkitakita/blog

yewtonさんのが参考になりそうです。

https://www.yewton.net/2016/02/02/blog-with-hugo/

残課題として、ドメイン周りとか整理する必要があるかも？

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
1. `192.30.252.153`、`192.30.252.154`は、Github Pagesのドメイン
https://help.github.com/articles/setting-up-an-apex-domain/
2. ドメインは、お名前.comで管理
3. DNS関連は、AWS Route53。（Aレコード）
4. 残課題として、サブドメインの方が、Github Pagesとしては、良い？
https://help.github.com/articles/about-supported-custom-domains/
{{< /alert >}}
