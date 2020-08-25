# D-SHARE
![dshare](https://user-images.githubusercontent.com/54488985/90948026-9d532580-e475-11ea-845d-f1bacbcbbfc5.png)
# 概要
ruby on railsを独習したので、その成果物として作成いたしました。日々の日記を世界中の人々とシェアすることのできるサービスです。
# URL
http://dshare-ecs-lb-1191990191.ap-northeast-1.elb.amazonaws.com/
# 使用技術
- Ruby 2.3.6
- Ruby on Rails 5.0.7
- JavaScript (jQuery)
- AWS (ECS, ECR, EC2, RDS for MySQL, VPC, ALB, S3)
- Docker/docker-compose
- CircleCI (CI)
- Nginx, Puma
- RSpec
- Git, GitHub
# ネットワーク構成図
![ca 001](https://user-images.githubusercontent.com/54488985/91167403-deb23200-e70e-11ea-84c0-386490d16f86.jpeg)
# ER図
![ER図 ](https://user-images.githubusercontent.com/54488985/90948744-e78bd500-e47c-11ea-91d4-694dc75963ca.jpg)
# 機能一覧
- ログイン・ログアウト・ゲストログイン
- パスワード再設定、ユーザー画像再設定機能
- 記事投稿・編集・削除機能
- コメント投稿・削除機能
- 記事に対するタグ付け機能
- 記事に対するいいね機能（非同期通信）・いいねした記事一覧
- フォロー機能（非同期通信）・フォロー、フォロワー一覧機能
- タグによる記事絞り込み機能
- ユーザーによる記事絞り込み機能
- ページネーション ( kaminari )