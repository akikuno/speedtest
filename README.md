# `speedtest.sh`: Script to run WiFi speed test

- `speedtest.sh`: record WiFi Down/Up speed
- `plot_speedtest.R`: plot WiFi Down/Up speed

## Requirements

- `bash`
- [`speedtest-cli`](https://github.com/sivel/speedtest-cli)
- `R` and `tidyverse` for `plot_speedtest.R`

To install `speedtest-cli`, run:

```bash
pip install speedtest-cli
```
or

```bash
conda install -c conda-forge speedtest-cli
```

To install `R` and `tidyverse`, run:

```bash
conda install -c conda-forge r-base r-essentials
```

## Usage

### `speedtest.sh`

To record WiFi Down/Up speed, run `speedtest.sh`.

```bash
bash speedtest.sh -o [output file] -d [duration of the whole measurement] -i [interval of the each measurement]
```

- `-o`: Name of the outout CSV file
- `-d`: Duration of the whole measurement
    - `integer` + `units` (`s`,`m`,`h`,`d`,`w`)
    - e.g: `6h` means the entire measurement period is 6 hours
- `-i`: Interval of the each measurement
    - `integer` + `units` (`s`,`m`,`h`,`d`,`w`)
    - e.g: `10m` means that the individual measuring points are 10 minites apart

#### Example

```bash
bash speedtest.sh -o example/speedtest.csv -d 2m -i 30s
```

### `plot_speedtest.R`

To plot WiFi Down/Up speed, run `plot_speedtest.R`.

```bash
Rscript --vanilla plot_speedtest.R [input] [output]
```

- `input`: CSV of WiFi speed recorded by `speedtest.sh`
- `output`: Image of time series line graph

#### Example

```bash
Rscript --vanilla plot_speedtest.R example/speedtest.csv example/speedtest.png
```

## Output

### `example/speedtest.csv`

### `example/speedtest.png`

