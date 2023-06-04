import serial 
import numpy as np
import cv2 as cv
import time

serial_data = serial.Serial("COM4",9600)
ARRAY_SIZE = 90000

print("Reading data from serial port...")
start = time.time()
dat = serial_data.read(ARRAY_SIZE)
print("Data read from serial port...")
end = time.time()
print(f"Time taken to read data from serial port: {np.round(end-start,2)}s")
im = np.frombuffer(dat, dtype=np.uint8)
img = im.reshape(300,300)
cv.imshow("img", img)
cv.waitKey(0)
cv.destroyAllWindows()
serial_data.close()