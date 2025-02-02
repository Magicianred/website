module ReactComponents
  module Journey
    class JourneyPage < ReactComponent
      initialize_with :default_category_id

      def to_s
        super("journey-journey-page", {
          categories: categories,
          default_category: default_category_id
        })
      end

      private
      def solution_category
        if default_category_id == "solutions"
          options = {
            initial_data: SerializePaginatedCollection.(
              Solution::SearchUserSolutions.(current_user),
              serializer: SerializeSolutions,
              serializer_args: [current_user]
            )
          }
        else
          options = {}
        end

        {
          id: "solutions",
          title: "Solutions",
          request: {
            endpoint: Exercism::Routes.api_solutions_url,
            options: options
          },
          path: Exercism::Routes.solutions_journey_path,
          icon: "editor"
        }
      end

      def reputation_category
        if default_category_id == "reputation"
          tokens = User::ReputationToken::Search.(current_user)

          data = tokens.map do |token|
            token.rendering_data.merge(
              links: {
                mark_as_seen: Exercism::Routes.mark_as_seen_api_reputation_url(token.uuid)
              }
            )
          end

          options = {
            initial_data: SerializePaginatedCollection.(
              tokens,
              data: data,
              meta: {
                links: {
                  tokens: Exercism::Routes.reputation_journey_url
                },
                total_reputation: current_user.formatted_reputation,
                is_all_seen: current_user.reputation_tokens.unseen.empty?
              }
            )
          }
        else
          options = {}
        end

        {
          id: "reputation",
          title: "Reputation",
          request: {
            endpoint: Exercism::Routes.api_reputation_index_url,
            options: options
          },
          path: Exercism::Routes.reputation_journey_path,
          icon: "reputation"
        }
      end

      def overview_category
        {
          id: "overview",
          title: "Overview",
          request: {},
          path: Exercism::Routes.journey_path,
          icon: "overview"
        }
      end

      def badges_category
        if default_category_id == "badges"
          options = {
            initial_data: SerializePaginatedCollection.(
              User::AcquiredBadge::Search.(current_user, order: :unrevealed_first),
              serializer: SerializeUserAcquiredBadges
            )
          }
        else
          options = {}
        end

        {
          id: "badges",
          title: "Badges",
          request: {
            endpoint: Exercism::Routes.api_badges_url,
            options: options
          },
          path: Exercism::Routes.badges_journey_path,
          icon: "badges"
        }
      end

      def categories
        [overview_category, solution_category, reputation_category, badges_category]
      end
    end
  end
end
