clc;
clear;
a=imread('C:\Users\Shant-Gamma\Desktop\81.jpg');
b=rgb2gray(a);
c=b<128;
e=imresize(c,[64 64]);
d=bwmorph(e,'thin',Inf);
sx=-1;
sy=-1;
tr=zeros(64);
ch=zeros(1,4000);
flag1=0;
for i=2:63
    for j=2:63
        if(d(i,j)==1 && neighbour(d,i,j)==1)
            sx=i;
            sy=j;
            flag1=1;
            break
        end
    end
    if(flag1==1)
        break
    end
    end
flag1=0;
if(sx==-1)
    for i=1:64
        for j=1:64
            if(d(i,j)==1)
            sx=i;
            sy=j;
            flag1=1;
            break
            end
        end
        if(flag1==1)
        break
        end
    end
end
%jun=zeros(64,64);
%for i=1:64
  %  for j=1:64
        %if(neighbour(d,i,j)>2)
           % jun(i,j)=1;
        %end
   % end
%end
m=1;
tr(sx,sy)=1;
if(d(sx,sy+1)==1)
    ch(m)=0;
    r=sx;
    c=sy+1;
    m=m+1;
elseif(d(sx-1,sy+1)==1)
    ch(m)=1;
    r=sx-1;
    c=sy+1;
    m=m+1;
elseif(d(sx-1,sy)==1)
    ch(m)=2;
    r=sx-1;
    c=sy;
    m=m+1;
elseif(d(sx-1,sy-1)==1)
    ch(m)=3;
    r=sx-1;
    c=sy-1;
    m=m+1;
elseif(d(sx,sy-1)==1)
    ch(m)=4;
    r=sx;
    c=sy-1;
    m=m+1;
elseif(d(sx+1,sy-1)==1)
    ch(m)=5;
    r=sx+1;
    c=sy-1;
    m=m+1;
elseif(d(sx+1,sy)==1)
    ch(m)=6;
    r=sx+1;
    c=sy;
    m=m+1;
elseif(d(sx+1,sy+1)==1)
    ch(m)=7;
    r=sx+1;
    c=sy+1;
    m=m+1;
end
tr(r,c)=1;
dir=zeros(1,8);
flag=0;
while(flag<2 && neighbour(d,r,c)>0)
    if(d(r,c+1)==1)
    dir(1)=1;
    end
if(d(r-1,c+1)==1)
    dir(2)=1;
end
if(d(r-1,c)==1)
 dir(3)=1;
end
if(d(r-1,c-1)==1)
    dir(4)=1;
end
if(d(r,c-1)==1)
    dir(5)=1;
end
if(d(r+1,c-1)==1)
    dir(6)=1;
end
if(d(r+1,c)==1)
    dir(7)=1;
end
if(d(r+1,c+1)==1)
    dir(8)=1;
end
sa=ch(m-1)+1;
pe=sa+1;
ag=sa-1;
if(ag==0)
    ag=8;
end
if(pe==9)
    pe=1;
end
if(dir(sa)==1)
    ch(m)=sa-1;
elseif(dir(pe)==1)
    ch(m)=pe-1;
elseif(dir(ag)==1)
    ch(m)=ag-1;
else
    for ct=1:8
        if(dir(ct)==1 && ct~=mod((3+sa),8)+1)
            ch(m)=ct-1;
            break;
        end
    end
end
    switch(ch(m))
        case 0
            c=c+1;
        case 1
            r=r-1;
            c=c+1;
        case 2
            r=r-1;
        case 3
            r=r-1;
            c=c-1;
        case 4
            c=c-1;
        case 5
            r=r+1;
            c=c-1;
        case 6
            r=r+1;
        case 7
            r=r+1;
            c=c+1;
    end
    dir=zeros(1,8);
    m=m+1;
    if(tr(r,c)==1)
        flag=flag+1;
    else
        tr(r,c)=1;
    end
    if(flag==2)
        break
    end
end
m=m-flag;
disp(sx)
disp(sy)
for i=1:m
    disp(ch(i))
end