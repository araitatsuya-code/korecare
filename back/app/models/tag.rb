# ## Schema Information
#
# Table name: `tags`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`tag_name`**    | `string`           |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
class Tag < ApplicationRecord
  has_many :review_tags
  has_many :reviews, through: :review_tags
end
