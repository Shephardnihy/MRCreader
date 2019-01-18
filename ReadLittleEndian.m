%% Description
%Sub Function for MRCreader read header and the corresponding data
%Please refer to CCP-EM website for the meaning of each field
%
%Dimension of the image field determined by nx and ny
%Data type of the image field determined by mode
%For now only 2 dimensional(nz=1) file is supported

function DataStruct = ReadLittleEndian(FID)
% Rewind the pointer to the head of the file
frewind(FID);

%Read Header
%
%Image Dimension
DataStruct.nx =  fread(FID,1,'*uint32');
DataStruct.ny =  fread(FID,1,'*uint32');
DataStruct.nz =  fread(FID,1,'*uint32');

%Data Type
DataStruct.mode =  fread(FID,1,'*uint32');

%Location of first column/row/section
DataStruct.nxstart =  fread(FID,1,'*uint32');
DataStruct.nystart =  fread(FID,1,'*uint32');
DataStruct.nzstart =  fread(FID,1,'*uint32');

%Sampling
DataStruct.mx =  fread(FID,1,'*uint32');
DataStruct.my =  fread(FID,1,'*uint32');
DataStruct.mz =  fread(FID,1,'*uint32');

%Voxel Dimension-Length
DataStruct.cella.x =  fread(FID,1,'*single');
DataStruct.cella.y =  fread(FID,1,'*single');
DataStruct.cella.z =  fread(FID,1,'*single');

%Voxel Dimension-Angle
DataStruct.cellb.alpha =  fread(FID,1,'*single');
DataStruct.cellb.beta =  fread(FID,1,'*single');
DataStruct.cellb.gamma =  fread(FID,1,'*single');

%Axis
DataStruct.mapc =  fread(FID,1,'*uint32');
DataStruct.mapr =  fread(FID,1,'*uint32');
DataStruct.maps =  fread(FID,1,'*uint32');

%Image info
DataStruct.dmin =  fread(FID,1,'*single');
DataStruct.dmax =  fread(FID,1,'*single');
DataStruct.dmean =  fread(FID,1,'*single'); 
DataStruct.ispg =  fread(FID,1,'*single');

%Extra info
DataStruct.nsymbt =  fread(FID,1,'*single');
DataStruct.extra =  fread(FID,25,'*single');

%File info
DataStruct.origin =  fread(FID,3,'*single');
DataStruct.map =  fread(FID,1,'*single');
DataStruct.machst =  fread(FID,4,'*uint8');
DataStruct.rms =  fread(FID,1,'*single');

%Labels
DataStruct.nlabel =  fread(FID,1,'*uint32');
DataStruct.labels =  fread(FID,200,'*single');

%Read Data
switch DataStruct.mode
    case 0
        DataStruct.image =  fread(FID,[DataStruct.nx DataStruct.ny],'*int8');
    case 1
        DataStruct.image =  fread(FID,[DataStruct.nx DataStruct.ny],'*int16');
    case 2
        DataStruct.image =  fread(FID,[DataStruct.nx DataStruct.ny],'*single');
    case {3,4}
        error('Complex data type not supported.')
    case 6
        DataStruct.image =  fread(FID,[DataStruct.nx DataStruct.ny],'*uint16');
end

end