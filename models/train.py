import argparse
import pandas as pd
from sklearn.linear_model import LinearRegression
import pickle

parser = argparse.ArgumentParser(description='Train a linear regression model.')
parser.add_argument('--data', type=str, help='Input data file')
parser.add_argument('--output', type=str, help='Output model file')

args = parser.parse_args()

data = pd.read_csv(args.data)
X = data[['X']]
y = data['Y']

model = LinearRegression()
model.fit(X, y)

with open(args.output, 'wb') as f:
    pickle.dump(model, f)
