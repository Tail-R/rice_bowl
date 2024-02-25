#!/usr/bin/python

# dependencies: opencv, numpy

import os
import sys
import subprocess
import numpy as np # sudo pacman -S python-numpy
import cv2 # sudo pacman -S python-opencv

OPT_CASH = os.getenv("HOME") + "/.cache/L_blur.png"

def blazing_slow_blur(ipt_path):
    try:
        img = cv2.imread(ipt_path)
    except:
        print("invalid args!", file=sys.stderr)
        sys.exit(1)

    if (img is None):
        print("invalid args!", file=sys.stderr)
        sys.exit(1)


    beta = 0 # must be 0 ~ 255
    height, width = img.shape[:2]
    
    blur_res = cv2.GaussianBlur(img, (15, 15), 3)
    dark_res = cv2.subtract(blur_res, np.full((height, width, 3), beta, np.uint8))

    cv2.imwrite(OPT_CASH, dark_res)
    
#---------------------------------------------------------------------
def main():
    args = sys.argv

    if (len(args) != 2):
        sys.exit(1)
    
    # massive "L" blur
    blazing_slow_blur(args[1])

if __name__ == '__main__':
    main()

