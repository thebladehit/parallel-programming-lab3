# Lab3 - parallel programming

## To test the efficiency on different number of cores
```sh
docker build -t <your-image-name> .
```

```sh
docker run -it --cpus=<cpus-count> <your-image-name>
```