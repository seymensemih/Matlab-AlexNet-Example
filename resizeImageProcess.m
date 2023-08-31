function I = resizeImageProcess(filename)
I=imread(filename);
I=imresize(I,[227,227]);
if ismatrix(I)
    I=cat(3,I,I,I);
end
end