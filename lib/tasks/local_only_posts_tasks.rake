require 'fileutils'

namespace :local_only_posts do
  desc 'Apply local_only_posts gem JS and View overrides to Mastodon'
  task install: :environment do
    spec = Gem.loaded_specs['local_only_posts']
    abort 'local_only_posts gem not found' unless spec

    gem_root = spec.full_gem_path

    overrides = [
      # --------------------
      # JavaScript overrides
      # --------------------
      {
        label: 'JS',
        source_root: File.join(gem_root, 'app/javascript/local_only_posts/mastodon'),
        target_root: Rails.root.join('app/javascript/mastodon'),
        files: {
          'actions/compose.js' =>
            'actions/compose.js',

          'reducers/compose.js' =>
            'reducers/compose.js',

          'features/compose/components/compose_form.jsx' =>
            'features/compose/components/compose_form.jsx',

          'features/compose/containers/compose_form_container.js' =>
            'features/compose/containers/compose_form_container.js',

          'features/status/components/detailed_status.tsx' =>
            'features/status/components/detailed_status.tsx',

          # --- new files ---
          'features/compose/components/federated_dropdown.jsx' =>
            'features/compose/components/federated_dropdown.jsx',

          'features/compose/containers/federated_dropdown_container.js' =>
            'features/compose/containers/federated_dropdown_container.js'
        }
      },

      # --------------------
      # View overrides
      # --------------------
      {
        label: 'VIEW',
        source_root: File.join(gem_root, 'app/views'),
        target_root: Rails.root.join('app/views'),
        files: {
          'admin/shared/_status.html.haml' =>
            'admin/shared/_status.html.haml'
        }
      }
    ]

    puts "Applying local_only_posts frontend overrides..."

    overrides.each do |group|
      puts "\n#{group[:label]} overrides"

      group[:files].each do |source_rel, target_rel|
        source = File.join(group[:source_root], source_rel)
        target = File.join(group[:target_root], target_rel)

        unless File.exist?(source)
          puts "Missing source file: #{source_rel}"
          next
        end

        FileUtils.mkdir_p(File.dirname(target))
        FileUtils.cp(source, target)

        puts "Copied #{group[:label]}: #{target_rel}"
      end
    end

    # Create marker file after successful installation
    create_marker_file

    puts "\nlocal_only_posts has been successfully installed."
    puts "JS changes require `yarn build`.\nRun `yarn build:development` or `yarn build:production`"
  end

  private

  def create_marker_file
    marker_path = Rails.root.join('.local_only_posts_installed')
    File.write(marker_path, <<~CONTENT)
      # This file indicates that local_only_posts has been installed
      # Generated at: #{Time.current}
      # Do not delete this file unless you want to re-run the installation
    CONTENT
    puts "Created installation marker file: .local_only_posts_installed"
  end
end
