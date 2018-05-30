module Roadmap

  def get_roadmap(roadmap_id)
    response = self.class.get(api_url("roadmaps/#{roadmap_id}"), headers: { "authorization" => @auth_token})
    @roadmaps = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_url("checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token})
    @checkpoints = JSON.parse(response.body)
  end

  def get_remaining_checkpoints(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id = @enrollment_id)
    response = self.class.post(api_url("checkpoints"),
      body: {
        checkpoint_id: checkpoint_id,
        assignment_branch: assignment_branch,
        assignment_commit_link: assignment_commit_link,
        comment: comment,
        enrollment_id: @enrollent_id
      },
      headers: { "authorization" => @auth_token })
    JSON(response.body)
  end
end
