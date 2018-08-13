clc
clear
for i=2:2
   % i=2;
    str= strcat ('left', int2str(i) , '.csv');  % 连接字符串形成图像的文件名
     %data=csvread(str,1,1);
     %data=csvread(str,1,2);
     data=csvread(str,3,2);
     data(:,1:3)=data(:,1:3)/65535*2*4;
     data(:,4:6)=data(:,4:6)/65535*2*2000*pi/180;
    [y yw t aa w norm1 norm2]=wavefilter(data);
    
    %t=t1;
    %aa=aa11;
    %w=w11;
    figure(2)
    subplot(2,1,1);
    plot(t,aa(:,1)',t,aa(:,2)',t,aa(:,3)','LineWidth',2)
    legend('x','y','z')
    subplot(2,1,2)
    plot(t,w(:,1)',t,w(:,2)',t,w(:,3)','LineWidth',2)
    legend('x','y','z')
    filename=strcat('figleft', int2str(i) , '.fig');
    saveas(gcf,filename);
    cla;
    
    figure(1)
    %plot(t,y',t,yw','LineWidth',2)
    ax1=subplot(2,1,1);
    plot(t,y','LineWidth',2)
    xlabel('t unit:s')
    ylabel('a unit:g')
    hold on
    subplot(2,1,2);
    plot(t,yw','LineWidth',2)
    xlabel('t unit:s')
    ylabel('w unit:°/s')
    %legend('a','w');
    hold on
    
    
    
    Y=[y yw];
   % norm1=1;
   % norm2=0;
    index=indexsegementation1(Y,norm1,norm2);  
    %index=indexsegementation1(Y,norm1,norm2);
   % norm1=1;
   % norm2=0;
    
    y=y(index);
    %w=w(index);
    t1=t(index);
    yw=yw(index);
    %t2=t(index1);
    ax2=subplot(2,1,1);
    scatter(t1,y','LineWidth',2)
    hold on
    subplot(2,1,2)
    scatter(t1,yw','LineWidth',2)
    filename=strcat('segementr', int2str(i) , '.fig');
    saveas(gcf,filename);
    filename1=strcat('segementr', int2str(i) , '.jpg');
    saveas(gcf,filename1);
    cla;
    cla(ax1);
    cla(ax2);
    
    n=size(index,1);
    if n>0
        ind1=index(1,1);
        ind2=index(2,1);
        if index(1,1)>60
            y1=w(1:ind1,:);
            aa1=aa(1:ind1,:);
            [angle1 n1]=gainangle(y1);
            %filename2=strcat('3Dangler', int2str(i) ,'(1)','.fig');
            %saveas(gcf,filename2);
            %filename3=strcat('3Dangler', int2str(i)  ,'(1)', '.jpg');
            %saveas(gcf,filename3);
            
            figure(3)
            T=0.01;
            t=0:T:n1*T;
            plot(t,angle1(:,1)',t,angle1(:,2)',t,angle1(:,3)','LineWidth',2)
            xlabel('t unit:s')
            ylabel('angle unit:rad')
            legend('x','y','z')
            filename4=strcat('angler', int2str(i),'(1)' , '.fig');
            saveas(gcf,filename4);
            filename5=strcat('angler', int2str(i) ,'(1)', '.jpg');
            saveas(gcf,filename5);
          
             [F ss]=motion(y1,aa1,norm1);
             filename9=strcat('anglenewr', int2str(i) ,'(1)', '.fig');
             saveas(gcf,filename9);
             filename6=strcat('anglesbackrnew', int2str(i) ,'(1)', '.avi');
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
                filename8=strcat('anglernew', int2str(i) ,'(1)', '.jpg');
                saveas(gcf,filename8);
        end
    
        for j=1:n-1
            in2=index(j+1,1);
            in1=index(j,1);
            if in2-in1>60 && in2-in1<100
            %if in2-in1>60
                y1=w(in1:in2,:);
                aa1=aa(in1:in2,:);
                [angle1 n1]=gainangle(y1);
                %filename2=strcat('3Dangler', int2str(i) ,'(', int2str(j+1),')','.fig');
                %saveas(gcf,filename2);
                %filename3=strcat('3Dangler', int2str(i)  ,'(', int2str(j+1),')', '.jpg');
                %saveas(gcf,filename3);
            
                figure(3)
                T=0.01;
                t=0:T:n1*T;
                plot(t,angle1(:,1)',t,angle1(:,2)',t,angle1(:,3)','LineWidth',2)
                xlabel('t unit:s')
                ylabel('angle unit:rad')
                legend('x','y','z')
                filename4=strcat('angler', int2str(i),'(', int2str(j+1),')' , '.fig');
                saveas(gcf,filename4);
                filename5=strcat('angler', int2str(i) ,'(', int2str(j+1),')', '.jpg');
                saveas(gcf,filename5);
            
                [F ss]=motion(y1,aa1,norm1);
                filename9=strcat('anglenewr', int2str(i) ,'(', int2str(j+1),')', '.fig');
                saveas(gcf,filename9);
                filename6=strcat('anglenewr', int2str(i) ,'(', int2str(j+1),')', '.avi');
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
                filename7=strcat('anglernew', int2str(i) ,'(', int2str(j+1),')', '.fig');
                saveas(gcf,filename7);
                filename8=strcat('anglelrnew', int2str(i) ,'(', int2str(j+1),')', '.jpg');
                saveas(gcf,filename8);
            end
        end
    end
end
    
    
    
    %nw=size(w,1);
    %if n==1
     %   t1=index(1,1);
      %   y1=w(1:t1,:);
       %  y2=w(t1+1:nw,:);
        % [angle1 n1]=gainangle(y2);
        % filename2=strcat('3Dangler0', int2str(i) , '.fig');
        %saveas(gcf,filename2);
        %filename3=strcat('3Dangler0', int2str(i) , '.jpg');
        %saveas(gcf,filename3);
    %end
     %if n==2
      %  a1=index(1,1);
       % a2=index(2,1);
        %y1=w(1:a1,:);
        %y2=w(a1+1:a2,:);
        %y3=w(a2+1:nw,:);
        %[angle1 n1]=gainangle(y3);
        %filename2=strcat('3Dangler0', int2str(i) , '.fig');
        %saveas(gcf,filename2);
        %filename3=strcat('3Dangler0', int2str(i) , '.jpg');
        %saveas(gcf,filename3);
     %end
     %if n>=3
      %   t1=index(1,1);
       %  t2=index(2,1);
        % t3=index(3,1);
         %y1=w(1:t1,:);
         %y2=w(t1+1:t2,:);
         %y3=w(t2+1:t3,:);
         %y4=w(t3+1:nw,:);
         %[angle1 n1]=gainangle(y2);
        %filename2=strcat('3Dangler0', int2str(i) , '.fig');
        %saveas(gcf,filename2);
        %filename3=strcat('3Dangler0', int2str(i) , '.jpg');
        %saveas(gcf,filename3);
     %end

    
    
%end