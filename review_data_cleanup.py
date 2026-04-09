import pandas as pd

df = pd.read_csv("data/olist_order_reviews_dataset.csv", encoding="latin1")

# Drop problematic columns
df = df.drop(columns=["review_comment_title", "review_comment_message"])

# Save clean file
df.to_csv("reviews_clean.csv", index=False)