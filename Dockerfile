# We're using Alpine Edge
FROM alpine:edge

#
# We have to uncomment Community repo for some packages
#
RUN sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' -i /etc/apk/repositories

#
# Installing Packages
#
RUN apk add --no-cache=true --update \
        bash \
    git \
    libevent \
    jpeg-dev \
    libffi-dev \
    libpq \
    libwebp-dev \
    python \
    python-dev \
    python3 \
    sqlite \
    sqlite-dev \
    sudo \
    chromium
    
  
RUN python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools


#
# Clone repo and prepare working directory
#
RUN git clone https://github.com/zLian17/telegram-sticker-downloader /root/tgsd
RUN mkdir /root/tgsd/bin/
WORKDIR /root/tgsd/

#
# Copies session and config (if it exists)
#
COPY ./sample_config.env ./userbot.session* ./config.env* /root/userbot/

#
# Install requirements
#
RUN pip3 install -r requirements.txt
CMD ["python3","main.py"]
