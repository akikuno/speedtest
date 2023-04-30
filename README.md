# `speedtest.sh`: Script to run WiFi speed test

## Requirements

- `bash`
- [`speedtest-cli`](https://github.com/sivel/speedtest-cli)

To install `speedtest-cli`, run:

```bash
pip install speedtest-cli
```
or

```bash
conda install -c conda-forge speedtest-cli
```

## Installation

```bash
wget https://raw.githubusercontent.com/akikuno/speedtest/main/speedtest.sh
```

or 

```bash
curl -O https://raw.githubusercontent.com/akikuno/speedtest/main/speedtest.sh
```

## Usage

```bash
bash speedtest.sh -o [output file] -d [duration of the whole measurement] -i [interval of the each measurement]
```

- `-o`: Name of the outout CSV file
- `-d`: Duration of the whole measurement (default: `1h`)
    - `integer` + `units` (`s`,`m`,`h`,`d`,`w`)
    - e.g: `6h` means the entire measurement period is 6 hours
- `-i`: Interval of the each measurement (default: `10m`)
    - `integer` + `units` (`s`,`m`,`h`,`d`,`w`)
    - e.g: `10m` means that the individual measuring points are 10 minites apart

### Example

```bash
bash speedtest.sh -o example/speedtest.csv -d 3m -i 30s
```
## Output

### [`example/speedtest.csv`](https://github.com/akikuno/speedtest/blob/main/example/speedtest.csv)

| Date                | Download(Mbit/s) | Upload(Mbit/s) |
| ------------------- | ---------------- | -------------- |
| 2023-04-30 12:35:13 | 64.15            | 50.75          |
| 2023-04-30 12:35:44 | 168.78           | 22.60          |
| 2023-04-30 12:36:14 | 25.05            | 12.03          |
| 2023-04-30 12:36:44 | 51.82            | 28.16          |
| 2023-04-30 12:37:14 | 144.61           | 36.66          |
| 2023-04-30 12:37:44 | 65.54            | 51.98          |

