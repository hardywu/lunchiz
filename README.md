# Project Structure
The project incldues the back-end codebase with the front-end as its
git submodule in the folder `/front`. Please make sure to update the submodule
if you want to get both the frot-end and back-end codebase.

# Install Requirements
  * Ruby version: 2.5.3
  * System dependencies: Postgresql(>= 11),

# Configuration

# Database
```
# creation
bundle exec rails db:create db:migrate
# seed
bundle exec rails db:seed
```

# Test
```
bundle exec rails test
# or watching files or tests on fly
bundle exec guard
```

# Deployment
start the app
```
bundle exec rails s
```
Use whatever proxy (nginx/apache) if you want
