import argparse
import pandas as pd
import pickle

parser = argparse.ArgumentParser(description='Predict values using a trained linear regression model.')
parser.add_argument('--data', type=str, help='Input data file')
parser.add_argument('--model', type=str, help='Trained model file')
parser.add_argument('--output', type=str, help='Output file')

args = parser.parse_args()

data = pd.read_csv(args.data)
X = data[['X']]

with open(args.model, 'rb') as f:
    model = pickle.load(f)

y_pred = model.predict(X)

output = pd.DataFrame({'Y': y_pred})
output.to_csv(args.output, index=False)
