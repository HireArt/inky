# Inky ![Inky](https://www.filepicker.io/api/file/iJnQeMi9RlGjpAQB10gu/convert?h=35) [![Build Status](https://img.shields.io/travis/HireArt/inky.svg)](https://travis-ci.org/HireArt/inky) [![Code Climate](https://img.shields.io/codeclimate/github/HireArt/inky.svg)](https://codeclimate.com/github/HireArt/inky) [![Test Coverage](https://img.shields.io/codeclimate/coverage/github/HireArt/inky.svg)](https://codeclimate.com/github/HireArt/inky/coverage)


A ruby client for [filepicker.io](http://filepicker.io). Built on top of the Filepicker
[REST API](https://developers.filepicker.io/docs/web/rest/).

### Installation

Add this to your Gemfile:

```
gem 'inky'
```

### Basic Usage

To view information about an existing Filepicker file:

```ruby
file = Inky::File.new('hFHUCB3iTxyMzseuWOgG')
file.uid
file.md5
file.mimetype
file.uploaded_at # converted to Time object
file.container
file.writeable
file.filename
file.location
file.key
file.path
file.size
file.url

file.metadata # hash of all available metadata
```

### Storing files

First, authorize your Filepicker account. You must have a paid plan for cloud storage to work.

```ruby
Inky.authorize! 'MyApiKey1234455665'
```

To upload a local file:

```ruby
Inky::File.from_file(File.open('my_file.png')).save!

# this is equivalent to:
file = Inky::File.new
file.local_file = File.open('my_file.png')
file.save!
```

To save from a URL:

```ruby
Inky::File.from_url('http://example.com/my_file.png').save!

# this is equivalent to:
file = Inky::File.new
file.remote_url = 'http://example.com/my_file.png'
file.save!
```

### Configuration

`file#save` accepts several options:

```ruby
file.save! location: 'S3', # Other options include 'azure', 'rackspace', 'dropbox'
           filename: 'my_cool_file.ogg',
           mimetype: 'application/ogg',
           path: '/my_cool_files/1234.png', # path to store on cloud storage
           container: 'myapp-development', # container/bucket on cloud storage
           access: 'public' # defaults to 'private'
```

### Updating an existing file

`file.save!` can be used to update an existing file with new content from a local file or url:

```ruby
file = Inky::File.new('hFHUCB3iTxyMzseuWOgG')
file.local_file = File.open('my_new_file.ogg')
file.save!

file = Inky::File.new('hFHUCB3iTxyMzseuWOgG')
file.remote_url = 'http://example.com/my_new_file.ogg'
file.save!
```

### Contributing

* Check the issue tracker. If nothing exists, add a new issue to track your contributions.
* Fork the project and create a new branch for your bugfix.
* Write your contribution.
* Add tests, ensuring good code coverage.
* Submit a pull request.

To add or update tests involving file uploads, you will need your own paid Filepicker account,
and will need to add a `.env` file at the root of the project with the following line:

```
FILEPICKER_API_KEY: <YOUR_FILEPICKER_API_KEY>
```

### Todo

* Support security policies
* Support basic/temporary FP uploads (without S3/cloud storage)
