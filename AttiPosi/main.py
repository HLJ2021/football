import os
import matplotlib.pyplot as plt
import pandas as pd

import readData
import Cal_Acc_Gyro
import motion

file_dir=os.getcwd();
print (file_dir)
data_file_number='2';

#   1. read data
measure_data=readData.readData(file_dir,data_file_number)
print (measure_data.frames)

#   2. calculate total acc and gyro and detect the contact
contact_flag=Cal_Acc_Gyro.contac_detection(measure_data.acc_data,measure_data.gyro_data,measure_data.frames)

#   3. calculate the attitude and position
calculate_data=motion.motion(measure_data.acc_data,measure_data.gyro_data,contact_flag)
"""
#   4. plot the signal of vel and position
fig=plt.figure
ax1=fig.subplot(2,1,1)
ax1.plot(t,calculate_data.vel.x_data,t,calculate_data.vel.y_data,t,calculate_data.vel.z_data)
ax1.legend('x','y','z')
ax2=fig.subplot(2,1,2)
ax2.plot(t,calculate_data.ss.x_data,t,calculate_data.ss.y_data,t,calculate_data.ss.z_datat)
ax2.legend('x','y','z')
"""
#   5. save the attitude and position data
data_frame=pd.DataFrame({'quaternion(q0)':calculate_data.quat.q0,
'quaternion(q1)':calculate_data.quat.q1,'quaternion(q2)':calculate_data.quat.q2,
'quaternion(q3)':calculate_data.quat.q3,'velocity(x)':calculate_data.vel.x_data,
'velocity(y)':calculate_data.vel.y_data,'velocity(z)':calculate_data.vel.z_data,
'position(x)':calculate_data.ss.x_data,'position(y)':calculate_data.ss.y_data,
'position(z)':calculate_data.ss.z_data})
file_name=file_dir+'//Processed Data//posiData'+data_file_number+'.csv'
data_frame.to_csv(file_name,index=False,sep=',')
