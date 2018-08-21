import math
import numpy as np

import data_type

def CalculateTotal(x,y,z):
    """
    Total=[]
    for  in x,y,z:
    total=sqrt(x^2+y^2+z^2);
    Total.append(total)
    print (Total)
    return Total
    """
    a=np.array(x)
    b=np.array(y)
    c=np.array(z)
    a=[math.pow(aa,2) for aa in a]
    b=[math.pow(bb,2) for bb in b]
    c=[math.pow(cc,2) for cc in c]
    d=np.sum(a,b,c)
    total=[math.sqrt(dd) for dd in d]
    print (total)
    return total

"""
def Threshold(total_Acc,total_Gyro)
    b=0
    c=0
    th1=0
    th2=0
#    for total_Acc,total_Gyro in range (11,n-10)
#        if total_Acc(j)<=
"""
