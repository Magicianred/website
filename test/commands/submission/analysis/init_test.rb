require 'test_helper'

class Submission::Analysis::InitTest < ActiveSupport::TestCase
  test "calls to publish_message" do
    solution = create :concept_solution
    exercise_repo = Git::Exercise.for_solution(solution)
    submission = create :submission, solution: solution
    create :submission_file, submission: submission, filename: "log_line_parser.rb" # Override old file
    create :submission_file, submission: submission, filename: "subdir/new_file.rb" # Add new file
    create :submission_file, submission: submission, filename: "log_line_parser_test.rb" # Don't override tests
    create :submission_file, submission: submission, filename: "special$chars.rb" # Don't allow special chars
    create :submission_file, submission: submission, filename: ".meta/config.json" # Don't allow meta

    ToolingJob::Create.expects(:call).with(
      :analyzer,
      submission.uuid,
      solution.track.slug,
      solution.exercise.slug,
      source: {
        submission_efs_root: submission.uuid,
        submission_filepaths: ["log_line_parser.rb", "subdir/new_file.rb"],
        exercise_git_repo: "ruby",
        exercise_git_sha: exercise_repo.synced_git_sha,
        exercise_git_dir: exercise_repo.dir,
        exercise_filepaths: [".meta/config.json", ".meta/design.md", ".meta/exemplar.rb"]
      }
    )
    Submission::Analysis::Init.(submission)
  end
end
