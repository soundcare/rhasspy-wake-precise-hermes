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
    sox
RUN ./configure
RUN make
RUN make install

ENTRYPOINT ["python3", "-m", "rhasspywake_precise_hermes"]
#ENTRYPOINT bin/rhasspy-wake-precise-hermes
