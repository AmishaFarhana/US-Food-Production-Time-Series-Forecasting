

## USE FORECAST LIBRARY.

install.packages("forecast")
library(forecast)
library(zoo)


## CREATE DATA FRAME. 

# Set working directory for locating files.
setwd("/Users/amishafarhanashaik/Desktop/MSBA/BAN673TimeSeries /Case Study 1")

# Create data frame.
data <- read.csv("673_case1.csv")

head(data)
colnames(data)

#QUESTION 1A

prod.ts <- ts(data$production, 
                   start = c(1997, 1), end = c(2017, 12), freq = 12)
prod.ts

#QUESTION 1B

prod.stl <- stl(prod.ts, s.window = "periodic")
autoplot(prod.stl, main = "Production Data Components")

## 1b. 
# Plot the time series data. 
plot(prod.ts, 
     xlab = "Time", ylab = "Food Production in the U.S., Mln. Tons", ylim = c(500, 1000), bty = "l",
     xaxt = "n", xlim = c(1997, 2019.25), main = "Food Production Data", lwd = 3, col="blue") 
axis(1, at = seq(1997, 2019, 1), labels = format(seq(1997, 2019, 1)))


#QUESTION 1C

autocor <- Acf(prod.ts, lag.max = 12, 
               main = "Autocorrelation for Production")

# Display autocorrelation coefficients for various lags.
Lag <- round(autocor$lag, 0)
ACF <- round(autocor$acf, 3)
data.frame(Lag, ACF)

#QUESTION 2A

nValid <- 48
nTrain <- length(prod.ts) - nValid 
train.ts <- window(prod.ts, start = c(1997, 1), end = c(1997, nTrain))
valid.ts <- window(prod.ts, start = c(1997, nTrain + 1), 
                   end = c(1997, nTrain + nValid))


#QUESTION 2B

ma.trailing_4 <- rollmean(train.ts, k = 4, align = "right")
ma.trailing_4
ma.trailing_7 <- rollmean(train.ts, k = 7, align = "right")
ma.trailing_7
ma.trailing_10 <- rollmean(train.ts, k = 10, align = "right")
ma.trailing_10

#QUESTION 2C

ma.trail_4.pred <- forecast(ma.trailing_4, h = nValid, level = 0)
ma.trail_4.pred
ma.trail_4.pred$mean
ma.trail_7.pred <- forecast(ma.trailing_7, h = nValid, level = 0)
ma.trail_7.pred
ma.trail_10.pred <- forecast(ma.trailing_10, h = nValid, level = 0)
ma.trail_10.pred

#QUESTION 2D

round(accuracy(ma.trail_4.pred$mean, valid.ts), 3)
round(accuracy(ma.trail_7.pred$mean, valid.ts), 3)
round(accuracy(ma.trail_10.pred$mean, valid.ts), 3)

#QUESTION 3A

trend.seas <- tslm(train.ts ~ trend + season)
summary(trend.seas)

trend.seas.pred <- forecast(trend.seas, h = nValid, level = 0)
trend.seas.pred$mean


#QUESTION 3B

trend.seas.res <- trend.seas$residuals
trend.seas.res
ma.trail.res <- rollmean(trend.seas.res, k = 4, align = "right")
ma.trail.res

trend.seas.res.valid <- valid.ts - trend.seas.pred$mean
trend.seas.res.valid
ma.trail.res.pred <- forecast(ma.trail.res, h = nValid, level = 0)
ma.trail.res.pred

#QUESTION 3C

fst.2level <- trend.seas.pred$mean + ma.trail.res.pred$mean
fst.2level

valid.df <- round(data.frame(valid.ts, trend.seas.pred$mean, 
                             ma.trail.res.pred$mean, 
                             fst.2level), 3)
names(valid.df) <- c("Validationdata", "Regression.Fst", 
                     "MA.Residuals.Fst", "Combined.Fst")
valid.df

round(accuracy(trend.seas.pred$mean, valid.ts), 3)
round(accuracy(fst.2level, valid.ts), 3)

#QUESTION 3D

tot.trend.seas <- tslm(prod.ts ~ trend  + season)
summary(tot.trend.seas)
tot.trend.seas.pred <- forecast(tot.trend.seas, h = 12, level = 0)
tot.trend.seas.pred

tot.trend.seas.res <- tot.trend.seas$residuals
tot.trend.seas.res
tot.ma.trail.res <- rollmean(tot.trend.seas.res, k = 4, align = "right")
tot.ma.trail.res
tot.ma.trail.res.pred <- forecast(tot.ma.trail.res, h = 12, level = 0)
tot.ma.trail.res.pred


tot.fst.2level <- tot.trend.seas.pred$mean + tot.ma.trail.res.pred$mean
tot.fst.2level

future12.df <- round(data.frame(tot.trend.seas.pred$mean, tot.ma.trail.res.pred$mean, 
                                tot.fst.2level), 3)
names(future12.df) <- c("Regression.Fst", "MA.Residuals.Fst", "Combined.Fst")
future12.df

#QUESTION 3E

round(accuracy((snaive(prod.ts))$fitted, prod.ts), 3)

round(accuracy(tot.trend.seas.pred$fitted, prod.ts), 3)

round(accuracy(tot.trend.seas.pred$fitted+tot.ma.trail.res, prod.ts), 3)


#QUESTION 4A

hw.ZZZ <- ets(train.ts, model = "ZZZ")
hw.ZZZ 

hw.ZZZ.pred <- forecast(hw.ZZZ, h = nValid, level = 0)
hw.ZZZ.pred$mean

#QUESTION 4B

HW.ZZZ <- ets(prod.ts, model = "ZZZ")
HW.ZZZ
HW.ZZZ.pred <- forecast(HW.ZZZ, h = 12 , level = 0)
HW.ZZZ.pred$mean

#Model identified in 4A
HW.ANA <- ets(prod.ts, model = "ANA")
HW.ANA
HW.ANA.pred <- forecast(HW.ANA, h = 12 , level = 0)
HW.ANA.pred$mean



#QUESTION 4C

round(accuracy((snaive(prod.ts))$fitted, prod.ts), 3)
round(accuracy(HW.ZZZ.pred$fitted, prod.ts), 3)
round(accuracy(HW.ANA.pred$fitted, prod.ts), 3)











