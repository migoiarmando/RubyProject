# Rails Blog CRUD Application

A simple Ruby on Rails application demonstrating CRUD (Create, Read, Update, Delete) operations for blog posts. The application includes both a web UI and a REST API.

## Features

- **Web UI**: Full-featured HTML interface for managing blog posts
- **REST API**: JSON API endpoints for programmatic access
- **CRUD Operations**: Create, read, update, and delete blog posts
- **Validations**: Ensures title and content are present

## Prerequisites

- Ruby 3.2.0 or higher
- Bundler gem
- SQLite3

## Setup

1. Install dependencies:

   ```bash
   bundle install
   ```

2. Create the database and run migrations:

   ```bash
   rails db:create
   rails db:migrate
   ```

3. Start the Rails server:

   ```bash
   rails server
   ```

4. Open your browser and visit:
   ```
   http://localhost:3000
   ```

## Web UI Routes

- `GET /posts` - List all posts
- `GET /posts/new` - Form to create a new post
- `POST /posts` - Create a new post
- `GET /posts/:id` - View a single post
- `GET /posts/:id/edit` - Form to edit a post
- `PATCH /posts/:id` - Update a post
- `DELETE /posts/:id` - Delete a post

## API Routes (JSON)

All API endpoints return JSON and are prefixed with `/api`:

- `GET /api/posts` - List all posts
- `GET /api/posts/:id` - Get a single post
- `POST /api/posts` - Create a new post
- `PATCH /api/posts/:id` - Update a post
- `DELETE /api/posts/:id` - Delete a post

### API Examples

#### Create a Post

```bash
curl -X POST http://localhost:3000/api/posts \
  -H "Content-Type: application/json" \
  -d '{"post":{"title":"My First Post","content":"This is the content of my first post."}}'
```

#### Get All Posts

```bash
curl http://localhost:3000/api/posts
```

#### Get a Single Post

```bash
curl http://localhost:3000/api/posts/1
```

#### Update a Post

```bash
curl -X PATCH http://localhost:3000/api/posts/1 \
  -H "Content-Type: application/json" \
  -d '{"post":{"title":"Updated Title","content":"Updated content."}}'
```

#### Delete a Post

```bash
curl -X DELETE http://localhost:3000/api/posts/1
```

## Project Structure

```
.
├── app/
│   ├── controllers/
│   │   ├── posts_controller.rb      # Web UI controller
│   │   └── api/
│   │       └── posts_controller.rb  # API controller
│   ├── models/
│   │   └── post.rb                  # Post model with validations
│   └── views/
│       └── posts/                   # View templates
├── config/
│   └── routes.rb                    # Route definitions
├── db/
│   └── migrate/                     # Database migrations
└── README.md
```

## Database

The application uses SQLite3 by default. The database files are stored in the `db/` directory:

- `db/development.sqlite3` - Development database
- `db/test.sqlite3` - Test database
- `db/production.sqlite3` - Production database

## License

This is a sample project for educational purposes.
