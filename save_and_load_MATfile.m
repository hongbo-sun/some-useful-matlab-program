a=[1 2 3;4,5,6];
b=[1 2];
save example.mat a b '-v7.3';


k=load('example.mat');

fieldnames(k)

k.a(2,3)
k.b







