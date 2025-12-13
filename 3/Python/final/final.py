import pandas as pd
import matplotlib.pyplot as plt


# 1
def hate_love(s):
    words = s.split()
    return " ".join(["love" if w.lower() == "hate" else w for w in words])


s = "I HaTe to wake up in the morning and HATE to drink coffee"
print(hate_love(s))


# 2
def contains(s):
    return "the" in [w.lower() for w in s.split()]


# 3
## 1
df = pd.read_csv("vending_machine.csv")

print(df.info())
print(df.describe())
print(df.head())

## 2
print("Null értékek oszloponként:\n", df.isnull().sum())
print("Összesen null érték:", df.isnull().sum().sum())

## 3
for col in df.columns:
    if df[col].dtype == "O":
        df[col] = df[col].fillna("0")
    else:
        df[col] = df[col].fillna(0)

## 4
df.to_csv("vending_clean.csv", index=False)

## 5
df["Revenue"] = df["Price"] * df["Sold_Units"]

## 6
df_sorted = df.sort_values("Revenue", ascending=False)
top5 = df_sorted.head(5).copy()
top5["Revenue_HUF"] = top5["Revenue"] * 700

plt.bar(top5["Item"], top5["Revenue_HUF"])
plt.title("Top 5 Most Profitable Products (HUF)")
plt.xlabel("Product")
plt.ylabel("Revenue (HUF)")
plt.show()

## 7
df = df[df["Stock"] > 0]
