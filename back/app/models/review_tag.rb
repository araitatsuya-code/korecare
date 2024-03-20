# ## Schema Information
#
# Table name: `review_tags`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`review_id`**   | `bigint`           | `not null`
# **`tag_id`**      | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_review_tags_on_review_id`:
#     * **`review_id`**
# * `index_review_tags_on_tag_id`:
#     * **`tag_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`review_id => reviews.id`**
# * `fk_rails_...`:
#     * **`tag_id => tags.id`**
#
class ReviewTag < ApplicationRecord
  belongs_to :review
  belongs_to :tag
end
