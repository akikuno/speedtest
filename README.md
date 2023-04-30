# `speedtest.sh`: record the speed of the internet connection

## Requirements

- `bash`
- [`speedtest-cli`](https://github.com/sivel/speedtest-cli)

## Installation

```bash
wget https://raw.githubusercontent.com/akikuno/speedtest/main/speedtest.sh
```

or 

```bash
curl -O https://raw.githubusercontent.com/akikuno/speedtest/main/speedtest.sh
```

To install `speedtest-cli`, run:

```bash
pip install speedtest-cli
```
or

```bash
conda install -c conda-forge speedtest-cli
```

## Usage

```bash
bash speedtest.sh \
    -o [output file] \
    -i [interval of the each measurement] \
    -d [duration of the whole measurement]
```

- `-o`: Name of the outout CSV file
- `-d`: Duration of the whole measurement (default: `1h`)
    - **`integer` + `units` (`s`,`m`,`h`,`d`,`w`)**
    - e.g: `6h` means the entire measurement period is 6 hours
- `-i`: Interval of the each measurement (default: `10m`)
    - **`integer` + `units` (`s`,`m`,`h`,`d`,`w`)**
    - e.g: `10m` means that the individual measuring points are 10 minites apart

### Example

Measure the speed of your internet connection every 1 minites for a total of 10 minutes

```bash
bash speedtest.sh -o example/speedtest.csv -i 1m -d 10m
```
## Output

 [`example/speedtest.csv`](https://github.com/akikuno/speedtest/blob/main/example/speedtest.csv)

| Date                | Ping (ms) | Download (Mbit/s) | Upload (Mbit/s) |
| ------------------- | --------- | ----------------- | --------------- |
| 2023-05-01 07:14:45 | 47.208    | 30.87             | 109.26          |
| 2023-05-01 07:15:47 | 36.415    | 25.90             | 118.86          |
| 2023-05-01 07:16:47 | 44.498    | 87.65             | 89.85           |
| 2023-05-01 07:17:47 | 13.199    | 83.94             | 55.74           |
| 2023-05-01 07:18:47 | 52.701    | 63.14             | 67.29           |
| 2023-05-01 07:19:47 | 18.468    | 38.66             | 42.55           |
| 2023-05-01 07:20:47 | 13.016    | 67.87             | 94.21           |
| 2023-05-01 07:21:47 | 17.619    | 77.15             | 164.27          |
| 2023-05-01 07:22:47 | 17.746    | 43.59             | 45.83           |
| 2023-05-01 07:23:47 | 17.577    | 94.22             | 133.41          |
|                     |           |                   |                 |
