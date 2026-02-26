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
Production = Intercept + Trend + Monthly Dummy Variables


- Captures long-term movement
- Significant seasonal effects
- Moderate predictive accuracy

---

### 3️⃣ Two-Level Forecast (Best Model)

Final Forecast:
Final = Regression Forecast + MA(4) of Residuals


Validation Performance:

- Substantially reduced RMSE
- Lowest MAPE across regression-based models
- Outperformed seasonal naïve baseline

This model effectively captured both systematic structure and residual patterns.

---

### 4️⃣ Holt–Winters Exponential Smoothing (ETS)

- Automated ETS selection (`ets(model="ZZZ")`)
- Compared ETS(A,N,A) and ETS(M,N,A)
- Strong seasonal capture
- Slightly higher error than two-level model

---

## 📈 Model Comparison

Evaluated using:

- RMSE (Root Mean Square Error)
- MAPE (Mean Absolute Percentage Error)
- Residual diagnostics

Best Overall Model:
**Two-Level Regression + Residual MA**

---

## 🛠 Tools Used

- R
- `forecast`
- `zoo`
- `ggplot2`
- `stats`

---

## 📌 Key Takeaways

- Explicit seasonality modeling significantly improves accuracy
- Residual correction meaningfully reduces forecast error
- Two-level models can outperform exponential smoothing in structured seasonal data
- Model validation is essential before final forecasting

---

## 🚀 Final Outcome

Selected model was used to forecast U.S. food production for 2018, delivering the lowest validation error among all approaches.
