import pandas as pd

# Load CSV files
file1 = pd.read_csv('~/Kpn_data/bactdating/pw_meta.csv')
key_file = pd.read_csv('~/Kpn_data/bactdating/dates.csv')

# Perform left join
result = pd.merge(file1, key_file, left_on='name', right_on='id', how='inner')

# Display or save the result
print(result)
result.to_csv('output.csv', index=False)
