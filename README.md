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

### Association

- has_many :items
- has_many :purchases

##商品情報
##itemsテーブル

|Column            |Type      |Options    |
|------------------|----------|-----------|
|title             |string    |null: false|
|detail            |text      |null: false|
|category_id       |integer   |null: false|
|condition_id      |integer   |null: false|
|shipping_charge_id|integer   |null: false|
|prefecture_id     |integer   |null: false｜
|shipping_day_id   |integer   |null: false|
|price             |integer   |null: false|
|user              |references|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :purchase

##購入記録
##purchasesテーブル

|Column   |Type      |Options                       |
|---------|----------|------------------------------|
|item     |references|null: false, foreign_key: true|
|user     |references|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :address

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
|purchase      |references|null: false, foreign_key: true|

### Association

- belongs_to :purchase
