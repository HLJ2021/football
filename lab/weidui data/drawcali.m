clc
clear
A=importdata('legacy1.csv');
ss=A(:,7:12);
q=A(:,13:16);
n=size(ss,1);
f=96;
T=1/f;
t=0:T:(n-1)*T;

for i=1:n
    qq=[q(i,1) (-q(i,2)) (-q(i,3)) (-q(i,4))];
    vectorx=[-1 0 0]/100;
    vectory=[0 -1 0]/100;
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
   xd = [tA(1,2),tB(1,2),tC(1,2)]+ss(i,1);
    yd = [tA(1,3),tB(1,3),tC(1,3)]+ss(i,2);
    zd = [tA(1,4),tB(1,4),tC(1,4)]+ss(i,3);
    
     figure(10)
    grid on
    %view(90,90)
    plot3([ss(i,1),xd(1,1)],[ss(i,2),yd(1,1)],[ss(i,3),zd(1,1)])
    text(xd(1,1),yd(1,1),zd(1,1),'X','FontSize',10)
    hold on
    %plot3([tB(1,2),tB(1,3),tB(1,4)],[ss(i,1),ss(i,2),ss(i,3)],'r-')
    %plot3([ss(i,1),tB(1,2)],[ss(i,2),tB(1,3)],[ss(i,3),tB(1,4)])
    plot3([ss(i,1),xd(1,2)],[ss(i,2),yd(1,2)],[ss(i,3),zd(1,2)])
    text(xd(1,2),yd(1,2),zd(1,2),'Y','FontSize',10)
    hold on
    %plot3([tC(1,2),tC(1,3),tC(1,4)],[ss(i,1),ss(i,2),ss(i,3)],'r-')
    %plot3([ss(i,1),tC(1,2)],[ss(i,2),tC(1,3)],[ss(i,3),tC(1,4)])
    plot3([ss(i,1),xd(1,3)],[ss(i,2),yd(1,3)],[ss(i,3),zd(1,3)])
    text(xd(1,3),yd(1,3),zd(1,3),'Z','FontSize',10)
    hold on
    %surf(xd,yd,zd)
    %view(90,90)
    %axis([-2 2 -2 2 -2 2])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    %text(xd(1,1),yd(1,1),zd(1,1),'A','FontSize',6)
    %text(xd(1,2),yd(1,2),zd(1,2),'B','FontSize',6)
    %text(xd(2,2),yd(2,2),zd(2,2),'C','FontSize',6)
    titlename=strcat(int2str(i) ,'of', int2str(n));
    title(titlename)
    hold on
    F(i)=getframe(gcf);
end




   
   