# LocalOnlyPosts

A Rails engine gem that adds "Local Only" post functionality to Mastodon, allowing users to create posts that are restricted to their local instance only and will not federate to other instances.

This gem extends Mastodon's posting system with a new visibility option that keeps posts confined to the local server. It includes frontend UI components, backend service modifications, and admin view extensions to support the local-only post feature throughout the application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'local_only_posts', git: 'https://github.com/patchwork-hub/local_only_posts.git'
```

And then execute:

```bash
bundle install
```

After installation, run the setup task:

```bash
bundle exec rake local_only_posts:install
```

Then rebuild your frontend assets:

```bash
yarn build:development  # or yarn build:production
```

## Features

### Post Creation
- **Federated/Local Toggle**: A dropdown in the compose form allowing users to choose between "Federated" (normal) and "Local Only" posting modes
- **Non-Federating Posts**: Posts marked as local-only stay on your instance and won't be shared with other servers
- **Edit Support**: The local-only setting can be changed when editing existing posts

### Admin Interface
- **Local-Only Indicator**: Admin status views display a visual indicator for posts that are local-only

### User Interface
- **Compose Form Integration**: Seamless dropdown integrated into the main compose form
- **Status Display**: Local-only posts show an indicator in detailed views

## API Endpoints

### Local Only Settings
```
GET /api/v1/local_only_posts/getLocalOnlySetting  # Retrieve user's local-only posting preference
```

### Status Creation (Extended)
The gem extends the existing Mastodon status endpoints to accept a `local_only` parameter:
```
POST /api/v1/statuses     # Create status (accepts local_only: boolean)
PUT  /api/v1/statuses/:id # Update status (accepts local_only: boolean)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

### Running Tests

```bash
bin/test
```

### Code Style

```bash
bin/rubocop
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patchwork-hub/local_only_posts. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/patchwork-hub/local_only_posts/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LocalOnlyPosts project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/patchwork-hub/local_only_posts/blob/main/CODE_OF_CONDUCT.md).
