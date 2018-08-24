import math
import numpy as np

import data_type



def angle2quat(yaw,pitch,roll):

    """    euler to quaternion
    Args:
        euler ZXY
    Returns:
        quaternion
    """

    q0=math.cos(yaw/2)*math.cos(pitch/2)*math.cos(roll/2)+math.sin(yaw/2)*math.sin(pitch/2)*math.sin(roll/2)
    q1=math.cos(yaw/2)*math.cos(pitch/2)*math.sin(roll/2)-math.sin(yaw/2)*math.sin(pitch/2)*math.cos(roll/2)
    q2=math.cos(yaw/2)*math.sin(pitch/2)*math.cos(roll/2)+math.sin(yaw/2)*math.cos(pitch/2)*math.sin(roll/2)
    q3=math.sin(yaw/2)*math.cos(pitch/2)*math.cos(roll/2)-math.cos(yaw/2)*math.sin(pitch/2)*math.sin(roll/2)
    return [q0,q1,q2,q3]

def quatconj(q):

    """    conjugate the quaternion
    Args:
        inital quaternion
    Returns:
        the conjugated of inital quaternion
    """

    return [q[0],-q[1],-q[2],-q[3]]

def quatmultiply(q,a):

    """    multiply of two quaternions
    Args:
        two quaternions
    Returns:
        the result of multiply of two quaternions
    """

    d0=q[0]*a[0]-q[1]*a[1]-q[2]*a[2]-q[3]*a[3]
    d1=q[1]*a[0]+q[0]*a[1]+q[2]*a[3]-q[3]*a[2]
    d2=q[2]*a[0]+q[0]*a[2]+q[3]*a[1]-q[1]*a[3]
    d3=q[3]*a[0]+q[0]*a[3]+q[1]*a[2]-q[2]*a[1]
    return [d0,d1,d2,d3]

def OriginalQuat(ax,ay,az,xs_s):

    """    calculate the first quaternions
    Args:
        acceleration data and the vector of x axis in sensor coordinate
    Returns:
        first quaternion in global coordinate (default north as the direction of x axis)
    """

    norm1=math.sqrt(ax**2+ay**2+az**2)
    ax=ax/norm1
    ay=ay/norm1
    az=az/norm1
    roll=math.atan(ay/az)
    pitch=math.asin(-ax/1)          # 1 when unit of a is g
    mx=-ay/math.sqrt(ax**2+ay**2)
    my=ax/math.sqrt(ax**2+ay**2)
    mz=0;
    yaw=math.atan(-my*math.cos(roll)/mx*math.cos(pitch)+my*math.sin(pitch)*math.sin(roll))
    #print(roll,pitch,yaw)
    qs_w=angle2quat(yaw,pitch,roll)
    #print('qs_w')
    #print(qs_w)
    qw_s=quatconj(qs_w)
    xs_w=quatmultiply(quatmultiply(qs_w,xs_s),qw_s)
    #print(xs_w)
    angle=math.atan(xs_w[2]/xs_w[1])
    #print(angle)
    qw_E=[math.cos(angle/2),0,0,-math.sin(angle/2)]
    #print(qw_E)
    qs_E=quatmultiply(qw_E,qs_w)
    return qs_E



def motion(acc_data,gyro_data,contact_flag):

    """    calculate the quaternion of each frame and the velocity and position
    Args:
        acceleration data, gyroscope data and contact flag
    Returns:
        quaternions(q0,q1,q2,q3), velocity(x,y,z) and position(x,y,z)
    """

    error=0.0175               # legacy 0.0175    micro team 0.0169
    B=error*math.sqrt(3/4)
    f1=[]
    f2=[]
    f3=[]
    j1124=[]
    j1223=[]
    j1322=[]
    j1421=[]
    j32=[]
    j33=[]
    qq0=[]
    qq1=[]
    qq2=[]
    qq3=[]
    hat1=[]
    hat2=[]
    hat3=[]
    hat4=[]
    aa=[]
    velx=[]
    vely=[]
    velz=[]
    ssx=[]
    ssy=[]
    ssz=[]
    q0=[]
    q1=[]
    q2=[]
    q3=[]
    n=len(acc_data.x_data)
    f=100
    T=1/f

    # detect the inital quaternion
    qs_E=OriginalQuat(acc_data.x_data[0],acc_data.y_data[0],acc_data.z_data[0],[0,1,0,0])
    #print(qs_E)
    q00=qs_E[0]
    q11=qs_E[1]
    q22=qs_E[2];
    q33=qs_E[3];
    q0.append(q00)
    q1.append(q11)
    q2.append(q22)
    q3.append(q33)
    ax=acc_data.x_data
    ay=acc_data.y_data
    az=acc_data.z_data
    wx=gyro_data.x_data
    wy=gyro_data.y_data
    wz=gyro_data.z_data

    # calculate the attitude and position
    for i in range(0,n):

        # use acc data to calculate attitude
        norm2=math.sqrt(ax[i]*ax[i]+ay[i]*ay[i]+az[i]*az[i]);
        axx=ax[i]/norm2
        ayy=ay[i]/norm2
        azz=az[i]/norm2

        ff1=2*q1[i]*q3[i]-2*q0[i]*q2[i]-axx
        ff2=2*q0[i]*q1[i]-2*q2[i]*q3[i]-ayy
        ff3=1-2*q1[i]*q1[i]-2*q2[i]*q2[i]-azz
        jj1124=2*q2[i]
        jj1223=2*q3[i]
        jj1322=2*q0[i]
        jj1421=2*q1[i]
        jj32=2*jj1421
        jj33=2*jj1124

        f1.append(ff1)
        f2.append(ff2)
        f3.append(ff3)
        j1124.append(jj1124)
        j1223.append(jj1223)
        j1322.append(jj1322)
        j1421.append(jj1421)
        j32.append(jj32)
        j33.append(jj33)


        hhat1=j1421[i]*f2[i]-j1124[i]*f1[i];
        hhat2=j1223[i]*f1[i]+j1322[i]*f2[i]-j32[i]*f3[i];
        hhat3=j1223[i]*f2[i]-j33[i]*f3[i]-j1322[i]*f1[i];
        hhat4=j1421[i]*f1[i]+j1124[i]*f2[i];

        hat1.append(hhat1)
        hat2.append(hhat2)
        hat3.append(hhat3)
        hat4.append(hhat4)

        norm3=math.sqrt(hat1[i]*hat1[i]+hat2[i]*hat2[i]+hat3[i]*hat3[i]+hat4[i]*hat4[i]);
        hat1[i]=hat1[i]/norm3;
        hat2[i]=hat2[i]/norm3;
        hat3[i]=hat3[i]/norm3;
        hat4[i]=hat4[i]/norm3;

        # use gyro data to calculate attitude
        qqq0=(-q1[i]*wx[i]-q2[i]*wy[i]-q3[i]*wz[i])/2;
        qqq1=(q0[i]*wx[i]+q2[i]*wz[i]-q3[i]*wy[i])/2;
        qqq2=(q0[i]*wy[i]+q3[i]*wx[i]-q1[i]*wz[i])/2;
        qqq3=(q0[i]*wz[i]+q1[i]*wy[i]-q2[i]*wx[i])/2;

        qq0.append(qqq0)
        qq1.append(qqq1)
        qq2.append(qqq2)
        qq3.append(qqq3)

        q00 = q0[i]+(qq0[i]-B*hat1[i])*0.01;
        q11 = q1[i]+(qq1[i]-B*hat2[i])*0.01;
        q22 = q2[i]+(qq2[i]-B*hat3[i])*0.01;
        q33 = q3[i]+(qq3[i]-B*hat4[i])*0.01;

        q0.append(q00)
        q1.append(q11)
        q2.append(q22)
        q3.append(q33)

        norm = math.sqrt(q0[i+1]*q0[i+1] + q1[i+1]*q1[i+1] + q2[i+1]*q2[i+1] + q3[i+1]*q3[i+1]);
        q0[i+1] = q0[i+1] / norm
        q1[i+1] = q1[i+1] / norm
        q2[i+1] = q2[i+1] / norm
        q3[i+1] = q3[i+1] / norm

        # calculalte the move acceleration
        q=[round(q0[i+1],4),round(q1[i+1],4),round(q2[i+1],4),round(q3[i+1],4)]
        a=[0,round(ax[i],4),round(ay[i],4),round(az[i],4)]
        qq=quatconj(q)
        aaa=quatmultiply(quatmultiply(q,a),qq)
        #print(aaa[0])
        #print(aaa[1])
        #print(aaa[2])
        #print(aaa[3])
        aaa[0]=aaa[0]*9.8
        aaa[1]=aaa[1]*9.8
        aaa[2]=aaa[2]*9.8
        aaa[3]=(aaa[3]-1)*9.8
        #print(aaa[3])

        aa.append(aaa)

        # calculate the velocity and position
        if i==0:
            a1=0
            b1=0
            c1=0
            a1=a1+T*aa[i][1]
            b1=b1+T*aa[i][2]
            c1=c1+T*aa[i][3]
            velx.append(a1)
            vely.append(b1)
            velz.append(c1)
            a2=0
            b2=0
            c2=0
            a2=a2+velx[i]*T+T*T*aa[i][1]/2;
            b2=b2+vely[i]*T+T*T*aa[i][2]/2;
            c2=c2+velz[i]*T+T*T*aa[i][3]/2;
            ssx.append(a2)
            ssy.append(b2)
            ssz.append(c2)
        else:
            if contact_flag[i]==1:
                a1=0
                b1=0
                c1=0
                velx.append(a1)
                vely.append(b1)
                velz.append(c1)
                a2=ssx[i-1]
                b2=ssy[i-1]
                c2=ssz[i-1]
                ssx.append(a2)
                ssy.append(b2)
                ssz.append(c2)
            else:
                a1=a1+T*(aa[i][1]+aa[i-1][1])/2
                b1=b1+T*(aa[i][2]+aa[i-1][2])/2
                c1=c1+T*(aa[i][3]+aa[i-1][3])/2
                velx.append(a1)
                vely.append(b1)
                velz.append(c1)
                a2=a2+velx[i]*T+T*T*(aa[i][1]+aa[i-1][1])/4
                b2=b2+vely[i]*T+T*T*(aa[i][2]+aa[i-1][2])/4
                c2=c2+velz[i]*T+T*T*(aa[i][3]+aa[i-1][3])/4
                ssx.append(a2)
                ssy.append(b2)
                ssz.append(c2)
    velx.append(0)
    vely.append(0)
    velz.append(0)
    ssx.append(0)
    ssy.append(0)
    ssz.append(0)
    quater=data_type.Quat(q0,q1,q2,q3)
    vel=data_type.Vec3Data(velx,vely,velz)
    ss=data_type.Vec3Data(ssx,ssy,ssz)

    return data_type.Motion(quater,vel,ss)
