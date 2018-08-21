function[Threshold1,Threshold2]=Threshold(a,w)
n=size(a,1);
b=0;c=0;th1=0;th2=0;
for i=11:(n-10)
if a(i,1)<=a((i-10),1)&&a(i,1)<=a(i-1,1)&&a(i,1)<=a(i+1,1)&&a(i,1)<=a(i+10,1)
%if a(i,1)<=a(i-10,1)&&a(i,1)<=a(i+10,1)
th1=th1+a(i,1);
b=b+1;
end
if w(i,1)<=w((i-10),1)&&w(i,1)<=w(i-1,1)&&w(i,1)<=w(i+1,1)&&w(i,1)<=a(i+10,1)
%if w(i,1)<=w(i-10,1)&&w(i,1)<=w(i+10,1)
th2=th2+w(i,1);
c=c+1;
end
end
Threshold1=th1/b;
Threshold2=th2/c;
%Threshold1=th1/b-0.2;
%Threshold2=th2/c-1.2;
end
