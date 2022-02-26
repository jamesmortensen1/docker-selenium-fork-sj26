# ARCHIVED

For the most up to date multi-arch container images, please see [seleniumhq-community/docker-seleniarm](https://github.com/seleniumhq-community/docker-seleniarm).  This repo and information below is kept for historical and reference purposes.

----

# Multi-arch Docker images for the Selenium Grid Server

This is a fork of the [official selenium docker images][official] with
highly experimental multi-arch support for Chromium and Firefox.

  [official]: https://github.com/SeleniumHQ/docker-selenium

## Quick start

1. Start a Docker container with Firefox

``` bash
$ docker run -d -p 4444:4444 --shm-size 2g seleniarm/standalone-firefox
# OR
$ docker run -d -p 4444:4444 -v /dev/shm:/dev/shm seleniarm/standalone-firefox
```

2. Point your WebDriver tests to http://localhost:4444/wd/hub

3. That's it! 

To inspect visually the browser activity, see the [Debugging](#debugging) section for details.

## Standalone

![Firefox](https://raw.githubusercontent.com/alrra/browser-logos/main/src/firefox/firefox_24x24.png) Firefox 
``` bash
$ docker run -d -p 4444:4444 -v /dev/shm:/dev/shm seleniarm/standalone-firefox
```

![Chromium](https://raw.githubusercontent.com/alrra/browser-logos/main/src/chromium/chromium_24x24.png) Chromium
``` bash
$ docker run -d -p 4444:4444 -v /dev/shm:/dev/shm seleniarm/standalone-chromium
```

## Recreating the images

Making sure you are logged into the registry and have the permissions to push images, otherwise the process will fail.

In order to recreate all images and push them to your registry, run:

```sh
NAME=container-registry make all
```

Replace `container-registry` with the container registry you want to push images into.

If you just want to recreate a specific image (e.g., standalone_chromium), run:

```sh
NAME=container-registry make standalone_chromium
```

## Set Chromium version

If you want to set a specific Chromium version, update [this file](./NodeChromium/Dockerfile.txt) and replace the `<chromium-version> below:

```dockerfile
RUN echo "deb http://http.us.debian.org/debian/ testing non-free contrib main" >> /etc/apt/sources.list \
  && apt-get update -qqy \
  && apt-get -qqy install chromium=<chromium-version> \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
```

You can find the available versions [here](https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=names&keywords=chromium) or just remove the version altogether to let the most recent version be installed.

After that, you need to [recreate the images](#recreating-the-images).

## Only Building the Images

If you want to build the images locally, without pushing to any registry, then use the build.sh script in the root of the project directory.

The Standalone folder is the base for all Standalone${browser} images and includes a script that starts the selenium server in standalone mode. 
The NodeBase folder is the base for all Node${browser} images and includes a script that starts the selenium server in node mode.

Inside build.sh are environment variables which are used to tag the built images. If changing the Selenium version, note that you must also edit the Base/Dockerfile and change which selenium-server version is downloaded via wget.  The Chromium version is set in NodeChromium/Dockerfile.txt.

To build the images, run build.sh from the root directory:

```
$ sh build.sh
```
