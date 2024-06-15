clc
clear
close all

% Random Forest Regression with Cross-Validation

%% Manege Data
name = {'C4.mat','Best_combo17.mat'};
[TrainData,TestData] = LoadAndManageData(name{2});
nVar = size(TrainData.Inputs,2);

% Set Hyper-Parameters
Options.NumPredictorsToSample=4;
Options.nTrees =334;
Options.MaxNumSplits =113; %min(nVar,30);
Options.MinLeafSize =5;
Options.OOB = 'on';
Options.OOBPredictorImportance = 'on';
Options.Method = 'regression';
Options.Show = 1;
Options.Parallel = true; % true or false
% Train Random forest
ModelRF = RandomForest(TrainData,Options);


%% Prediction
GroupsTrain = predict(ModelRF,TrainData.Inputs);
ResultsTrain = EvaluatePlot(TrainData.Targets,GroupsTrain,'Train');

GroupsTest = predict(ModelRF,TestData.Inputs);
Results = EvaluatePlot(TestData.Targets,GroupsTest,'Test');


%% Out of Bag Error
figure;
oobErrorBaggedEnsemble = oobError(ModelRF);
plot(oobErrorBaggedEnsemble,'LineWidth',2)
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';

%% OOB Predictor Importance
 if (contains(Options.OOBPredictorImportance,'on')) && (Options.Show)
    imp = ModelRF.OOBPermutedPredictorDeltaError;

    figure;
    bar(abs(imp));
    title('Curvature Test');
    ylabel('Predictor importance estimates');
    xlabel('Predictors');
    h = gca;
    h.TickLabelInterpreter = 'none';
 end


