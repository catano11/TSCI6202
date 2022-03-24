library(plotly)
library(jsonlite)
library(dplyr)
library(rio)
library(ggplot2)
library(gt)
library(gtExtras)
library(tidyr)


if(!file.exists("cached_data.tsv")) {

  dat0 <- fromJSON('https://services.arcgis.com/g1fRTDLeMgspWrYp/arcgis/rest/services/SAMHD_DailySurveillance_Data_Public/FeatureServer/0/query?where=1%3D1&outFields=*&returnGeometry=false&outSR=4326&f=json')
  dat1 <- dat0$features$attributes %>% subset(!is.na(total_case_cumulative)) %>% mutate(reporting_date = as.POSIXct(reporting_date/1000, origin = "1970-01-01" ))

  rio::export(dat1, "cached_data.tsv")
} else{dat1 <- rio::import("cached_data.tsv")}


Table1 <- gt(dat1) %>% cols_hide(c("globalid", "objectid")) %>%
  fmt_number(change_in_7_day_moving_avg,  decimals=1) %>%
  fmt_missing(columns= everything(),missing_text="")%>%
  data_color(columns = c(total_case_daily_change),
             colors = scales::col_numeric(palette = c('green','red'),domain=NULL)) %>%
  tab_style(style = cell_text(color = "red", weight = "bold"),
            locations= cells_body(columns= c(change_in_7_day_moving_avg),
                                  rows=change_in_7_day_moving_avg>0)) %>%
  cols_label(total_case_cumulative=html("Cumulative&nbsp;Cases"),deaths_daily_change=html("Deaths&nbsp;per&nbsp;day"))


Summary1 <- pivot_longer(dat1, any_of(colnames(dat1)[-(1:3)])) %>%
  arrange(reporting_date) %>%
  group_by(name) %>%
  summarize(across(.fns = ~list(.x)))

