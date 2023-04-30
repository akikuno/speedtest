library(readr)
library(tidyr)
library(dplyr)
library(stringr)
library(ggplot2)

args <- commandArgs()
file_input <- args[1]
file_output <- args[2]

df <- read_csv(file_input)

df_plot <-
    df %>%
    pivot_longer(!date, names_to = "Up/Down", values_to = "Speed (Mbit/s)") %>%
    mutate(`Up/Down` = str_remove(`Up/Down`, "\\(Mbit/s\\)")) %>%
    ggplot(aes(x = date, y = `Speed (Mbit/s)`, color = `Up/Down`)) +
    geom_line() +
    expand_limits(y = 0) +
    scale_x_datetime(date_breaks = "2 hours", date_labels = "%m-%d %H:%M") +
    theme_bw() +
    theme(axis.text.y = element_text(size = 18)) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

ggsave(output, df_plot, width = 8, height = 4)
