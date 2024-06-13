# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false, unique: true |
| password           | string | null: false |
| nickname           | string | null: false |
| last-name          | string | null: false |
| first-name         | string | null: false |
| last-name-kana     | string | null: false |
| first-name-kana    | string | null: false |
| year               | integer | null: false |
| month              | integer | null: false |
| day                | integer | null: false |


### Association
has_many :items
has_many :comments



## items テーブル

| Column                  | Type        | Options     |
| ----------------------- | ------      | ----------- |
| user                    | references  | null: false,outside key |
| item-image              | references  | null: false,outside key |
| item-name               | string      | null: false |
| item-info               | text        | null: false |
| item-category           | string      | null: false |
| item-sales-status       | string      | null: false |
| item-category           | string      | null: false |
| item-shipping-fee-status| string      | null: false |
| prefecture              | string      | null: false,outside key |
| item-scheduled-delivery | string      | null: false |
| item-price              | integer     | null: false |


### Association
belong_to user
belong_to areas
belong_to orders
has_many comments



## orders テーブル

| Column         | Type        | Options     |
| ---------------| ------      | ----------- |
| postal-code    | string      | null: false |
| prefecture     | string      | null: false,outside key |
| city           | string      | null: false |
| addresses      | integer     | null: false |
| building       | integer     |             |
| phone-number   | integer     | null: false |


### Association
belong_to areas
belong_to items



##  prefectures テーブル

| Column         | Type        | Options     |
| ---------------| ------      | ----------- |
| prefecture     | string      | null: false |


### Association
belong_to areas
belong_to items



## comments テーブル

| Column             | Type        | Options     |
| ------------------ | ------      | ----------- |
| content            | text        | null: false |
| items              | references  | null: false,outside key |
| user               | references  | null: false,outside key |

### Association
belong_to user
belong_to items