# -*- coding: utf-8 -*-
"""
Created on Mon Aug 20 10:04:44 2018

@author: HLJ
"""
import math



def angle2quat(yaw,pitch,roll):
    q0=math.cos(yaw/2)*math.cos(pitch/2)*math.cos(roll/2)-math.sin(yaw/2)*math.sin(pitch/2)*math.sin(roll/2)
    q1=math.cos(yaw/2)*math.cos(pitch/2)*math.sin(roll/2)+math.sin(yaw/2)*math.sin(pitch/2)*math.cos(roll/2)
    q2=math.cos(yaw/2)*math.sin(pitch/2)*math.cos(roll/2)-math.sin(yaw/2)*math.cos(pitch/2)*math.sin(roll/2)
    q3=math.sin(yaw/2)*math.cos(pitch/2)*math.cos(roll/2)+math.cos(yaw/2)*math.sin(pitch/2)*math.sin(roll/2)
    return [q0,q1,q2,q3]

def quatconj(q):
    return [q[0],-q[1],-q[2],-q[3]]

def quatmultiply(q,a):
    
    d0=q[0]*a[0]-q[1]*a[1]-q[2]*a[2]-q[3]*a[3]
    d1=q[1]*a[0]+q[0]*a[1]+q[2]*a[3]-q[3]*a[2]
    d2=q[2]*a[0]+q[0]*a[2]+q[3]*a[1]-q[1]*a[3]
    d3=q[3]*a[0]+q[0]*a[3]+q[1]*a[2]-q[2]*a[1]
    return [d0,d1,d2,d3]

q=angle2quat(0.2170,-0.1613,0.5792)
qw_s=quatconj(q)
xs_w=quatmultiply(quatmultiply(q,[0,1,0,0]),qw_s)
angle=math.atan(xs_w[2]/xs_w[1])
qw_E=[math.cos(angle/2),0,0,-math.sin(angle/2)]
qs_E=quatmultiply(qw_E,q)