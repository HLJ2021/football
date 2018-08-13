function q=OriginalQuat(ax,ay,az)

norm1=sqrt(ax(1,1)*ax(1,1)+ay(1,1)*ay(1,1)+az(1,1)*az(1,1));
     ax(1,1)=ax(1,1)/norm1;
     ay(1,1)=ay(1,1)/norm1;
     az(1,1)=az(1,1)/norm1;
     roll=atan(ay(1,1)/az(1,1));
     pitch=asin(-ax(1,1)/1); % 1 when unit of a is g ; the unit of legacy is unknow
      mx=-ay(1,1)/sqrt(ax(1,1)^2+ay(1,1)^2);
      my=ax(1,1)/sqrt(ax(1,1)^2+ay(1,1)^2);
      mz=0;
      yaw=atan(-my*cos(roll)/mx*cos(pitch)+my*sin(pitch)*sin(roll));
      qs_w=angle2quat(yaw,pitch,roll);
      qw_s=quatconj(qs_w);
      xs_w=quatmultiply(quatmultiply(qs_w,(1,0,0)),qw_s);
      angle=atan(xs_w(1)/xs_w(2));
      qs_E=(cos(angle/2),0,0,-sin(angle/2));
      
