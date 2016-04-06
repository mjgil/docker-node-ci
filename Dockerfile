FROM node:4.4.0

RUN apt-get update && \
    apt-get install -y \
      xvfb \
      chromium \
      python \
      curl
      
RUN curl http://python-distribute.org/distribute_setup.py | python
RUN curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python

ADD xvfb-chromium /usr/bin/xvfb-chromium

RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome && \
    ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

# Startup and shutdown chrome to set up an initial user-data-dir
RUN google-chrome --user-data-dir=/root/chrome-user-data-dir & \
    (sleep 5 && kill $(pgrep -o chromium) && sleep 2)

ENV CHROME_BIN /usr/bin/google-chrome