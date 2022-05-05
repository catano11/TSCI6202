
library(jsonlite)
library(dplyr)
library(rio)
library(ggplot2)

if(!file.exists("cached_data.tsv")) {

dat0 <- fromJSON('https://services.arcgis.com/g1fRTDLeMgspWrYp/arcgis/rest/services/SAMHD_DailySurveillance_Data_Public/FeatureServer/0/query?where=1%3D1&outFields=*&returnGeometry=false&outSR=4326&f=json')
dat1 <- dat0$features$attributes %>% subset(!is.na(total_case_cumulative)) %>% mutate(reporting_date = as.POSIXct(reporting_date/1000, origin = "1970-01-01" ))

export(dat1, "cached_data.tsv")
} else{dat1 <- import("cached_data.tsv")}

ggplot(dat1, aes(y = deaths_cumulative, x = reporting_date)) +
  geom_line() + geom_line(aes(y = total_case_daily_change), col="red") +
  ylab("count ")


# Fit models

dat2<- select(dat1, -c("globalid", "objectid", "reporting_date")) %>%
  mutate(across(.cols=is.numeric, ~coalesce(.x, 0)))


fit1 <- lm(strac_covid_positive_in_icu ~ ., data = dat2)
fit2 <- lm(strac_covid_positive_in_icu ~ total_case_daily_change, data = dat2)


fl_mean <- flashlight(
  model = mean(dat2$strac_covid_positive_in_icu),
  label = "mean",
  predict_function = function(mod, X) rep(mod, nrow(X))
)

fl_1 <- flashlight(
  model = fit1,
  label = "lm1",
  predict_function = function(mod, X) predict(mod, X)
)


fl_2 <- flashlight(
  model = fit2,
  label = "lm2",
  predict_function = function(mod, X) predict(mod, X)
)

fls <- multiflashlight(
  list(fl_mean, fl_1, fl_2),
  y = "strac_covid_positive_in_icu",
  #linkinv = exp,
  data = dat2,
  metrics = list(rmse = rmse, `R-squared` = r_squared)
)

perf <- light_performance(fls)
perf

plot(perf, fill = "darkred") +
  xlab(element_blank())

(imp <- light_importance(fls, v = x))
