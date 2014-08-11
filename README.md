to install imagemagick

brew install imagemagick -- with homebrew

for getting to the aws console
https://console.aws.amazon.com/iam/home

if nokogiri doesn't install, use
xcode-select --install 

USING REDIS:
installing most recent version of redis

go to: http://redis.io/download
	- get v 2.8.13

unzip the file
follow these terminal commands:
cd redis-2.8.13
make
cp src/redis-server src/redis-cli /usr/bin

then you should be good to go!

to start redis:
redis-server
