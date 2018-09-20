import math
import os
import matplotlib.pyplot as plt
import numpy as np
import csv

import data_type


def quaternion2euler(data,order):
    '''
    q0=data.q0
    q1=data.q1
    q2=data.q2
    q3=data.q3
    '''

    a_list=[]
    b_list=[]
    r_list=[]

    for q0,q1,q2,q3 in zip(data.q0,data.q1,data.q2,data.q3):
        #z-y-x
        if order == 'zyx':
            #a=math.atan2(2*(q0*q1+q2*q3),(1-2*(q1**2+q2**2)))
            a=math.atan2(1-2*(q1**2+q2**2),2*(q0*q1+q2*q3))
            b=math.asin(2*(q0*q2-q1*q3))
            r=math.atan2(1-2*(q2**2+q3**2),2*(q0*q3+q1*q2))
            #r=math.atan2(2*(q0*q3+q1*q2),(1-2*(q2**2+q3**2)))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #z-y-z
        if order == 'zyz':
            #a=math.atan2(2*(q1*q2 - q3*q0),2*(q0*q2 + q3*q1))
            a=math.atan2(2*(q0*q2 + q3*q1),2*(q1*q2 - q3*q0))
            b=math.acos(q3*q3 - q0*q0 - q1*q1 + q2*q2)
            r=math.atan2(-2*(q0*q2 - q3*q1),2*(q1*q2 + q3*q0))
            #r=math.atan2(2*(q1*q2 + q3*q0),-2*(q0*q2 - q3*q1))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #z-x-y
        if order == 'zxy':
            #a=math.atan2(-2*(q0*q1 - q3*q2),q3*q3 - q0*q0 + q1*q1 - q2*q2)
            a=math.atan2(q3*q3 - q0*q0 + q1*q1 - q2*q2,-2*(q0*q1 - q3*q2))
            b=math.asin(2*(q1*q2 + q3*q0))
            r=math.atan2(q3*q3 - q0*q0 - q1*q1 + q2*q2,-2*(q0*q2 - q3*q1))
            #r=math.atan2(-2*(q0*q2 - q3*q1),q3*q3 - q0*q0 - q1*q1 + q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #z-x-z
        if order == 'zxz':
            #a=math.atan2(2*(q0*q2 + q3*q1),-2*(q1*q2 - q3*q0))
            a=math.atan2(-2*(q1*q2 - q3*q0),2*(q0*q2 + q3*q1))
            b=math.acos(q3*q3 - q0*q0 - q1*q1 + q2*q2)
            r=math.atan2(2*(q1*q2 + q3*q0),2*(q0*q2 - q3*q1))
            #r=math.atan2(2*(q0*q2 - q3*q1),2*(q1*q2 + q3*q0))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #y-x-z
        if order == 'yxz':
            #a=math.atan2(2*(q0*q2 + q3*q1),q3*q3 - q0*q0 - q1*q1 + q2*q2)
            a=math.atan2(q3*q3 - q0*q0 - q1*q1 + q2*q2,2*(q0*q2 + q3*q1))
            b=math.asin(-2*(q1*q2 - q3*q0))
            r=math.atan2(q3*q3 - q0*q0 + q1*q1 - q2*q2,2*(q0*q1 + q3*q2))
            #r=math.atan2(2*(q0*q1 + q3*q2),q3*q3 - q0*q0 + q1*q1 - q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #y-x-y
        if order == 'yxy':
            #a=math.atan2(2*(q0*q1 - q3*q2),2*(q1*q2 + q3*q0))
            a=math.atan2(2*(q1*q2 + q3*q0),2*(q0*q1 - q3*q2))
            b=math.acos(q3*q3 - q0*q0 + q1*q1 - q2*q2)
            r=math.atan2(-2*(q1*q2 - q3*q0),2*(q0*q1 + q3*q2))
            #r=math.atan2(2*(q0*q1 + q3*q2),-2*(q1*q2 - q3*q0))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #y-z-x
        if order == 'yzx':
            #a=math.atan2(-2*(q0*q2 - q3*q1),q3*q3 + q0*q0 - q1*q1 - q2*q2)
            a=math.atan2(q3*q3 + q0*q0 - q1*q1 - q2*q2,-2*(q0*q2 - q3*q1))
            b=math.asin(2*(q0*q1 + q3*q2))
            r=math.atan2(q3*q3 - q0*q0 + q1*q1 - q2*q2,-2*(q1*q2 - q3*q0))
            #r=math.atan2(-2*(q1*q2 - q3*q0),q3*q3 - q0*q0 + q1*q1 - q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #y-z-y
        if order == 'yzy':
            #a=math.atan2( 2*(q1*q2 + q3*q0),-2*(q0*q1 - q3*q2))
            a=math.atan2( -2*(q0*q1 - q3*q2),2*(q1*q2 + q3*q0))
            b=math.acos(q3*q3 - q0*q0 + q1*q1 - q2*q2)
            r=math.atan2(2*(q0*q1 + q3*q2), 2*(q1*q2 - q3*q0))
            #r=math.atan2( 2*(q1*q2 - q3*q0),2*(q0*q1 + q3*q2))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #x-y-z
        if order == 'xyz':
            #a=math.atan2(-2*(q1*q2 - q3*q0),q3*q3 - q0*q0 - q1*q1 + q2*q2)
            a=math.atan2(q3*q3 - q0*q0 - q1*q1 + q2*q2,-2*(q1*q2 - q3*q0))
            b=math.asin(2*(q0*q2 + q3*q1))
            r=math.atan2(q3*q3 + q0*q0 - q1*q1 - q2*q2,-2*(q0*q1 - q3*q2))
            #r=math.atan2(-2*(q0*q1 - q3*q2),q3*q3 + q0*q0 - q1*q1 - q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #x-y-x
        if order == 'xyx':
            #a=math.atan2(2*(q0*q1 + q3*q2),-2*(q0*q2 - q3*q1))
            a=math.atan2(-2*(q0*q2 - q3*q1),2*(q0*q1 + q3*q2))
            b=math.acos(q3*q3 + q0*q0 - q1*q1 - q2*q2)
            r=math.atan2( 2*(q0*q2 + q3*q1),2*(q0*q1 - q3*q2),)
            #r=math.atan2( 2*(q0*q1 - q3*q2),2*(q0*q2 + q3*q1))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #x-z-y
        if order == 'xzy':
            #a=math.atan2(2*(q1*q2 + q3*q0),q3*q3 - q0*q0 + q1*q1 - q2*q2)
            a=math.atan2(q3*q3 - q0*q0 + q1*q1 - q2*q2,2*(q1*q2 + q3*q0))
            b=math.asin(-2*(q0*q1 - q3*q2))
            r=math.atan2(q3*q3 + q0*q0 - q1*q1 - q2*q2,2*(q0*q2 + q3*q1))
            #r=math.atan2(2*(q0*q2 + q3*q1),q3*q3 + q0*q0 - q1*q1 - q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #x-z-x
        if order == 'xzx':
            #a=math.atan2(2*(q0*q2 - q3*q1),2*(q0*q1 + q3*q2))
            a=math.atan2(2*(q0*q1 + q3*q2),2*(q0*q2 - q3*q1))
            b=math.acos(q3*q3 + q0*q0 - q1*q1 - q2*q2)
            r=math.atan2(-2*(q0*q1 - q3*q2),2*(q0*q2 + q3*q1))
            #r=math.atan2(2*(q0*q2 + q3*q1),-2*(q0*q1 - q3*q2))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

    return a_list,b_list,r_list,order

class Quat():
    """ quaternion.
    """
    def __init__(self, q0, q1, q2, q3):
        self.q0 = q0
        self.q1 = q1
        self.q2 = q2
        self.q3 = q3

def smoothlist(data):
    n = len(data)
    for i in range(0,n-1):
        if data[i+1]-data[i] >= 6:
            data[i+1] = data[i+1]-2*math.pi
        elif data[i+1]-data[i] <= -6:
            data[i+1] = data[i+1] + 2*math.pi
    return data

f=100
T=1/f
frame=0
q0_list=[]
q1_list=[]
q2_list=[]
q3_list=[]

data_number='26-2'
#file_dir=os.getcwd();
file_dir='F:\\python(football)\\football-data-process\\Data\\footballDATA(set)\\180814(legacy only)\\data'+data_number+'_p.csv'
with open (file_dir) as csvfile:
  reader=csv.reader(csvfile)
  for row in reader:
      q0 = float(row[12])
      q1 = float(row[13])
      q2 = float(row[14])
      q3 = float(row[15])
#      print(q0,q1,q2,q3)
      q0_list.append(q0)
      q1_list.append(q1)
      q2_list.append(q2)
      q3_list.append(q3)
      frame=frame+1

data = Quat(q0_list,q1_list,q2_list,q3_list)
a_list,b_list,r_list,order = quaternion2euler(data,'xzx')
a_list = smoothlist(a_list)
b_lsit = smoothlist(b_list)
r_list = smoothlist(r_list)

#print(a_list)
n=len(a_list)
t=np.linspace(0,(n-1)*T,n)
plt.plot(t,a_list,label='a')
plt.plot(t,b_list,label='b')
plt.plot(t,r_list,label='r')
plt.legend()
fig_name='F:\\python(football)\\football-data-process\\Data\\footballDATA(set)\\180814(legacy only)\\quaternion2euler\\q2e'+ data_number + order
plt.savefig(fig_name+'.jpg')
