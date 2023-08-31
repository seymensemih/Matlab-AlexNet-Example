clear all
clc

imageFolderTrain='dataset train folder path';
imdsTrain=imageDatastore(imageFolderTrain,'LabelSource','foldernames','IncludeSubfolders',true);
imdsTrain.ReadFcn=@(filename)resizeImageProcess(filename);

imageFolderTest='dataset test folder path';
imdsTest=imageDatastore(imageFolderTest,'LabelSource','foldernames','IncludeSubfolders',true);
imdsTest.ReadFcn=@(filename)resizeImageProcess(filename);

net=alexnet;
featureLayer='fc8';

trainingFeatures=activations(net,imdsTrain,featureLayer,'OutputAs','columns');

testFeatures=activations(net,imdsTest,featureLayer,'OutputAs','columns');

trainingLabels=imdsTrain.Labels;
testLabels=imdsTest.Labels;

classifier = fitcecoc(trainingFeatures',trainingLabels);

predictions=predict(classifier,testFeatures');

accuracy = mean(predictions==testLabels);

cmAlex=confusionchart(testLabels,predictions);