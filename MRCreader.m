%% Description of the script
% MRC/CCP4 Reader for reading headers and data in a .mrc file
% Please check http://www.ccpem.ac.uk/ for detailed information about the
% meaning of all the headers and for maintainence
%
% The Script reads in MRC/CCP4 file and do these things:
% 1. Check the byte order of the file
% 2. Read file header and data
% 3. Store all the data in a matlab struct in current workspace
% 4. Write out a fixed byte-order MRC/CCP4 file(Optional)
%
%
% Written By Haoyang Ni, 2018-2019

%% Main Function
% Input must include: FilePath
%
% WriteFlag can be 'T' or 'F', other input or no input is assumed 'F'
%
% WriteType include the output data type, 'int8'/'int16'/'single'/'uint16'
% supported, no conversion by default. If the data type is not consistent
% to native data type, conversion will be performed
% 
% Important: data type conversion may lead to changed image pixel value due to
% different data ranges of different types. If you insist to use this
% function, at least the byte number should be consistent i.e. convert from
% 'uint16' to 'int16'
%
% Output File will be at the same directory of the original file, the name
% would be "filename-out.mrc"

function DataStruct=MRCreader(FilePath,WriteFlag,WriteType)
%Get File path, name and extension
[filepath,name,ext] = fileparts(FilePath);

%Open File
switch nargin
    case 0
        error('Not Enough Input');
    case 1
        [FID,FIDmessage] = fopen(FilePath,'r');
        WriteFlag = 'F';
        WriteType = 'n';
    case 2
        [FID,FIDmessage] = fopen(FilePath,'r');
        if WriteFlag == 'T'
            WriteType = 'n';
        else
            WriteFlag = 'F';
        end
    case 3
        [FID,FIDmessage] = fopen(FilePath,'r');
    otherwise
        error('Too Many Input');
end

if FID == -1
    error('No Such File or Directory');
end

%Check ByteOrder
LittleEndianByteOrder = ['44';'44'];
BigEndianByteOrder = ['11';'11'];
fseek(FID,212,-1);
Machst = dec2hex(fread(FID,4,'*uint8'));

switch [Machst(1:2);Machst(3:4)]
    case LittleEndianByteOrder
        DataStruct = ReadLittleEndian(FID);
    case BigEndianByteOrder
        DataStruct = ReadBigEndian(FID);
    otherwise
        DataStruct = ReadBigEndian(FID);
end

%Close opened file before writing a new one
fclose(FID);



%Write File(Optional)
switch WriteType
    case 'int8'
    case 'int16'
    case 'single'
    case 'uint16'
    otherwise
        WriteType = class(DataStruct.image);
end

if WriteFlag == 'T'
    WriteMRC(filepath,name,ext,WriteType,DataStruct);
end


end