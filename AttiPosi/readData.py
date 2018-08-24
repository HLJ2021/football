import csv
import numpy as np
import os
import math

import data_type


def readData(file_dir,data_file_number):

    Freq=100.0
    T=1.0/Freq
#    Para_rad2deg=math.pi/180.0;

    frame=0
    Left_Acc_x=[]
    Left_Acc_y=[]
    Left_Acc_z=[]
    Left_Gyro_x=[]
    Left_Gyro_y=[]
    Left_Gyro_z=[]
    Right_Acc_x=[]
    Right_Acc_y=[]
    Right_Acc_z=[]
    Right_Gyro_x=[]
    Right_Gyro_y=[]
    Right_Gyro_z=[]

    file_dir=file_dir+'\\Processed Data\\data'+data_file_number+'_p.csv'
    with open (file_dir) as csvfile:
      reader=csv.reader(csvfile)
      for row in reader:
          L_Acc_x = float(row[15])
          L_Acc_y=float(row[16])
          L_Acc_z=float(row[17])
          L_Gyro_x=float(row[18])
          L_Gyro_y=float(row[19])
          L_Gyro_z=float(row[20])
          """
          L_Gyro_x=float(row[18])*Para_rad2deg
          L_Gyro_y=float(row[19])*Para_rad2deg
          L_Gyro_z=float(row[20])*Para_rad2deg
          """
          R_Acc_x=float(row[31])
          R_Acc_y=float(row[32])
          R_Acc_z=float(row[33])
          R_Gyro_x=float(row[34])
          R_Gyro_y=float(row[35])
          R_Gyro_z=float(row[36])
          """
          R_Gyro_x=float(row[34])*Para_rad2deg
          R_Gyro_y=float(row[35])*Para_rad2deg
          R_Gyro_z=float(row[36])*Para_rad2deg
          """

          Left_Acc_x.append(L_Acc_x)
          Left_Acc_y.append(L_Acc_y)
          Left_Acc_z.append(L_Acc_z)
          Left_Gyro_x.append(L_Gyro_x)
          Left_Gyro_y.append(L_Gyro_y)
          Left_Gyro_z.append(L_Gyro_z)
          Right_Acc_x.append(R_Acc_x)
          Right_Acc_y.append(R_Acc_y)
          Right_Acc_z.append(R_Acc_z)
          Right_Gyro_x.append(R_Gyro_x)
          Right_Gyro_y.append(R_Gyro_y)
          Right_Gyro_z.append(R_Gyro_z)

          frame=frame+1
#          print(Left_Acc_x)
    acc_data = data_type.Vec3Data(Left_Acc_x, Left_Acc_y, Left_Acc_z);
    gyro_data = data_type.Vec3Data(Left_Gyro_x, Left_Gyro_y, Left_Gyro_z);
    #print (acc_data.x_data)

    return data_type.IMUData(acc_data, gyro_data)
