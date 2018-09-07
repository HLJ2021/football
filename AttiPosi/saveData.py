import csv

def savedata(data, file_dir, data_file_number):
    file_name=file_dir+'//Processed Data//posiData'+'attiPosi'+data_file_number+'.csv'
    with open(file_name,'w',newline='') as f:
        writer=csv.writer(f, delimiter=',')
        total_frame=len(data.vel.x_data)
        for i in range(total_frame):
            frame=data.
