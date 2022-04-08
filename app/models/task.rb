# frozen_string_literal: true

# ## Schema Information
#
# Table name: `tasks`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`user_id`**      | `integer`          | `not null`
# **`title`**        | `string`           |
# **`description`**  | `text`             |
# **`done`**         | `boolean`          | `default(FALSE), not null`
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_tasks_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `user_id`:
#     * **`user_id => users.id`**
#
class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
end
