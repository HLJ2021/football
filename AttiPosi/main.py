import os

import readData
import Cal_Acc_Gyro
import data_type

file_dir=os.getcwd();
print (file_dir)
data_file_number='1';

#   1. read data
measure_data=readData.readData(file_dir,data_file_number)
print (measure_data)

#   2. calculate total acc and gyro
total=Cal_Acc_Gyro.CalculateTotal(measure_data.acc_data,measure_data.gyro_data)
