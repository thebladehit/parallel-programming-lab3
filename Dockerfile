FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    gnat \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

COPY ./data /app/data

RUN ls -R /app

RUN gnatmake -I/app/data /app/lab3.adb

CMD ["./lab3"]