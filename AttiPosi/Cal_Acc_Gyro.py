import math
import numpy as np
import matplotlib.pyplot as plt

import data_type

f=100
T=1/f

def CalculateTotal(acc_data,gyro_data):
    n=len(acc_data.x_data)
    t=np.linspace(0,(n-1)*T,n)
    acc_total=[]
    gyro_total=[]
    for x,y,z in zip(acc_data.x_data,acc_data.y_data,acc_data.z_data):
        acc_norm=math.sqrt(x**2+y**2+z**2)
        acc_total.append(acc_norm)

    for a,b,c in zip(gyro_data.x_data,gyro_data.y_data,gyro_data.z_data):
        gyro_norm=math.sqrt(a**2+b**2+c**2)
        gyro_total.append(gyro_norm)

    fig=plt.figure
    ax1=fig.subplot(2,1,1)
    ax1.plot(t,acc_data.x_data,t,acc_data.y_data,t,acc_data.z_datat,acc_total)
    ax1.legend('x','y','z','total')
    ax2=fig.subplot(2,1,2)
    ax2.plot(t,gyro_data.x_data,t,gyro_data.y_data,t,gyro_data.z_datat,gyro_total)
    ax2.legend('x','y','z','total')

    count1=0
    count2=0
    th1=0
    th2=0
    for i in range(10,n-11):
        if (acc_total[i]<=acc_total[i-10] and acc_total[i]<=acc_total[i-1] and
            acc_total[i]<=acc_total[i+1] and acc_total[i]<=acc_total[i+10]):
            th1=th1+acc_total[i]
            count1=count1+1
        if (gyro_total[i]<=gyro_total[i-10] and gyro_total[i]<=gyro_total[i-1] and
            gyro_total[i]<=gyro_total[i+1] and gyro_total[i]<=gyro_total[i+10]):
            th2=th2+gyro_total[i]
            count2=count2+1
    threshold1=th1/count1+0.2
    threshold2=th2/count2+0.2

    for j in range(0,n-1):
        if (acc_total[j]>threshold1 and gyro_total[j]>threshold2):
            contact_flag[j]=False
        else:
            contact_flag[j]=True
    return contact_flag
