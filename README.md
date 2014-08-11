<p>to install imagemagick</p>

<p>brew install imagemagick -- with homebrew</p>

<p>for getting to the aws console</p>
https://console.aws.amazon.com/iam/home

<p>if nokogiri doesn't install, use</p>
<strong>xcode-select --install</strong>

<h2>USING REDIS:<h2>
<p>installing most recent version of redis<p>

<p>go to: http://redis.io/download<p>
	<strong>- get v 2.8.13</strong>

<p>unzip the file</p>
<ul>follow these terminal commands:
<li>cd redis-2.8.13</li>
<li>make</li>
<li>cp src/redis-server src/redis-cli /usr/bin</li>
</ul>

<p>then you should be good to go!</p>

<h2>to start redis:<h2>
<p>redis-server<p>

<h2>To start Faye:</h2>
<p>rackup faye.ru -E production -s thin</p>