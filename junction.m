clc;
clear;
[a,amap]=imread('C:\Users\Shant-Gamma\Desktop\num1.gif');
b=ind2gray(a,amap);
c=b<128;
e=imresize(c,[64 64]);
d=bwmorph(e,'thin',Inf);
 %jun=zeros(64,64);
junc=zeros(3,50);
m=0;
canc=zeros(64);
for i=2:63
    for j=2:63
        if(d(i,j)==1 && trueneighbours(d,i,j)>=3 && canc(i,j)==0)
            %jun(i,j)=1;
            m=m+1;
            junc(1,m)=i;
            junc(2,m)=j;
            canc(i+1,j)=1;
            canc(i,j+1)=1;
            %junc(3,m)=trueneighbours(d,i,j);
        end
    end
end
noOfJunction=m
for i=1:m
    x=junc(1,i)
    y=junc(2,i)
    %neighbour(d,junc(1,i),junc(2,i))
end
[area,perimeter]=regarea(d)