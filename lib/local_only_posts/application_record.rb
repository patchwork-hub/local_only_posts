# frozen_string_literal: true

module LocalOnlyPosts
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
