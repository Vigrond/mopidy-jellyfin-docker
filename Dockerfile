FROM python:3.13-trixie

RUN mkdir -p /etc/apt/keyrings
RUN wget -q -O /etc/apt/keyrings/mopidy-archive-keyring.gpg https://apt.mopidy.com/mopidy-archive-keyring.gpg
RUN wget -q -O /etc/apt/sources.list.d/mopidy.sources https://apt.mopidy.com/trixie.sources
RUN apt update && apt install -y mopidy

RUN apt update && apt install -y build-essential python3-dev python3-pip
RUN apt update && apt install -y \
    gir1.2-gst-plugins-base-1.0 \
    gir1.2-gstreamer-1.0 \
    gstreamer1.0-alsa \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-tools \
    libcairo2-dev \
    libgirepository-2.0-dev \
    python3-gst-1.0

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
CMD /bin/bash -c "mopidy --config /etc/mopidy/mopidy.conf -v"
