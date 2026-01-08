module LocalOnlyPosts::UpdateStatusServiceExtension

  private

  def broadcast_updates!
    DistributionWorker.perform_async(@status.id, { 'update' => true })
    ActivityPub::StatusUpdateDistributionWorker.perform_async(@status.id) unless @status.local_only?
  end
end
