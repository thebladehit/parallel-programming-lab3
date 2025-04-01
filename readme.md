# Lab3 - parallel programming

## To test the efficiency on different number of cores
1. In `data/data.ads` change the number of threads
2. Build `./lab3.adb` for multi-thred version
```sh
gnatmake Lab3.adb -Idata
```
3. Build `./lab3-single-thread.adb` for single-thred version
```sh
gnatmake lab3-single-thread.adb -Idata
```