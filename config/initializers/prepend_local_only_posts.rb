# frozen_string_literal: true

Rails.application.config.to_prepare do
  REST::StatusSerializer.include(LocalOnlyPosts::StatusSerializerExtension)
  PostStatusService.prepend(LocalOnlyPosts::PostStatusServiceExtension)
  ReblogService.prepend(LocalOnlyPosts::ReblogServiceExtension)
  UpdateStatusService.prepend(LocalOnlyPosts::UpdateStatusServiceExtension)
  Status.include(LocalOnlyPosts::Concerns::StatusConcern)
  Api::V1::StatusesController.prepend(LocalOnlyPosts::Api::V1::StatusesControllerExtension)
end
