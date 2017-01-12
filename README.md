# LDAPR Client

A simple client to consume the LDAPR API

## Installation

Add this line to your Gemfile

    gem 'ldapr-client', git: "git@github.com:ifad/ldapr-client.git"

## Configuration

```ruby
  LDAPR::Client.configure do
    self.url = "http://ldapr.ifad.org/api/v1"
    self.client_name = "My client"
    self.http_options request_timeout: 15 # highly recommended for queries
  end
```

## Usage

LDAPR::Client uses Hawk to objectify queries and results:

```ruby
  TODO: usage example
```

.includes() and .order() are not supported. Ransack options are supported.

## Running specs

The vcr cassettes are not icluded, you need to have create an ldapr server running and create a .env.test file from the env.test.example template.

## Documentation

Run _rake doc_ to generate documentation under _doc_ folder

## Authors

Thimios Dimopulos (e.dimopoulos@ifad.org)

## Changelog

### 0.1.0

- Initial release
