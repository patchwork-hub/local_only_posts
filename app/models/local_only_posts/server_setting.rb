# frozen_string_literal: true

require 'local_only_posts/application_record'

module LocalOnlyPosts
  class ServerSetting < ApplicationRecord
    self.table_name = 'server_settings'

    validates :optional_value, presence: true, allow_nil: true

    belongs_to :parent, class_name: "LocalOnlyPosts::ServerSetting", optional: true
    has_many :children, class_name: "LocalOnlyPosts::ServerSetting", foreign_key: "parent_id"
  end
end
