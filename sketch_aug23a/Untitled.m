clc;
ok=1;
c=1;n=1;c3=0;c4=0;
speed=250;
v3=[0;0;];
v4=[0;0;];
sampleno=1000;
t=[];
for n=1:sampleno
    v3(n)=k(c);
    v4(n)=k(c+1);
    c=c+2;
end
for n=2:sampleno
    t(n)=n;
    if v3(n)==1
        if v3(n-1)==0
            c3=c3+1;
        end
    else
        if v3(n-1)==1
            c3=c3+1;
        end
    end  
    if v4(n)==1
        if v4(n-1)==0
            c4=c4+1;
        end
    else
        if v4(n-1)==1
            c4=c4+1;
        end
    end
end
    subplot(2,1,1)
    title(num2str(c3))
    plot(t,v3(1:n))
    subplot(2,1,2)
    title(num2str(c4))
    plot(t,v4(1:n))
if exist('vals')
    vals=[vals;speed c3;];
    plot(vals(:,1),vals(:,2))
else
    vals=[speed c3];
end
plot(vals(:,1),vals(:,2))