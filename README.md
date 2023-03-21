# ML_with_nextflow_poc
It is POC project, using Nextflow to run ML pipeline

This is a machine learning pipeline that trains a linear regression model using scikit-learn and predicts the values of a test set.

## Input data

The pipeline expects two input files in the `data/` folder:
- `train.csv`: A CSV file containing the training data
- `test.csv`: A CSV file containing the testing data

## Output data

The pipeline generates two output files in the `results/` folder:
- `model.pkl`: A pickled version of the trained linear regression model
- `predicted_values.csv`: A CSV

This project is still in progress, will try build an whole E2E pipeline soon. 
