FROM python:3.7-slim-buster

WORKDIR /

COPY rhasspywake_precise_hermes/ /rhasspywake_precise_hermes
COPY . /
RUN apt-get update && apt-get install -y build-essential zlib1g-dev \
    python3-dev \
    cython3 \
    portaudio19-dev \
    wget \
    gcc \
    make \
    sox \
    git
RUN ./configure
RUN make
RUN make install
#ARCH=armv7l
#RUN wget https://github.com/MycroftAI/precise-data/raw/dist/x86_64/precise-engine.tar.gz
#RUN wget https://github.com/MycroftAI/mycroft-precise/releases/download/v0.2.0/precise-engine_0.2.0_x86_64.tar.gz -O precise-engine.tar.gz
#RUN tar xvf precise-engine.tar.gz
RUN git clone -b feature/docker https://github.com/soundcare/mycroft-precise mycroft-precise
WORKDIR /mycroft-precise
RUN ./setup-docker.sh
RUN pip install h5py==2.10.0
WORKDIR /
#RUN pip install tensorflow==1.18.0
ENTRYPOINT ["python3", "-m", "rhasspywake_precise_hermes"]
#ENTRYPOINT bin/rhasspy-wake-precise-hermes
