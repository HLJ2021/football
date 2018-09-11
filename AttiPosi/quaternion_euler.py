import math


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
            a=math.atan2(2*(q0*q1+q2*q3),(1-2*(q1**2+q2**2)))
            b=math.arcsin(2*(q0*q2-q1*q3))
            r=math.atan2(2*(q0*q3+q1*q2),(1-2*(q2**2+q3**2)))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #z-y-z
        if oder == 'zyz':
            a=math.atan2(2*(q1*q2 - q3*q0),2*(q0*q2 + q3*q1))
            b=math.arccos(q3*q3 - q0*q0 - q1*q1 + q2*q2))
            r=math.atan2(2*(q1*q2 + q3*q0),-2*(q0*q2 - q3*q1))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #z-x-y
        if order == 'zxy':
            a=math.atan2(-2*(q0*q1 - q3*q2),q3*q3 - q0*q0 + q1*q1 - q2*q2)
            b=math.arcsin(2*(q1*q2 + q3*q0))
            r=math.atan2(-2*(q0*q2 - q3*q1),q3*q3 - q0*q0 - q1*q1 + q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #z-x-z
        if order == 'zxz':
            a=math.atan2(2*(q0*q2 + q3*q1),-2*(q1*q2 - q3*q0))
            b=math.arccos(q3*q3 - q0*q0 - q1*q1 + q2*q2)
            r=math.atan2(2*(q0*q2 - q3*q1),2*(q1*q2 + q3*q0))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #y-x-z
        if order == 'yxz':
            a=math.atan2(2*(q0*q2 + q3*q1),q3*q3 - q0*q0 - q1*q1 + q2*q2)
            b=math.arcsin(-2*(q1*q2 - q3*q0))
            r=math.atan2(2*(q0*q1 + q3*q2),q3*q3 - q0*q0 + q1*q1 - q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #y-x-y
        if order == 'yxy':
            a=math.atan2(2*(q0*q1 - q3*q2),2*(q1*q2 + q3*q0))
            b=math.arccos(q3*q3 - q0*q0 + q1*q1 - q2*q2)
            r=math.atan2( 2*(q0*q1 + q3*q2),-2*(q1*q2 - q3*q0))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #y-z-x
        if order == 'yzx':
            a=math.atan2(-2*(q0*q2 - q3*q1),q3*q3 + q0*q0 - q1*q1 - q2*q2)
            b=math.arcsin(2*(q0*q1 + q3*q2))
            r=math.atan2(-2*(q1*q2 - q3*q0),q3*q3 - q0*q0 + q1*q1 - q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #y-z-y
        if order == 'yzy':
            a=math.atan2( 2*(q1*q2 + q3*q0),-2*(q0*q1 - q3*q2))
            b=math.arccos(q3*q3 - q0*q0 + q1*q1 - q2*q2)
            r=math.atan2( 2*(q1*q2 - q3*q0),2*(q0*q1 + q3*q2))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #x-y-z
        if order == 'xyz':
            a=math.atan2(-2*(q1*q2 - q3*q0),q3*q3 - q0*q0 - q1*q1 + q2*q2)
            b=math.arcsin(2*(q0*q2 + q3*q1))
            r=math.atan2(-2*(q0*q1 - q3*q2),q3*q3 + q0*q0 - q1*q1 - q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #x-y-x
        if order == 'xyx':
            a=math.atan2(2*(q0*q1 + q3*q2),-2*(q0*q2 - q3*q1))
            b=math.arccos(q3*q3 + q0*q0 - q1*q1 - q2*q2)
            r=math.atan2( 2*(q0*q1 - q3*q2),2*(q0*q2 + q3*q1))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #x-z-y
        if order == 'xzy':
            a=math.atan2(2*(q1*q2 + q3*q0),q3*q3 - q0*q0 + q1*q1 - q2*q2)
            b=math.arcsin(-2*(q0*q1 - q3*q2))
            r=math.atan2(2*(q0*q2 + q3*q1),q3*q3 + q0*q0 - q1*q1 - q2*q2)
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

        #x-z-x
        if order == 'xzx':
            a=math.atan2(2*(q0*q2 - q3*q1),2*(q0*q1 + q3*q2))
            b=math.arccos(q3*q3 + q0*q0 - q1*q1 - q2*q2)
            r=math.atan2(2*(q0*q2 + q3*q1),-2*(q0*q1 - q3*q2))
            a_list.append(a)
            b_list.append(b)
            r_list.append(r)

    return a_list,b_list,r_list
