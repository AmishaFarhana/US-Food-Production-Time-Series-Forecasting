# 🌾 U.S. Food Production Forecasting

Time series forecasting project analyzing monthly U.S. food production (1997–2017) to predict production levels for 2018.

This project compares multiple forecasting approaches and selects the most accurate model using validation-based performance metrics.

---

## 📊 Dataset

- Monthly U.S. food production  
- Period: January 1997 – December 2017  
- Units: Millions of tons  
- Objective: Forecast 12 months of 2018  

---

## 🔍 Exploratory Analysis

Time series decomposition revealed:

- Clear annual seasonality (additive pattern)
- Moderate long-term trend
- Strong autocorrelation at lag 12 (yearly effect)
- No major structural breaks

ACF diagnostics confirmed predictable seasonal structure.

---

## 🧠 Models Implemented

### 1️⃣ Trailing Moving Averages

Window sizes tested:

- 4-month
- 7-month
- 10-month

Best validation performance:
- Window = 4  
- Lowest RMSE and MAPE  

---

### 2️⃣ Regression with Trend & Seasonality

Model form:
