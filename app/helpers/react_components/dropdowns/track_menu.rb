module ReactComponents
  module Dropdowns
    class TrackMenu < ReactComponent
      initialize_with :track

      def to_s
        super("dropdowns-track-menu", {
          track: {
            title: track.title
          },
          links: links
        })
      end

      private
      def links
        {
          repo: track.repo_url,
          documentation: track.documentation_url
        }
      end
    end
  end
end
