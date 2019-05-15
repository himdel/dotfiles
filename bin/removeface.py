#!/usr/bin/env python
# coding=utf-8

import os

import numpy as np
import cv2 as cv

face_cascade = cv.CascadeClassifier('/usr/share/opencv4/haarcascades/haarcascade_frontalface_default.xml')

def process_frame(img):
    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

    faces = face_cascade.detectMultiScale(gray, 1.3, 5)
    for (x,y,w,h) in faces:
        #cv.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
        face_image = img[y:(y+h), x:(x+w)]
        face_image = cv.GaussianBlur(face_image, (99, 99), 30)
        img[y:(y+h), x:(x+w)] = face_image

cap = cv.VideoCapture('./in.mp4')
count = 0

frame_width = int(cap.get(3))
frame_height = int(cap.get(4))
out = cv.VideoWriter('./out.mp4', cv.VideoWriter_fourcc('M','P','4','V'), 10, (frame_width,frame_height))

while cap.isOpened():
    ret, frame = cap.read()
    process_frame(frame)
    out.write(frame)

    if (count % 100 == 0):
        print(count)

    count = count + 1
    if cv.waitKey(10) & 0xFF == ord('q'):
        break


cap.release()
out.release()

cv.waitKey(0)
cv.destroyAllWindows()
