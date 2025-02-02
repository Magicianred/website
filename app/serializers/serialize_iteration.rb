class SerializeIteration
  include Mandate

  def initialize(iteration, sideload: [])
    @iteration = iteration
    @sideload = sideload
  end

  def call
    return if iteration.blank?

    {
      uuid: iteration.uuid,
      submission_uuid: iteration.submission.uuid,
      idx: iteration.idx,
      status: iteration.status.to_s,
      num_essential_automated_comments: iteration.num_essential_automated_comments,
      num_actionable_automated_comments: iteration.num_actionable_automated_comments,
      num_non_actionable_automated_comments: iteration.num_non_actionable_automated_comments,
      submission_method: iteration.submission.submitted_via,
      created_at: iteration.created_at.iso8601,
      tests_status: iteration.submission.tests_status,
      representer_feedback: iteration.representer_feedback,
      analyzer_feedback: iteration.analyzer_feedback,
      is_published: iteration.published?,
      files: sideload.include?(:files) ? iteration.files.map do |file|
        {
          filename: file.filename,
          content: file.content,
          digest: file.digest
        }
      end : nil,
      links: {
        self: Exercism::Routes.track_exercise_iterations_url(iteration.track, iteration.exercise, idx: iteration.idx),
        solution: Exercism::Routes.track_exercise_url(iteration.track, iteration.exercise),
        files: Exercism::Routes.api_solution_submission_files_url(iteration.solution.uuid, iteration.submission)
      }
    }.compact
  end

  private
  attr_reader :iteration, :sideload
end
