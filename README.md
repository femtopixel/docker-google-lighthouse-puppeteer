![logo](logo.png)

Google Lighthouse Puppeteer - Docker Image
==========================================

[![latest release](https://img.shields.io/github/release/femtopixel/docker-google-lighthouse-puppeteer.svg "latest release")](http://github.com/femtopixel/docker-google-lighthouse-puppeteer/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/femtopixel/google-lighthouse-puppeteer.svg)](https://hub.docker.com/r/femtopixel/google-lighthouse-puppeteer/)
[![Docker Stars](https://img.shields.io/docker/stars/femtopixel/google-lighthouse-puppeteer.svg)](https://hub.docker.com/r/femtopixel/google-lighthouse-puppeteer/)
[![PayPal donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ppl.png "PayPal donation")](https://www.paypal.me/jaymoulin)
[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png "Buy me a coffee")](https://www.buymeacoffee.com/3Yu8ajd7W)
[![Become a Patron](https://badgen.net/badge/become/a%20patron/F96854 "Become a Patron")](https://patreon.com/jaymoulin)

DISCLAIMER: As-of 2021, this product does not have a free support team anymore. If you want this product to be maintained, please support on Patreon.

(This product is available under a free and permissive license, but needs financial support to sustain its continued improvements. In addition to maintenance and stability there are many desirable features yet to be added.)

THIS REPOSITORY IS AUTO-UPDATED BY [GITHUB-RELEASE-NOTIFIER](https://github.com/femtopixel/github-release-notifier) (https://github.com/femtopixel/github-release-notifier)

* [Google Chrome Headless](https://developers.google.com/web/updates/2017/04/headless-chrome) is the Google Chrome browser that can be started without graphical interface to accomplish several tasks (PDF printing, performance, automation...)
* [Google Lighthouse](https://developers.google.com/web/tools/lighthouse/) analyzes web apps and web pages, collecting modern performance metrics and insights on developer best practices.
* [Google Puppeteer](https://github.com/GoogleChrome/puppeteer) is a tool to automate tasks on a Chrome (headless) browser.

Description
-----------

The purpose of this image is to produce performance report for several pages in connected mode and in an automated way to be integrated in a CI environment.

It uses [lighthouse-batch](https://github.com/mikestead/lighthouse-batch) to be able to automate export of multiple 

Docker Usage
------------

```
docker run --rm --name perf -it -v /path/to/your/report/folder:/home/chrome/reports -v /path/to/your/testcases/folder:/home/chrome/testcases --cap-add SYS_ADMIN femtopixel/google-lighthouse-puppeteer <name_of_the_test>  
```

with `<name_of_the_test>` the name of the test in the `testcases` folder without `.js`

Note: you should check https://github.com/femtopixel/google-lighthouse-puppeteer/blob/master/README.md to see how to redact your testcases.

### Example

```
docker run --rm --name perf -it -v /path/to/your/report/folder:/home/chrome/reports -v /path/to/your/testcases/folder:/home/chrome/testcases --cap-add SYS_ADMIN femtopixel/google-lighthouse-puppeteer my_test  
```

Docker Usage : Improved
----------------

Using the ever-awesome [Jessie Frazelle](https://twitter.com/jessfraz) SECCOMP profile for Chrome, we don't have to use the hammer that is SYS_ADMIN:

```
wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json
docker run --rm --name perf -it -v /path/to/your/report/folder:/home/chrome/reports -v /path/to/your/testcases/folder:/home/chrome/testcases --security-opt seccomp=$HOME/chrome.json femtopixel/google-lighthouse-puppeteer <name_of_the_test> 
```

FAQ
---

* Using `lighthouse` in authenticated mode : https://github.com/GoogleChrome/lighthouse/blob/master/docs/readme.md#testing-on-a-site-with-authentication
* Error while writing files
```
  Runtime error encountered: { Error: EACCES: permission denied, open '/home/chrome/reports/myawesome_site_admin_heavypage.report.json'
  errno: -13,
  code: 'EACCES',
  syscall: 'open',
  path: '/home/chrome/reports/myawesome_site_admin_heavypage.report.json' }
```
Make sure your folder has the write right for others (`chmod o+w`)
