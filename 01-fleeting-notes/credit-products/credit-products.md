# Credit Products

---

## 💱 Interest Rate Swaps

An interest rate swap is an instrument where the buyer (long position holder) pays a fixed rate of interest and receives a floating rate. The floating rate is based on a reference instrument such as *LIBOR* or *EURIBOR*.

> ℹ️ **Note:** LIBOR is presently being replaced:
> - **US:** Replaced by SOFR (Secured Overnight Financing Rate)
> - **UK:** Replaced by SONIA (Sterling Overnight Index Average)
> - **Europe:** EURIBOR will remain

It is common in credit markets for instruments to be compared to swap rates to get an idea of their value.

---

## 📊 Bond Yields

We can consider the yield on a corporate bond as a reward the holder gets for taking on risk. We can split it into three parts:

![spreads](./images/bond-spreads.svg)

The yield provided by a corporate bond is impacted by three factors:

* **Government** - Risk-free rate component
* **Swap** - Swap rate component
* **Credit** - Credit spread component

### Historical vs. Recent Impact

In the past, the risk-free rate has been the biggest factor in bond yields. However, in recent years, the credit spread has become a much bigger factor.

> A credit spread is always quoted with respect to a reference risk-free benchmark. What is considered "risk-free" depends on the market participant.

### Reference Benchmarks

* **Government Bonds** - Favored by those who don't borrow (asset managers, insurance companies)
* **Swap Rates** - Used by clients with funding costs (derivative trading desks, hedge funds)

### Calculating Spreads Over Govies

* Spread over the nearest government bond
* Using a government yield curve with interpolation

---

## 📊 Spreads

### 📘 What Is the Z-Spread?

The **Z-spread** (zero-volatility spread) is the **constant spread** added to **every point on the risk-free zero-coupon yield curve** so that the **discounted cash flows** of a bond equal its **current market price**.

> **It represents the extra yield investors require above risk-free rates to compensate for credit and liquidity risk, using a term-structure-accurate discounting method.**

---

### 🧠 Why Do We Use the Z-Spread?

The Z-spread is more accurate than simple yield spreads because it:

* Discounts **each cash flow with the correct zero-coupon rate**
* Adjusts for the **shape of the yield curve**
* Works for **bonds with uneven or complex cash flows**

It’s especially useful for:

* Corporate bonds
* EM debt
* MBS (before option adjustments)

---

### 🧮 How Z-Spread Works (Conceptually)

A bond with cash flows $(CF_1, CF_2, \ldots, CF_n)$ at maturities $(t_1, t_2, \ldots, t_n)$ is priced using:

$$\text{Bond Price} = \sum_{i=1}^{n} \frac{CF_i}{(1 + r_i + Z)^{t_i}}$$

Where:

* $r_i$ = zero-coupon rate at maturity $t_i$
* $Z$ = the spread applied uniformly to all maturities

Solve for $Z$ so the model price equals the bond's **market price**.

---

### 🔍 Intuitive Example

Suppose:

* A 5-year corporate bond trades at **95**
* Discounting its cash flows using the risk-free zero curve gives a value of **97**

This means investors need **more yield**.
Increase the spread added to every point on the curve until:

> **PV(cash flows) = 95**

If this happens when we add **130 bps**, then:

**Z-spread = 130 bps**

---

### 🆚 Z-Spread vs. Other Spreads

| Spread Type        | Discounts Using             | Curve Shape Adjusted? | Option-Adjusted? |
| ------------------ | --------------------------- | --------------------- | ---------------- |
| **Nominal Spread** | YTM                         | ❌                     | ❌                |
| **I-Spread**       | Swap curve                  | ❌                     | ❌                |
| **Z-Spread**       | Zero-coupon risk-free curve | ✔️                    | ❌                |
| **OAS**            | Zero curve + option model   | ✔️                    | ✔️               |

---

### 🎯 One-Sentence Summary

**The Z-spread is the constant yield premium added to the zero-coupon curve that makes the present value of a bond's cash flows match its market price.**

---

### 💱 Asset Swap Spreads

> Coming soon...

---

### ⚙️ Option Adjusted Spreads

> Coming soon...
