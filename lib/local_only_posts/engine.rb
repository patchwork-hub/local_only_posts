# frozen_string_literal: true

module LocalOnlyPosts
  class Engine < ::Rails::Engine
    isolate_namespace LocalOnlyPosts

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer 'local_only_posts.load_routes' do |app|
      app.routes.prepend do
        mount LocalOnlyPosts::Engine => "/", :as => :local_only_posts
      end
    end

    config.autoload_paths << File.expand_path("../app/services", __FILE__)
    config.autoload_paths << File.expand_path("../app/workers", __FILE__)

    # Enforce rake task execution before app startup
    initializer 'local_only_posts.enforce_rake_execution', before: :load_environment_config do |app|
      # Only enforce in specific environments and contexts
      next if Rails.env.test?
      next if defined?(Rails::Console)

      # Check if we're running rake tasks or other commands
      next if ARGV.any? { |arg|
        arg.match?(/\A(rake|db:|assets:|routes|notes|stats|middleware|runner|generate|g|destroy)\b/)
      }

      # Only check when starting the web server
      next unless ARGV.empty? || ARGV.any? { |arg| arg.match?(/\A(server|s)\z/) }

      marker_file = app.root.join('.local_only_posts_installed')

      unless marker_file.exist?
        error_message = <<~ERROR

          ================================================================
          LOCAL ONLY POSTS SETUP REQUIRED
          ================================================================

          The local_only_posts gem requires initial setup before the
          application can start.

          Please run the following command:

            bundle exec rake local_only_posts:install

          This will copy required frontend JS files and configure
          the Local-only-post system.

          ================================================================

        ERROR

        Rails.logger&.error(error_message)
        puts error_message

        # Prevent the application from starting
        exit(1)
      end
    end
  end
end
