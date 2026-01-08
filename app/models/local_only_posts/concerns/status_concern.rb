# frozen_string_literal: true

module LocalOnlyPosts::Concerns::StatusConcern
  extend ActiveSupport::Concern

  included do
    scope :without_local_only, -> { where(local_only: [false, nil]) }
    before_create :set_locality
  end

  def local_only?
    local_only
  end

  private

  def set_locality
    self.local_only = reblog.local_only if reblog?
  end
end
