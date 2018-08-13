function [y yw t aa w norm1 norm2]=wavefilter(data)
   %str= strcat ('swalklre', int2str(i) , '.csv');  % 连接字符串形成图像的文件名
   %data=csvread(str,1,2);
   f=100;
   T=1/f;
   n=size(data,1);
   %[yx,cxd1,lxd1] = wden((data(:,1)/1000),'sqtwolog','s','one',2,'db3');
   %[yy,cxd2,lxd2] = wden((data(:,2)/1000),'sqtwolog','s','one',2,'db3');
   %[yz,cxd3,lxd3] = wden((data(:,3)/1000),'sqtwolog','s','one',2,'db3');
   [yx,cxd1,lxd1] = wden((data(:,1)),'sqtwolog','s','one',2,'db3');
   [yy,cxd2,lxd2] = wden((data(:,2)),'sqtwolog','s','one',2,'db3');
   [yz,cxd3,lxd3] = wden((data(:,3)),'sqtwolog','s','one',2,'db3');
   aa=[yx yy yz];
   
   %[wx,cxd,lxd] = wden((data(:,4)/1000),'sqtwolog','s','one',2,'db3');
   %[wy,cxd4,lxd4] = wden((data(:,5)/1000),'sqtwolog','s','one',2,'db3');
   %[wz,cxd5,lxd5] = wden((data(:,6)/1000),'sqtwolog','s','one',2,'db3');
   [wx,cxd,lxd] = wden((data(:,4)),'sqtwolog','s','one',2,'db3');
   [wy,cxd4,lxd4] = wden((data(:,5)),'sqtwolog','s','one',2,'db3');
   [wz,cxd5,lxd5] = wden((data(:,6)),'sqtwolog','s','one',2,'db3');
   w=[wx wy wz];
   
   totala=zeros(n,1);
   totalw=zeros(n,1);
   for i1=1:n
       totala(i1,1)=sqrt(yx(i1,1)^2+yy(i1,1)^2+yz(i1,1)^2);
       totalw(i1,1)=sqrt(wx(i1,1)^2+wy(i1,1)^2+wz(i1,1)^2);
   end
   [y,cxd6,lxd6]=wden(totala,'sqtwolog','s','one',2,'db3');
   [yw,cxd7,lxd7]=wden(totalw,'sqtwolog','s','one',2,'db3');
   
   %标准化
   norm1=mean(y(1:50,1));
   norm2=mean(yw(1:50,1));
  % for i1=1:n
   %    y(i1,1)=y(i1,1)-norm1;
    %   yw(i1,1)=yw(i1,1)-norm2;
   %end
   
   %flag
   %for i=1:n
   % if yw>200
   %     flag(i)=0;
        %index1=find(yw>200);
   % else flag(i)=1;
        %index2=find(yw<=200);
   % end
   
   %index
  % index1=find(yw>200);
  % a=index1(1,1);
  % n1=size(index1,1);
  % b=index1(1,1)+300;
  % c=index1(301,1);
  % if c+300<n
  %     d=c+300;
  % else
  %     d=n;
  % end
  % yw=[yw(a:b,1);yw(c:d,1)];
  % y=[y(a:b,1);y(c:d,1)];
  % aa=[aa(a:b,:);aa(c:d,:)];
  % w=[w(a:b,:);w(c:d,:)];
   
  % n=size(y,1);
   t=0:T:(n-1)*T;
   
   
      
end
   
   
   
  
   
   
   