clc;
clear;
a=imread('C:\Users\Shant-Gamma\Desktop\image\5.jpg');
b=rgb2gray(a);
c=b<180;
e=imresize(c,[64 64]);
d=bwmorph(e,'thin',Inf);
st=zeros(2,10);
tr=zeros(64);
ch=zeros(1,4000);
m=1;
horizontal=0;
vertical=0;
ridia=0;
ledia=0;
flag8=0;
for i=2:63
    for j=2:63
        if(d(i,j)==1 && neighbour(d,i,j)==1)
            st(1,m)=i;
            st(2,m)=j;
            m=m+1;
        end
    end
end
flag1=0;
if(m==1)
    flag8=1;
    for i=1:64
        for j=1:64
            if(d(i,j)==1)
            st(1,m)=i;
            st(2,m)=j;
            m=m+1;
            flag1=1;
            break
            end
        end
        if(flag1==1)
        break
        end
    end
end
l=m-1;
junc=zeros(64);
m=0;
canc=zeros(64);
for i=2:63
    for j=2:63
        if(d(i,j)==1 && trueneighbours(d,i,j)>=3 && canc(i,j)==0)
            %jun(i,j)=1;
            m=m+1;
            junc(i,j)=1;
            %junc(3,m)=trueneighbours(d,i,j);
        end
    end
end
%noOfJunction=m
%for i=1:m
    %x=junc(1,i)
    %y=junc(2,i)
    %neighbour(d,junc(1,i),junc(2,i))
%end
%[area,perimeter]=regarea(d)
for i=1:l
m=1;
sx=st(1,i);
sy=st(2,i);
if(tr(sx,sy)==1)
    break;
end
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
%elseif(dir(pe)==1)
    %ch(m)=pe-1;
%elseif(dir(ag)==1)
    %ch(m)=ag-1;
end
if(ch(m)==0)
    if(junc(r,c)==1 && flag8==0)
        break;
    end
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
startx=sx
starty=sy
for i=1:m
    disp(ch(i))
end
if(m>2)
[h,r,v,le]=lines(ch,m);
horizontal=horizontal+h;
ridia=ridia+r;
vertical=vertical+v;
ledia=ledia+le;
end
end
horizontal
normalHor=1-((horizontal/10)*2)
vertical
normalVert=1-((vertical/10)*2)
ridia
normalrdia=1-((ridia/10)*2)
ledia
normaldia=1-((ledia/10)*2)
[area,perimeter]=regarea(d)
loops=1-bweuler(d,8)