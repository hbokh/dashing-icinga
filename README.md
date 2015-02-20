# Docker Dashing Icinga

[Dashing](https://shopify.github.io/dashing/) is a dashboard framework made in Ruby.  
In this combo of Docker, Dashing and [Icinga](https://www.icinga.org/), you will get a monitoring-dashboard, that will look best on 1080p screens.  

![image](https://github.com/lazyfrosch/dashing-icinga/raw/master/screenshot.png)

"Docker Dashing Icinga" is based on these two projects, but I couldn't fork them both and merge 'em into one:  
- [frvi/dockerfile-dashing](https://github.com/frvi/dockerfile-dashing) - tack, Fredrik Vihlborg
- [lazyfrosch/dashing-icinga](https://github.com/lazyfrosch/dashing-icinga) - danke, Markus Frosch

Also, to make it work with an HTTPS-enabled Icinga-instance, [this post](http://www.stefreitag.de/wp/2014/08/08/dashing-icinga/) provided some information.

## Build

You **need** a local copy of the repository, because of the assets, jobs and configuration that are mounted into the container! Have a look at the code first, if you don't trust things.  

`git clone https://github.com/hbokh/dashing-icinga.git .`

Next build the image:  

`docker build --rm=true -t hbokh/dashing-icinga .`

Or fetch it from the hub:

`docker pull hbokh/dashing-icinga`


## Run

Use [fig](http://fig.sh/) and `fig up -d`  
But first you need to change these values in file `fig.yml`:  

- **ICINGA_CGI**: URL to icinga-host's status.cgi
- **ICINGA_USER**: your icinga username
- **ICINGA_PASS**: your icinga user's password
- **TWITTER_KEY**: Twitter key
- **TWITTER_SECRET**: Twitter password for that key
- **TWITTER_TOKEN**: Twitter token
- **TWITTER_TOKEN_SECRET**: Twitter password for that token

Get your Twitter key and tokens here: https://dev.twitter.com/docs/auth/tokens-devtwittercom

Also change the path to where you forked this repo in the volumes-section.

```
dashing:
  image: hbokh/dashing-icinga
  environment:
   - ICINGA_CGI=https://icinga-hostname/icinga/cgi-bin/status.cgi
   - ICINGA_USER=icingaadmin
   - ICINGA_PASS=p4ssw0rd
   - TWITTER_KEY=dYMXPkBLAHBLAHfhur2LhrF1a
   - TWITTER_SECRET=5DoD1SiwYZG2xBLAHBLAHBmwBi0szV4Dy3DBLAHBLAH54xGAkO
   - TWITTER_TOKEN=7162341-kAjNJ1BLAHBLAHhunfY7w1l7UWNXBLAHBLAH6hywI6
   - TWITTER_TOKEN_SECRET=4uPyGsWBLAHBLAHBDmMs5RzzgnKQDBLAHBLAHmevwZOSfW
  volumes:
    - /Users/hbokh/dev/Docker/dashing-icinga/dashboards:/dashboards
    - /Users/hbokh/dev/Docker/dashing-icinga/jobs:/jobs
    - /Users/hbokh/dev/Docker/dashing-icinga/assets:/assets
    - /Users/hbokh/dev/Docker/dashing-icinga/widgets:/widgets
    - /Users/hbokh/dev/Docker/dashing-icinga/config:/config
  ports:
    - "8080:3030"
```
**Note:**  the above Twitter-keys have been obfuscated with `BLAHBLAH`'s and will **not** work. **CHANGE THEM!!**

## Connect

Once the container is up, you can connect to the dashboard over HTTP.  
URL: http://`< dockerhost >`:8080/icinga, e.g. http://boot2docker:8080/icinga

## Todo

Rearrange the widgets or add some more. I don't like the large grayspace on the right.

## Other

Tested on Ubuntu 14.04, CoreOS and OS X Yosemite 10.10.2
