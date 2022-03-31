> gt(dat1) %>% cols_hide(c/("globalid", "objectid"))
Error: unexpected ',' in "gt(dat1) %>% cols_hide(c/("globalid","
gt(dat1) %>% cols_hide(c("globalid", "objectid"))

gt(dat1) %>% cols_hide(c("globalid", "objectid")) %>% fmt_number()

gt(dat1) %>% cols_hide(c("globalid", "objectid")) %>% fmt_number(change_in_7_day_moving_avg,  decimals=1)

gt_preview(dat1) %>% cols_hide(c("globalid", "objectid")) %>% fmt_number(change_in_7_day_moving_avg,  decimals=1)

gt_preview(dat1) %>% cols_hide(c("globalid", "objectid")) %>% fmt_number(change_in_7_day_moving_avg,  decimals=1) %>% fmt_missing(columns= everything(missing_text("")
      +
gt_preview(dat1) %>% cols_hide(c("globalid", "objectid")) %>% fmt_number(change_in_7_day_moving_avg,  decimals=1) %>% fmt_missing(columns= everything(),missing_text("")

gt_preview(dat1) %>% cols_hide(c("globalid", "objectid")) %>% fmt_number(change_in_7_day_moving_avg,  decimals=1) %>% fmt_missing(columns= everything(),missing_text="")

gt_preview(dat1) %>% cols_hide(c("globalid", "objectid")) %>% fmt_number(change_in_7_day_moving_avg,  decimals=1) %>% fmt_missing(columns= everything(),missing_text="")%>% data_color(columns = c(total_case_daily_change), colors = scales::col_numeric(palette = c('green', 'red'), domain=NULL))
                                                                                                                                                                                 gt_preview(dat1) %>% cols_hide(c("globalid", "objectid")) %>% fmt_number(change_in_7_day_moving_avg,  decimals=1) %>% fmt_missing(columns= everything(),missing_text="")%>% data_color(columns = c(total_case_daily_change), colors = scales::col_numeric(palette = c('green', 'red'), domain=NULL)) %>% tab_style(style = cell_text(color = "red", weight = "bold"),locations(cells_body(columns=vars(change_in_7_day_moving_avg),rows=change_in_7_day_moving_avg>0)))


gt_preview(dat1) %>% cols_hide(c("globalid", "objectid")) %>%
  fmt_number(change_in_7_day_moving_avg,  decimals=1) %>%
  fmt_missing(columns= everything(),missing_text="")%>%
  data_color(columns = c(total_case_daily_change), colors = scales::col_numeric(palette = c('green', 'red'), domain=NULL)) %>%
  tab_style(style = cell_text(color = "red", weight = "bold"),
            locations= cells_body(columns= c(change_in_7_day_moving_avg),rows=change_in_7_day_moving_avg>0))


gt_preview(dat1) %>% cols_hide(c("globalid", "objectid")) %>%
  fmt_number(change_in_7_day_moving_avg,  decimals=1) %>%
  fmt_missing(columns= everything(),missing_text="")%>%
  data_color(columns = c(total_case_daily_change),
             colors = scales::col_numeric(palette = c('green','red'),domain=NULL)) %>%
  tab_style(style = cell_text(color = "red", weight = "bold"),
            locations= cells_body(columns= c(change_in_7_day_moving_avg),
                                  rows=change_in_7_day_moving_avg>0)) %>%
  cols_label(total_case_cumulative=html("Cumulative&nbsp;Cases"),deaths_daily_change=html("Deaths&nbsp;per&nbsp;day"))


gt_sparkline()

pivot_longer(dat1, any_of(colnames(dat1)[-(1:3)])) %>% View()

pivot_longer(dat1, any_of(colnames(dat1)[-(1:3)])) %>%
  arrange(reporting_date) %>%
  group_by(name) %>%
  summarize(list) %>%
  View()

pivot_longer(dat1, any_of(colnames(dat1)[-(1:3)])) %>%
  arrange(reporting_date) %>%
  group_by(name) %>%
  summarize(across(.fns = ~list(.x))) %>%
  View()

dat2 <- dat1 %>%
  arrange(reporting_date) %>%
  pivot_longer(any_of(dat1, any_of(colnames(dat1)[-(1:3)]))) %>%
  group_by(name) %>%
  summarize(across(.fns = ~list(no.omit(.x)))) %>%
  gt() %>%
  cols_hide(c(objectid, globalid, reporting_date)) %>%
  gt_sparkline(value, same_limit = F)

dat2


dat2 <- dat1 %>%
  arrange(reporting_date) %>%
  pivot_longer(any_of(colnames(dat1)[-(1:3)])) %>%
  group_by(name) %>%
  summarize(across(.fns = ~list(na.omit(.x)))) %>%
  mutate(hist = value, dense = value) %>%
  rename(spark = value) %>%
  gt() %>%
  cols_hide(c("globalid", "objectid", "reporting_date")) %>%
  gt_sparkline (spark, same_limit = F) %>%
  gt_sparkline (hist, type = "histogram", same_limit = F) %>%
  gt_sparkline (dense, type = "density", same_limit = F)
dat2



dat2 <- dat1 %>%
  arrange(reporting_date) %>%
  pivot_longer(any_of(colnames(dat1)[-(1:3)])) %>%
  group_by(name) %>%
  summarize( Median = median(value, na.rm = TRUE),
             SD = sd(value, na.rm = TRUE),
    across(.fns = ~list(na.omit(.x))),
           ) %>%
  mutate(hist = value, dense = value) %>%
  rename(spark = value) %>%
  gt() %>%
  cols_hide(c("globalid", "objectid", "reporting_date")) %>%
  gt_sparkline (spark, same_limit = F) %>%
  gt_sparkline (hist, type = "histogram", same_limit = F) %>%
  gt_sparkline (dense, type = "density", same_limit = F) %>%
  cols_move("spark", after = "name") %>%
  cols_label("spark" = "**Sparkline**"),
   # Hist = html("<span,style="color:red">Histogram</span>"),
    #list = list(Median =  "MEDIAN")


dat2



gt(dat2)







