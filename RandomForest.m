function Classify = RandomForest(TrainData,Options)
TrainFeaturs = TrainData.Inputs;
TrainTargets = TrainData.Targets;

%% Train Algorithm
Options.NumPredictorsToSample = 4;
UseParallel=[];
Options.options = statset(UseParallel==Options.Parallel);

Classify = TreeBagger(Options.nTrees,TrainFeaturs,TrainTargets,...
    'OOBPrediction',Options.OOB,...
    'NumPredictorsToSample',Options.NumPredictorsToSample,...
    'MaxNumSplits',Options.MaxNumSplits,...
    'MinLeafSize',Options.MinLeafSize,...
    'PredictorSelection','allsplits',...
    'OOBPredictorImportance',Options.OOBPredictorImportance,'MergeLeaves','off','Surrogate','on',...
    'Method',Options.Method,'Options',Options.options);
% 'Surrogate','off',
% 'allsplits'
%curvature
if Options.Show
    chosetheTree = 1;
    view(Classify.Trees{chosetheTree},'Mode','graph')
end

end

