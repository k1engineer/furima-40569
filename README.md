##ユーザー情報
##usersテーブル

|Column            |Type  |Options    |
|------------------|------|-----------|
|nickname          |string|null: false|
|email             |string|null: false, unique: true|
|encrypted_password|string|null: false|
|last_name         |string|null: false|
|first_name        |string|null: false|
|last_name_kana    |string|null: false|
|first_name_kana   |string|null: false|
|birth_date        |date  |null: false|

##商品情報
##itemsテーブル

|Column            |Type      |Options    |
|------------------|----------|-----------|
|title             |string    |null: false|
|detail            |text      |null: false|
|category_id       |integer   |null: false, foreign_key: true|
|condition_id      |integer   |null: false, foreign_key: true|
|shipping_charge_id|integer   |null: false, foreign_key: true|
|prefecture_id     |integer   |null: false, foreign_key: true|
|shipping_days_id  |integer   |null: false, foreign_key: true|
|price             |integer   |null: false|
|user_id           |references|null: false, foreign_key: true|

##購入記録
##purchasesテーブル

|Column   |Type      |Options                       |
|---------|----------|------------------------------|
|item_id  |references|null: false, foreign_key: true|
|user_id  |references|null: false, foreign_key: true|

##発送先情報
##addressesテーブル

|Column        |Type   |Options    |
|--------------|-------|-----------|
|post_code     |string |null: false|
|prefecture_id |integer|null: false, foreign_key: true|
|municipality  |string |null: false|
|street_address|string |null: false|
|building_name |string |           |
|tel_number    |string |null: false|


