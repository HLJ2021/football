clc
clear
f=100;
T=1/f;
for i=1:1
    str= strcat ('left', int2str(i) , '.csv');  % 连接字符串形成图像的文件名
    %读取数据
    %fileID=fopen(str);
    %data=fread(fileID);
    A =importdata(str);
    n=size(A.data,1);
    data=A.data(3:n,:);
    index=A.textdata(4:n+1,1);
    index=str2num(char(index));
    %dataraw=csvread(str,3,2);
    %n=size(dataraw,1);
    %index=csvread(str,3,0,[3,0,22,0]);
    data(:,1:3)=data(:,1:3)/65535*2*4;
    data(:,4:6)=data(:,4:6)/65535*2*2000*pi/180;
    %data(:,1:3)=data(:,1:3)/65535*2*4;
    %data(:,4:6)=data(:,4:6)/65535*2*2000;
    
    %插值，补缺失数值
    x=index;
    y=data;
    xx=index(1):1:index(n-2);
    data=interp1(x,y,xx');
    n=size(data,1);
    
    %滤波
    [y yw t aa w norm1 norm2]=wavefilter(data);
    subplot(2,1,1);
    plot(t,aa(:,1)',t,aa(:,2)',t,aa(:,3)',t,y','LineWidth',2)
    legend('x','y','z','total')
    subplot(2,1,2)
    plot(t,w(:,1)',t,w(:,2)',t,w(:,3)',t,yw','LineWidth',2)
    legend('x','y','z','total')
    filename=strcat('figleft', int2str(i) , '.fig');
    saveas(gcf,filename);
    cla;
    
    %分段：swing and stance
    for ij=1:n
        if yw(ij)>0.5  % 
            flag(ij,1)=0;
        else
            flag(ij,1)=1;
        end
        %if abs(yw(ij)-yw(ij-1))==1
    end
    index1=find(yw>0.02);
    a=index1(1,1)-200;
    b=a+1000;
    yw=yw(a:b,1);
    y=y(a:b,1);
    aa=aa(a:b,:);
    w=w(a:b,:);
    flag=flag(a:b,1);
    n=size(w,1);
    
    %姿态轨迹还原
    %swing
    [F vel ss q]=motion(w,aa,yw,flag);
    t=0:T:(n-2)*T;
    figure()
    subplot(2,1,1)
    plot(t,vel(:,1)',t,vel(:,2)',t,vel(:,3)','LineWidth',2)
    legend('x','y','z')
    subplot(2,1,2)
    plot(t,ss(:,1)',t,ss(:,2)',t,ss(:,3)','LineWidth',2)
    legend('x','y','z')
    %subplot(2,1,1)
    %plot(t,vel(:,1)',t,vel(:,2)','LineWidth',2)
    %legend('x','y')
    %subplot(2,1,2)
    %plot(t,ss(:,1)',t,ss(:,2)','LineWidth',2)
    %legend('x','y')
    filename11=strcat('velandss',int2str(i),'.fig');
    saveas(gcf,filename11);
     filename9=strcat('anglenewr', int2str(i) , '.fig');
     saveas(gcf,filename9);
     filename6=strcat('anglesbackrnew', int2str(i) , '.avi');
     v=VideoWriter(filename6);
     v.FrameRate=5;
     open(v)
     writeVideo(v,F)
     close(v)
     cla(figure(4));
             
     figure(5)
     stem3(ss(:,1),ss(:,2),ss(:,3),'LineWidth',2)
     
     %view(90,90)
     xlabel('x')
     ylabel('y')
     zlabel('z')
     filename7=strcat('anglernew', int2str(i) ,'(1)', '.fig');
     saveas(gcf,filename7);
     %filename8=strcat('anglernew', int2str(i) ,'(1)', '.jpg');
     %saveas(gcf,filename8);
    
    
end