# Copyright 2016 Packt Publishing

# Introduction to R for Business Intelligence
# Chapter 6 - Time Series Analysis

message("Introduction to R for Business Intelligence
        Chapter 6 - Time Series Analysis
        Copyright (2016) Packt Publishing \n
        This is your introduction to time series analysis")

#
# Looking at Time-Based Data with Linear Regression

suppressMessages(suppressWarnings(library(TSA)))
data(airpass)
detach(package:TSA)
str(airpass)
summary(airpass)

volume <- as.matrix(airpass)
time <- as.matrix(time(airpass))

airpass_df <- as.data.frame(cbind(volume, time))
colnames(airpass_df) <- c("volume", "time")

lmfit <- lm(volume ~ time, data = airpass_df)
summary(lmfit)

# Linearity, Normality and Equal Variance

par(mfrow = c(1, 3))
plot(airpass_df$time, airpass_df$volume, pch = 19,
     main = "Linearity?"); abline(lmfit)
hist(lmfit$residuals, main = "Normality?", col = "gray")
plot(lmfit$fitted.values, lmfit$residuals, 
     main = "Equal Variance?", pch = 19); abline(h = 0)
par(mfrow = c(1, 1))

# Prediction and Confidence Intervals

plot(airpass, main = "95 Percent Confidence and Prediction Intervals of airpass Data")
abline(lmfit, col = "blue")
newdata <- data.frame(time = seq(1960, 1972, 2))
pred <- predict.lm(lmfit, newdata, interval = "predict")

points(seq(1960, 1972, 2), pred[ ,1], pch = 19, col = "blue")
abline(lsfit(seq(1960, 1972, 2), pred[,2]), col = "red")
abline(lsfit(seq(1960, 1972, 2), pred[,3]), col = "red")

pred <- predict.lm(lmfit, newdata, interval = "confidence")
abline(lsfit(seq(1960, 1972, 2), pred[,2]), lty = 2, col = "red")
abline(lsfit(seq(1960, 1972, 2), pred[,3]), lty = 2, col = "red")

rm(airpass_df, newdata, pred, time, volume, lmfit)

#
# Introducing Key Elements of Time Series Analysis

suppressMessages(suppressWarnings(library(forecast)))
plot(decompose(airpass))

seq_down <- seq(.625, .125, -0.125)
seq_up <- seq(0, 1.5, 0.25)
y <- c(seq_down, seq_up, seq_down + .75, seq_up + .75,
       seq_down + 1.5, seq_up + 1.5)

par(mfrow = c(1, 3))
plot(y, type = "b", ylim = c(-.1, 3))
plot(diff(y), ylim = c(-.1, 3), xlim = c(0, 36))
plot(diff(diff(y), lag = 12), ylim = c(-.1, 3), xlim = c(0, 36))
par(mfrow = c(1, 1))
rm(y, seq_down, seq_up)

#
# Building ARIMA Models

# Selecting a Model to Make Forecasts

cycle <- read.csv("./data/Ch6_ridership_data_2011-2012.csv")
head(cycle)

suppressMessages(suppressWarnings(library(dplyr)))
suppressMessages(suppressWarnings(library(lubridate)))
monthly_ride <- as.data.frame(cycle %>%
          group_by(year = year(datetime),
                   month = month(datetime)) %>%
          summarise(riders = sum(count)))

table(monthly_ride$year, monthly_ride$month)

riders <- monthly_ride[ ,3]
monthly <- ts(riders, frequency = 12, start = c(2011, 1))
monthly

plot(decompose(monthly))

par(mfrow = c(1, 3))
plot(monthly, ylim = c(-30000, max(monthly)))
plot(diff(monthly), ylim = c(-30000, max(monthly)))
plot(diff(diff(monthly), lag = 12), ylim = c(-30000, max(monthly)))

par(mfrow = c(1, 2))
acf(monthly, xlim = c(0, 2))
pacf(monthly, xlim = c(0, 2))
par(mfrow = c(1, 1))

fit <- arima(monthly, c(1, 0, 0),
             seasonal = list(order = c(0, 0, 0)))
fit; tsdiag(fit)

fit <- arima(monthly, c(1, 1, 0),
             seasonal = list(order = c(0, 0, 0)))
fit; tsdiag(fit)

fit <- arima(monthly, c(2, 1, 0),
             seasonal = list(order = c(0, 0, 0)))
fit; tsdiag(fit)

fit <- arima(monthly, c(1, 1, 0),
             seasonal = list(order = c(0, 1, 0)))
fit; tsdiag(fit)

fit <- arima(monthly, c(0, 1, 1),
             seasonal = list(order = c(0, 0, 0)))
fit; tsdiag(fit)

fit <- arima(monthly, c(1, 1, 0),
             seasonal = list(order = c(0, 0, 0)))

suppressMessages(suppressWarnings(library(forecast)))
yr_forecast <- forecast(fit, h = 12)
plot(yr_forecast)

# Using Advanced Functionality to Model

monthly_data <- tbats(monthly)
year_forecast <- forecast(monthly_data, h = 12)
plot(year_forecast)

summary(year_forecast$mean)
summary(year_forecast$upper)
summary(year_forecast$lower)

mean_2011 <- round(as.numeric(
     filter(monthly_ride, year == 2011) %>%
          summarise(mean = mean(riders))), 0)
mean_2012 <- round(as.numeric(
     filter(monthly_ride, year == 2012) %>%
          summarise(mean = mean(riders))), 0)
mean_2013 <- round(mean(year_forecast$mean), 0)
max_mean_2013 <- round(max(year_forecast$mean), 0)

abline(h = max(year_forecast$mean), lty = 2, col = "blue")
segments(2011, mean_2011, x1 = 2012, y1 = mean_2011,
         col = "darkgray", lty = 2, lwd = 2)
segments(2012, mean_2012, x1 = 2013, y1 = mean_2012,
         col = "darkgray", lty = 2, lwd = 2)
segments(2013, mean_2013, x1 = 2014, y1 = mean_2013,
         col = "blue", lty = 2, lwd = 2)

text(2011.15, mean_2011 + 10000, mean_2011)
text(2012, mean_2012 + 10000, mean_2012)
text(2013, mean_2013 + 10000, mean_2013)
text(2013.85, max_mean_2013 + 10000, max_mean_2013)