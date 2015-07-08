## Step 1 - Initial Build and Push

We start with a fresh docker and build the image. This is going to pull the Ruby base image, and build a number of additional layers.

```console
$ boot2docker delete && boot2docker init && boot2docker start
$ make
docker build -t ejholmes/docker-slow .
Sending build context to Docker daemon 7.168 kB
Sending build context to Docker daemon
Step 0 : FROM ruby:2.2.2
2.2.2: Pulling from ruby
64e5325c0d9d: Pull complete
bf84c1d84a8f: Pull complete
87de57de6955: Pull complete
6a974bea7c0d: Pull complete
5a97b097c6e0: Pull complete
5f4f8ee0980f: Pull complete
48a45cf3c1b3: Pull complete
78e2011c894a: Pull complete
d45e4ad7ff24: Pull complete
ed3d295a9094: Pull complete
5df0b7777234: Pull complete
82bc5c9de744: Pull complete
22069f06dab4: Pull complete
c5623821e93c: Pull complete
42644941899f: Pull complete
a1ed99fd54db: Already exists
ruby:2.2.2: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Digest: sha256:0d74e28f091e14d88413db9bbeb476bf78585f7fef3a1b7e93589cf0e587ce3f
Status: Downloaded newer image for ruby:2.2.2
 ---> a1ed99fd54db
Step 1 : MAINTAINER Eric Holmes
 ---> Running in e384d8ec483f
 ---> 325a020a03fe
Removing intermediate container e384d8ec483f
Step 2 : RUN bundle config --global frozen 1
 ---> Running in 2cd39905b584
 ---> d7c381aacf5a
Removing intermediate container 2cd39905b584
Step 3 : RUN mkdir -p /home/app
 ---> Running in 00f089de5ec1
 ---> d89cf5d79288
Removing intermediate container 00f089de5ec1
Step 4 : WORKDIR /home/app
 ---> Running in 9bdbe201185d
 ---> f845e91cae5f
Removing intermediate container 9bdbe201185d
Step 5 : COPY Gemfile /home/app/
 ---> db610d02f72f
Removing intermediate container 2c9503b9eb48
Step 6 : COPY Gemfile.lock /home/app/
 ---> d826037ad53e
Removing intermediate container 0f2ed2dbfdce
Step 7 : RUN bundle install --jobs 4 --retry 3  --without development test unit features
 ---> Running in dce818e13b5c
Don't run Bundler as root. Bundler can ask for sudo if it is needed, and
installing your bundle as root will break this application for all non-root
users on this machine.
Using rake 10.4.2
Using bundler 1.10.5
Bundle complete! 1 Gemfile dependency, 2 gems now installed.
Gems in the groups development, test, unit and features were not installed.
Bundled gems are installed into /usr/local/bundle.
 ---> d875f4387b6a
Removing intermediate container dce818e13b5c
Step 8 : COPY . /home/app
 ---> 1868017f146d
Removing intermediate container 1c39a73c9a3a
Step 9 : CMD bundle exec rails console
 ---> Running in f62a9510b351
 ---> e1e8cd543876
Removing intermediate container f62a9510b351
Successfully built e1e8cd543876
$ docker history ejholmes/docker-slow
IMAGE               CREATED             CREATED BY                                      SIZE
e1e8cd543876        5 minutes ago       /bin/sh -c #(nop) CMD ["bundle" "exec" "rails   0 B
1868017f146d        5 minutes ago       /bin/sh -c #(nop) COPY dir:a3c68abfd4a936a68e   693 B
d875f4387b6a        5 minutes ago       /bin/sh -c bundle install --jobs 4 --retry 3    887 B
d826037ad53e        5 minutes ago       /bin/sh -c #(nop) COPY file:0b6280704a6fc4d04   126 B
db610d02f72f        5 minutes ago       /bin/sh -c #(nop) COPY file:9e8416a559e63e8f2   42 B
f845e91cae5f        5 minutes ago       /bin/sh -c #(nop) WORKDIR /home/app             0 B
d89cf5d79288        5 minutes ago       /bin/sh -c mkdir -p /home/app                   0 B
d7c381aacf5a        5 minutes ago       /bin/sh -c bundle config --global frozen 1      92 B
325a020a03fe        5 minutes ago       /bin/sh -c #(nop) MAINTAINER Eric Holmes        0 B
a1ed99fd54db        8 days ago          /bin/sh -c #(nop) CMD ["irb"]                   0 B
42644941899f        8 days ago          /bin/sh -c #(nop) ENV BUNDLE_APP_CONFIG=/usr/   0 B
c5623821e93c        8 days ago          /bin/sh -c gem install bundler --version "$BU   1.125 MB
22069f06dab4        8 days ago          /bin/sh -c #(nop) ENV BUNDLER_VERSION=1.10.5    0 B
82bc5c9de744        8 days ago          /bin/sh -c #(nop) ENV PATH=/usr/local/bundle/   0 B
5df0b7777234        8 days ago          /bin/sh -c #(nop) ENV GEM_HOME=/usr/local/bun   0 B
ed3d295a9094        8 days ago          /bin/sh -c echo 'gem: --no-rdoc --no-ri' >> "   23 B
d45e4ad7ff24        8 days ago          /bin/sh -c apt-get update                       && apt-get install   98.72 MB
78e2011c894a        8 days ago          /bin/sh -c #(nop) ENV RUBY_DOWNLOAD_SHA256=5f   0 B
48a45cf3c1b3        8 days ago          /bin/sh -c #(nop) ENV RUBY_VERSION=2.2.2        0 B
5f4f8ee0980f        8 days ago          /bin/sh -c #(nop) ENV RUBY_MAJOR=2.2            0 B
5a97b097c6e0        9 days ago          /bin/sh -c apt-get update && apt-get install    312.3 MB
6a974bea7c0d        3 weeks ago         /bin/sh -c apt-get update && apt-get install    122.3 MB
87de57de6955        3 weeks ago         /bin/sh -c apt-get update && apt-get install    44.36 MB
bf84c1d84a8f        3 weeks ago         /bin/sh -c #(nop) CMD ["/bin/bash"]             0 B
64e5325c0d9d        3 weeks ago         /bin/sh -c #(nop) ADD file:085531d120d9b9b091   125.2 MB
```
