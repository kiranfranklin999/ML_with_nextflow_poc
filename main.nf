params.input = 'data'
params.output = 'results'

// Define the training and testing data files
trainingData = file("${params.input}/train.csv")
testingData = file("${params.input}/test.csv")

// Define the model script and output file
trainModelScript = file("models/train_model.py")
modelOutput = file("${params.output}/model.pkl")

// Define the prediction script and output file
predictValuesScript = file("models/predict_values.py")
predictedValuesOutput = file("${params.output}/predicted_values.csv")

// Define the conda environment for the pipeline
condaEnvironment = "models/requirements.txt"

// Train the model
process trainModel {
    input:
    file trainingData
    file trainModelScript
    output:
    file modelOutput
    script:
    """
    python ${trainModelScript} --data ${trainingData} --output ${modelOutput}
    """
    conda:
    "${condaEnvironment}"
}

// Predict the values using the trained model
process predictValues {
    input:
    file testingData
    file modelOutput
    file predictValuesScript
    output:
    file predictedValuesOutput
    script:
    """
    python ${predictValuesScript} --data ${testingData} --model ${modelOutput} --output ${predictedValuesOutput}
    """
    conda:
    "${condaEnvironment}"
}

// Merge the predicted values with the testing data
process mergeResults {
    input:
    file testingData
    file predictedValuesOutput
    output:
    file "${params.output}/merged_results.csv"
    script:
    """
    data = pd.read_csv('${testingData}')
    predicted = pd.read_csv('${predictedValuesOutput}')
    merged = pd.concat([data, predicted], axis=1)
    merged.to_csv('${params.output}/merged_results.csv', index=False)
    """
    conda:
    "${condaEnvironment}"
}
