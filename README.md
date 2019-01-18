# MRCreader
A Matlab MRC reader to read header/data according to MRC/CCP4 format

## A Brief Description
This is a MRC reader script developed by Matlab. For more detailed MRC/CCP4 format description, please refer to http://www.ccpem.ac.uk/.

This script can do these things(updating):
- Read a MRC file and extract information from header
- Show the data correctly as little-endian
- Save the data as little-endian
- Save the data into Matlab workspace as a struct
- Save the data into another MRC file

Some known problems and function need to be added:
- Batch Processing
- Complex data type unsupported
- 3D file(Image along z-axis) is currently unsupported

Because MRC/CCP4 file format is designed for Cryo-EM but I do not do Cryo, I am in short of useful and varied data to test my script, the robustness of my script can be very poor. If you encounter any problem or any advice, please submit pull-request with some useful data which can be helpful to improve the program.

## Prequisites
Matlab R2017b, other versions of Matlab not tested

## Installation
- Clone/Download the repository to local
- Run Matlab and change the path to directory contains scripts or add the directory to Matlab Environmental Path
- Run scripts in Matlab console

## Run
```matlab
    DataStruct = MRCreader(FilePath,WriteFlag,WriteType)
```

## Parameters

### FilePath
 - The path of the file needed to be opened
 - File will be opened as read-only mode

### WriteFlag(Optional)
 - Input: 'T' or 'F', 'F' by default
 - Input 'T' to write a new MRC file and 'F' vice versa
 - Output File Name: '_original filename_-out.mrc'
 - Output File Path: The same as the original file

### WriteType(Optional)
The script supports a type conversion of image data. 

Hint: data might be changed during conversion because the data range of different types is different(i.e. uint8: from 0 to 255 and uint16: from 0 to 65535). Know what you are doing when you are using this function.

- Input: 'int8', 'int16','single','uint16', no data conversion by default