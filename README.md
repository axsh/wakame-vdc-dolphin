# Dolphin

[![Gem Version](https://badge.fury.io/rb/wakame-dolphin.png)](http://badge.fury.io/rb/wakame-dolphin) [![Build Status](https://travis-ci.org/axsh/wakame-dolphin.png?branch=master)](https://travis-ci.org/axsh/wakame-dolphin) [![Code Climate](https://codeclimate.com/github/axsh/wakame-dolphin.png)](https://codeclimate.com/github/axsh/wakame-dolphin)

Dolphin is notification service.

### Install for production

Dolphin supported multi datastore are mysql and cassandra.

#### DataStore cassandra
```
$ bundle install --without test development mysql
```

#### DataStore mysql
```
$ bundle install --without test development cassandra
```

### Copy Settings File

```
$ cp -ip ./config/dolphin.conf.example ./config/dolphin.conf
```

### Edit config

```
$ vi ./config/dolphin.conf
```

./config/dolphin.conf
```
from=yourname@yourdomain
```

### Start Service

```
$ ./bin/dolphin_server
```

```
I, [2013-03-12T14:41:17.533784 #27820]  INFO -- : [11950120] [Dolphin::RequestHandler] Running on ruby 1.9.3 with selected Celluloid::TaskThread
I, [2013-03-12T14:41:17.533922 #27820]  INFO -- : [11950120] [Dolphin::RequestHandler] Listening on http://127.0.0.1:9004
```

### Add Notification

```
$ MAIL_TO=example@example.com ruby ./example/client/put_notification.rb
```

### Add Event

```
$ ruby ./example/client/post_event.rb
```

### Tempolary mail

```
$ ls ./tmp/mails
```

### Run Test Case

```
$ bundle exec rake spec
```

### License

Copyright (c) Axsh Co. Components are included distribution under LGPL 3.0 and Apache 2.0
