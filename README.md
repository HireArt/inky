# Inky ![Inky](https://www.filepicker.io/api/file/iJnQeMi9RlGjpAQB10gu/convert?h=35)

A ruby client for [filepicker.io](http://filepicker.io). Built on top of the Filepicker
[REST API](https://developers.filepicker.io/docs/web/rest/).

### Installation

Add this to your gemfile.rb:

```
gem 'inky'
```

### Basic Usage

How to view information about existing files.

```ruby
file = Inky::File.new('hFHUCB3iTxyMzseuWOgG')
file.uid
file.md5
file.mimetype
file.uploaded_at
file.container
file.writeable
file.filename
file.location
file.key
file.path
file.size

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

```ruby
# file#save accepts several options:
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
# Updating an existing file
file = Inky::File.new('hFHUCB3iTxyMzseuWOgG')
file.local_file = File.open('my_new_file.ogg')
file.save!

file = Inky::File.new('hFHUCB3iTxyMzseuWOgG')
file.remote_url = 'http://example.com/my_new_file.ogg'
file.save!
```

### Todo

* Support security policies
* Support basic/temporary FP uploads (without S3/cloud storage)
