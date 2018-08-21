class IMUData():
     """ IMU raw data of both feet.
     Data include 3 axis acceleration (Vec3Data), 3 axis gyroscope (Vec3Data) and total data frames number.
     """
     def __init__(self, acc_data, gyro_data):
        self.acc_data = acc_data
        self.gyro_data = gyro_data
        self.frames = len(acc_data.x_data)

class Vec3():
    """ 3 dimensional vector.
    """
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

class Vec3Data():
    """ 3 dimensional vector data list, stores x, y, z data individually.
    """
    def __init__(self, x_data, y_data, z_data):
        self.x_data = x_data
        self.y_data = y_data
        self.z_data = z_data

class Quat():
    """ quaternion.
    """
    def __init__(self, q0, q1, q2, q3):
        self.q0 = q0
        self.q1 = q1
        self.q2 = q2
        self.q3 = q3
