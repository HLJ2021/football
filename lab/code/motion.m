%function [F vel ss q]=motion(w,aa,yw,flag)
function [vel ss q]=motion(w,aa,yw,flag)
wx=w(:,1);
wy=w(:,2);
wz=w(:,3);
ax=aa(:,1);
ay=aa(:,2);
az=aa(:,3);
%error=mean(yw(1:20,1));
error=0.0175; % legacy 0.0175, microteam 0.0169
B1=error*sqrt(3/4);
%B1=1;
f1=[];
f2=[];
f3=[];
j1124=[];
j1223=[];
j1322=[];
j1421=[];
j32=[];
j33=[];
n=size(w,1);
qq0=zeros(n,1);
qq1=zeros(n,1);
qq2=zeros(n,1);
qq3=zeros(n,1);
%detect the inital quaternion
qs_E=OriginalQuat(ax(1,1),ay(1,1),az(1,1),[0 1 0 0]);
q0(1,1)=qs_E(1,1);
q1(1,1)=qs_E(1,2);
q2(1,1)=qs_E(1,3);
q3(1,1)=qs_E(1,4);
q(1,:)=qs_E;


% q0(1,1)=1;
% q1(1,1)=0;
% q2(1,1)=0;
% q3(1,1)=0;
% q(1,:)=[1,0,0,0];
% q0(1,1)=0.9405;
% q1(1,1)=0.2654;
% q2(1,1)=-0.1268;
% q3(1,1)=-0.1701;
% q(1,:)=[0.9405,0.2655,-0.1268,-0.1701];

%left foot coordinate
vectorx=[1 0 0]/100;
vectory=[0 1 0]/100;
vectorz=[0 0 1]/100;
%left foot
%xd1=[-1 1;-1 1]/100;
%yd1=[0 -1; 0 1]/100;
%zd1=[0 0;0 0]/100;
%A=[xd1(1,1),yd1(1,1),zd1(1,1)];
%B=[xd1(1,2),yd1(1,2),zd1(1,2)];
%C=[xd1(2,2),yd1(2,2),zd1(2,2)];
%left
%xd1=[-1 1;-1 1]/5;
%yd1=[0 -1; 0 1]/5;
%zd1=[0 0;0 0]/5;

    figure(4)
    %axis([-2 2 -2 2 -2 2])
    %plot3([1/100,0,0],[0,0,0],'r-')
    plot3([0,1/100],[0,0],[0,0])
    text(1/100,0,0,'X','FontSize',10)
    hold on
    %plot3([0,1/100,0],[0,0,0],'r-')
    plot3([0,0],[0,1/100],[0,0])
    text(0,1/100,0,'Y','FontSize',10)
    hold on
    %plot3([0,0,1/100],[0,0,0],'r-')
    plot3([0,0],[0,0],[0,1/100])
    text(0,0,1/100,'Z','FontSize',10)
    hold on
    %surf(xd1,yd1,zdl)
    xlabel('x')
    ylabel('y')
    zlabel('z')
    %text(xd1(1,1),yd1(1,1),zd1(1,1),'A','FontSize',6)
    %text(xd1(1,2),yd1(1,2),zd1(1,2),'B','FontSize',6)
    %text(xd1(2,2),yd1(2,2),zd1(2,2),'C','FontSize',6)
    %text(A,'A','FontSize',6)
    %text(B,'B','FontSize',6)
    %text(C,'C','FontSize',6)
    %F(1)=getframe;
   %aviobj=movie3avi('qua.avi','fps',10);
   %j=1;
   a1=0;a2=0;
   b1=0;b2=0;
   c1=0;c2=0;
   vel(1,1)=0;ss(1,1)=0;
   vel(1,2)=0;ss(1,2)=0;
   vel(1,3)=0;ss(1,3)=0;
   %g=[0;0;-norm1];
for i=1:n-1
%     xw_w=quatmultiply(quatmultiply(q(i,:),[0 1 0 0]),quatconj(q(i,:)));
%     if i==1
%         qs_E=OriginalQuat(ax(i,1),ay(i,1),az(i,1),[0 xw_w(:,2) xw_w(:,3) 0]);
%     else
%         qs_E=OriginalQuat(ax(i-1,1),ax(i-1,1),ax(i-1,1),[0 xw_w(:,2) xw_w(:,3) 0]);
%     end
%     q0(i,1)=qs_E(1,1);
%     q1(i,1)=qs_E(1,2);
%     q2(i,1)=qs_E(1,3);
%     q3(i,1)=qs_E(1,4);
%     q(i,:)=qs_E;

    qq0(i,1)=(-q1(i,1)*wx(i,1)-q2(i,1)*wy(i,1)-q3(i,1)*wz(i,1))/2;
    qq1(i,1)=(q0(i,1)*wx(i,1)+q2(i,1)*wz(i,1)-q3(i,1)*wy(i,1))/2;
    qq2(i,1)=(q0(i,1)*wy(i,1)+q3(i,1)*wx(i,1)-q1(i,1)*wz(i,1))/2;
    qq3(i,1)=(q0(i,1)*wz(i,1)+q1(i,1)*wy(i,1)-q2(i,1)*wx(i,1))/2;

    %x=abs(sqrt(ax(i,1)^2+ay(i,1)^2+az(i,1)^2)-1);
    %B1=1-(1/sqrt(2*0.5*pi)*exp(-(x-0.2)^2/2*0.5));

    norm2=sqrt(ax(i,1)*ax(i,1)+ay(i,1)*ay(i,1)+az(i,1)*az(i,1));
    ax(i,1)=ax(i,1)/norm2;
    ay(i,1)=ay(i,1)/norm2;
    az(i,1)=az(i,1)/norm2;

%     xw_w=quatmultiply(quatmultiply(q(i,:),[0 1 0 0]),quatconj(q(i,:)));
%     if i>1
%         qs_E=OriginalQuat(ax(i-1,1),ax(i-1,1),ax(i-1,1),[0 xw_w(:,2) xw_w(:,3) 0]);
%     end
%     q0_c(i,1)=qs_E(1,1);
%     q1_c(i,1)=qs_E(1,2);
%     q2_c(i,1)=qs_E(1,3);
%     q3_c(i,1)=qs_E(1,4);
%     q_c(i,:)=qs_E;
%
%     f1(i,1)=2*q1_c(i,1)*q3_c(i,1)-2*q0_c(i,1)*q2_c(i,1)-ax(i,1);
%     f2(i,1)=2*q0_c(i,1)*q1_c(i,1)-2*q2_c(i,1)*q3_c(i,1)-ay(i,1);
%     f3(i,1)=1-2*q1_c(i,1)*q1_c(i,1)-2*q2_c(i,1)*q2_c(i,1)-az(i,1);
%     j1124(i,1)=2*q2_c(i,1);
%     j1223(i,1)=2*q3_c(i,1);
%     j1322(i,1)=2*q0_c(i,1);
%     j1421(i,1)=2*q1_c(i,1);
%     j32(i,1)=2*j1421(i,1);
%     j33(i,1)=2*j1124(i,1);

    f1(i,1)=2*q1(i,1)*q3(i,1)-2*q0(i,1)*q2(i,1)-ax(i,1);
    f2(i,1)=2*q0(i,1)*q1(i,1)-2*q2(i,1)*q3(i,1)-ay(i,1);
    f3(i,1)=1-2*q1(i,1)*q1(i,1)-2*q2(i,1)*q2(i,1)-az(i,1);
    j1124(i,1)=2*q2(i,1);
    j1223(i,1)=2*q3(i,1);
    j1322(i,1)=2*q0(i,1);
    j1421(i,1)=2*q1(i,1);
    j32(i,1)=2*j1421(i,1);
    j33(i,1)=2*j1124(i,1);

    hat1(i,1)=j1421(i,1)*f2(i,1)-j1124(i,1)*f1(i,1);
    hat2(i,1)=j1223(i,1)*f1(i,1)+j1322(i,1)*f2(i,1)-j32(i,1)*f3(i,1);
    hat3(i,1)=j1223(i,1)*f2(i,1)-j33(i,1)*f3(i,1)-j1322(i,1)*f1(i,1);
    hat4(i,1)=j1421(i,1)*f1(i,1)+j1124(i,1)*f2(i,1);

    norm3=sqrt(hat1(i,1)*hat1(i,1)+hat2(i,1)*hat2(i,1)+hat3(i,1)*hat3(i,1)+hat4(i,1)*hat4(i,1));
    hat1(i,1)=hat1(i,1)/norm3;
    hat2(i,1)=hat2(i,1)/norm3;
    hat3(i,1)=hat3(i,1)/norm3;
    hat4(i,1)=hat4(i,1)/norm3;

    q0(i+1,1) = q0(i,1)+(qq0(i,1)-B1*hat1(i,1))*0.01;
    q1(i+1,1) = q1(i,1)+(qq1(i,1)-B1*hat2(i,1))*0.01;
    q2(i+1,1) = q2(i,1)+(qq2(i,1)-B1*hat3(i,1))*0.01;
    q3(i+1,1) = q3(i,1)+(qq3(i,1)-B1*hat4(i,1))*0.01;

    %q0(i+1,1) = q0(i,1)+((1-B1)*qq0(i,1)-B1*hat1(i,1))*0.01;
    %q1(i+1,1) = q1(i,1)+((1-B1)*qq1(i,1)-B1*hat2(i,1))*0.01;
    %q2(i+1,1) = q2(i,1)+((1-B1)*qq2(i,1)-B1*hat3(i,1))*0.01;
    %q3(i+1,1) = q3(i,1)+((1-B1)*qq3(i,1)-B1*hat4(i,1))*0.01;

    norm = sqrt(q0(i+1,1)*q0(i+1,1) + q1(i+1,1)*q1(i+1,1) + q2(i+1,1)*q2(i+1,1) + q3(i+1,1)*q3(i+1,1));
    q0(i+1,1) = q0(i+1,1) / norm;
    q1(i+1,1) = q1(i+1,1) / norm;
    q2(i+1,1) = q2(i+1,1) / norm;
    q3(i+1,1) = q3(i+1,1) / norm;
    q(i+1,:)=[q0(i+1,1) q1(i+1,1) q2(i+1,1) q3(i+1,1)];
    qq=[q0(i+1,1) (-q1(i+1,1)) (-q2(i+1,1)) (-q3(i+1,1))];

   % M=[1-2*(q2(i+1,1)^2+q3(i+1,1)^2) 2*(q1(i+1,1)*q2(i+1,1)-q0(i+1,1)*q3(i+1,1)) 2*(q0(i+1,1)*q2(i+1,1)+q1(i+1,1)*q3(i+1,1));
   %     2*(q1(i+1,1)*q2(i+1,1)+q0(i+1,1)*q3(i+1,1)) 1-2*(q1(i+1,1)^2+q3(i+1,1)^2) 2*(q2(i+1,1)*q3(i+1,1)-q0(i+1,1)*q1(i+1,1));
   %     2*(q1(i+1,1)*q3(i+1,1)-q0(i+1,1)*q2(i+1,1)) 2*(q2(i+1,1)*q3(i+1,1)+q0(i+1,1)*q1(i+1,1)) 1-2*(q1(i+1,1)^2+q2(i+1,1)^2)];
   %g=q*[0;0;0;norm1]*qq;
   %g=q*[0;0;-norm1];
   a(i,1:4)=[0 aa(i,1) aa(i,2) aa(i,3)];
   %start(1,1:4)=quatmultiply(quatmultiply(q(2,:),a(1,1:4)),qq);
   aaa(i,1:4)=quatmultiply(quatmultiply(q(i+1,:),a(i,1:4)),qq);
   aaa(i,1:4)=aaa(i,1:4)-[0,0,0,1];
   aaa(i,1:4)=aaa(i,1:4)*9.8;
   %aaa(i,1:4)=aaa(i,1:4)-start(1,1:4);

  % aa(i,1)=aa(i,1)-g(1,1);
  % aa(i,2)=aa(i,2)-g(2,1);
  % aa(i,3)=aa(i,3)-g(3,1);
  % aa(i,:)=aa(i,:)-g(1,2:4);

   T=0.01;
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
        %ss(i,:)=ss(i,:)*q;
   end

%    % temp = [xd1(1,1) yd1(1,1) zd1(1,1);
%    %         xd1(1,2) yd1(1,2) zd1(1,2);
%    %         xd1(2,2) yd1(2,2) zd1(2,2)]
%    tempA=[0 vectorx];
%    tempB=[0 vectory];
%    tempC=[0 vectorz];
%    %tempA=[0 A];
%    %tempB=[0 B];
%    %tempC=[0 C];
%    tA=quatmultiply(quatmultiply(q(i+1,:),tempA),qq);
%    tB=quatmultiply(quatmultiply(q(i+1,:),tempB),qq);
%    tC=quatmultiply(quatmultiply(q(i+1,:),tempC),qq);
%     %temp = M*temp;
%     %xd = [temp(1,1),temp(2,1);temp(1,1),temp(3,1)];
%     %yd = [temp(1,2),temp(2,2);temp(1,2),temp(3,2)];
%     %zd = [temp(1,3),temp(2,3);temp(1,3),temp(3,3)];
%     %xd = [tA(1,2),tB(1,2),tC(1,2)];
%     %yd = [tA(1,3),tB(1,3),tC(1,3)];
%     %zd = [tA(1,4),tB(1,4),tC(1,4)];
%     xd = [tA(1,2),tB(1,2),tC(1,2)]+ss(i,1);
%     yd = [tA(1,3),tB(1,3),tC(1,3)]+ss(i,2);
%     zd = [tA(1,4),tB(1,4),tC(1,4)]+ss(i,3);
%
%
%
%     figure(4)
%     grid on
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
%     %aviobj=addframe(aviobj,F);
%     %im=frame2im(F);
%     %[I,map]=rgb2ind(im,256);
%     %imwrite(im,'qua.gif','gif','DelayTime',0.1,'writemode','append')
%
%     %xd=xd-ss(i,1);
%     %yd=yd-ss(i,2);
%     %zd=zd-ss(i,3);

end

end
