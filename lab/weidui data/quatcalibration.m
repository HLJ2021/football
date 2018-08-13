clc
clear
A=importdata('legacy1.csv');
data=A(:,1:7);
%data(:,1:3)=data(:,1:3)*1/(data(1,1)+data(1,2)+data(1,3));
q=A(:,13:16);
n=size(q,1);
f=96;
T=1/f;
a1=0;a2=0;
b1=0;b2=0;
c1=0;c2=0;
for i=1:n
    qq=[q(i,1) (-q(i,2)) (-q(i,3)) (-q(i,4))];
    yw(i)=sqrt(data(i,4)^2+data(i,5)^2+data(i,6)^2);
        if yw(i)>0.5
            flag(i,1)=0;
        else
            flag(i,1)=1;
        end
    a(i,1:4)=[0 data(i,1) data(i,2) data(i,3)];
   aaa(i,1:4)=quatmultiply(quatmultiply(q(i,:),a(i,1:4)),qq);
   aaa(i,1:4)=aaa(i,1:4)-[0,0,0,1];
   if i==1
        a1=a1+T*aaa(i,2);
        b1=b1+T*aaa(i,3);
        c1=c1+T*aaa(i,4);
        vel(i,1)=a1;
        vel(i,2)=b1;
        vel(i,3)=c1;
        a2=a2+vel(i,1)*T+T*T*aaa(i,2)/2;
        b2=b2+vel(i,2)*T+T*T*aaa(i,3)/2;
        c2=c2+vel(i,3)*T+T*T*aaa(i,4)/2;
        ss(i,1)=a2;
        ss(i,2)=b2;
        ss(i,3)=c2;
    else
       if flag(i,1)==1
            a1=0;
            b1=0;
            c1=0;
            vel(i,1)=a1;
            vel(i,2)=b1;
            vel(i,3)=c1;
            ss(i,1)=ss(i-1,1);
            ss(i,2)=ss(i-1,2);
            ss(i,3)=ss(i-1,3);
       else
       a1=a1+T*(aaa(i,2)+aaa(i-1,2))/2;
       b1=b1+T*(aaa(i,3)+aaa(i-1,3))/2;
       c1=c1+T*(aaa(i,4)+aaa(i-1,4))/2;
       vel(i,1)=a1;
       vel(i,2)=b1;
       vel(i,3)=c1;

       a2=a2+vel(i,1)*T+T*T*(aaa(i,2)+aaa(i-1,2))/4;
       b2=b2+vel(i,2)*T+T*T*(aaa(i,3)+aaa(i-1,3))/4;
       c2=c2+vel(i,3)*T+T*T*(aaa(i,4)+aaa(i-1,4))/4;
       ss(i,1)=a2;
       ss(i,2)=b2;
       ss(i,3)=c2;
       end
   end
   vectorx=[1 0 0]/100;
    vectory=[0 1 0]/100;
    vectorz=[0 0 1]/100;
   tempA=[0 vectorx];
   tempB=[0 vectory];
   tempC=[0 vectorz];
   %tempA=[0 A];
   %tempB=[0 B];
   %tempC=[0 C];
   tA=quatmultiply(quatmultiply(q(i,:),tempA),qq);
   tB=quatmultiply(quatmultiply(q(i,:),tempB),qq);
   tC=quatmultiply(quatmultiply(q(i,:),tempC),qq);
    %temp = M*temp;
    %xd = [temp(1,1),temp(2,1);temp(1,1),temp(3,1)];
    %yd = [temp(1,2),temp(2,2);temp(1,2),temp(3,2)];
    %zd = [temp(1,3),temp(2,3);temp(1,3),temp(3,3)];
    %xd = [tA(1,2),tB(1,2),tC(1,2)];
    %yd = [tA(1,3),tB(1,3),tC(1,3)];
    %zd = [tA(1,4),tB(1,4),tC(1,4)];
    xd = [tA(1,2),tB(1,2),tC(1,2)]+ss(i,1);
    yd = [tA(1,3),tB(1,3),tC(1,3)]+ss(i,2);
    zd = [tA(1,4),tB(1,4),tC(1,4)]+ss(i,3);
    
   
    
%     figure(10)
%     grid on
%     %view(90,90)
%     plot3([ss(i,1),xd(1,1)],[ss(i,2),yd(1,1)],[ss(i,3),zd(1,1)])
%     text(xd(1,1),yd(1,1),zd(1,1),'X','FontSize',10)
%     hold on
%     %plot3([tB(1,2),tB(1,3),tB(1,4)],[ss(i,1),ss(i,2),ss(i,3)],'r-')
%     %plot3([ss(i,1),tB(1,2)],[ss(i,2),tB(1,3)],[ss(i,3),tB(1,4)])
%     plot3([ss(i,1),xd(1,2)],[ss(i,2),yd(1,2)],[ss(i,3),zd(1,2)])
%     text(xd(1,2),yd(1,2),zd(1,2),'Y','FontSize',10)
%     hold on
%     %plot3([tC(1,2),tC(1,3),tC(1,4)],[ss(i,1),ss(i,2),ss(i,3)],'r-')
%     %plot3([ss(i,1),tC(1,2)],[ss(i,2),tC(1,3)],[ss(i,3),tC(1,4)])
%     plot3([ss(i,1),xd(1,3)],[ss(i,2),yd(1,3)],[ss(i,3),zd(1,3)])
%     text(xd(1,3),yd(1,3),zd(1,3),'Z','FontSize',10)
%     hold on
%     %surf(xd,yd,zd)
%     %view(90,90)
%     %axis([-2 2 -2 2 -2 2])
%     xlabel('x')
%     ylabel('y')
%     zlabel('z')
%     %text(xd(1,1),yd(1,1),zd(1,1),'A','FontSize',6)
%     %text(xd(1,2),yd(1,2),zd(1,2),'B','FontSize',6)
%     %text(xd(2,2),yd(2,2),zd(2,2),'C','FontSize',6)
%     titlename=strcat(int2str(i) ,'of', int2str(n));
%     title(titlename)
%     hold on
%     F(i)=getframe(gcf);
end
   figure()
   t=0:T:(n-1)*T;
    subplot(2,1,1)
    plot(t,vel(:,1)',t,vel(:,2)',t,vel(:,3)','LineWidth',2)
    legend('x','y','z')
    subplot(2,1,2)
    plot(t,ss(:,1)',t,ss(:,2)',t,ss(:,3)','LineWidth',2)
    legend('x','y','z');
   