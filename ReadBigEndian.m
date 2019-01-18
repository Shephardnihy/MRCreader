%% Description
%Sub Function for MRCreader read header and the corresponding data
%Please refer to CCP-EM website for the meaning of each field
%
%Dimension of the image field determined by nx and ny
%Data type of the image field determined by mode
%For now only 2 dimensional(nz=1) file is supported

function DataStruct = ReadBigEndian(FID)
frewind(FID);

%Read Header
%
%Image Dimension
DataStruct.nx =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.ny =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.nz =  swapbytes(fread(FID,1,'*uint32'));

%Data Type
DataStruct.mode =  swapbytes(fread(FID,1,'*uint32'));

%Location of first column/row/section
DataStruct.nxstart =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.nystart =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.nzstart =  swapbytes(fread(FID,1,'*uint32'));

%Sampling
DataStruct.mx =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.my =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.mz =  swapbytes(fread(FID,1,'*uint32'));

%Voxel Dimension-Length
DataStruct.cella.x =  swapbytes(fread(FID,1,'*single'));
DataStruct.cella.y =  swapbytes(fread(FID,1,'*single'));
DataStruct.cella.z =  swapbytes(fread(FID,1,'*single'));

%Voxel Dimension-Angle
DataStruct.cellb.alpha =  swapbytes(fread(FID,1,'*single'));
DataStruct.cellb.beta =  swapbytes(fread(FID,1,'*single'));
DataStruct.cellb.gamma =  swapbytes(fread(FID,1,'*single'));

%Axis
DataStruct.mapc =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.mapr =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.maps =  swapbytes(fread(FID,1,'*uint32'));

%Image info
DataStruct.dmin =  swapbytes(fread(FID,1,'*single'));
DataStruct.dmax =  swapbytes(fread(FID,1,'*single'));
DataStruct.dmean =  swapbytes(fread(FID,1,'*single')); 
DataStruct.ispg =  swapbytes(fread(FID,1,'*single'));

%Extra info
DataStruct.nsymbt =  swapbytes(fread(FID,1,'*single'));
DataStruct.extra =  swapbytes(fread(FID,25,'*single'));

%File info
DataStruct.origin =  swapbytes(fread(FID,3,'*single'));
DataStruct.map =  swapbytes(fread(FID,1,'*single'));
DataStruct.machst =  swapbytes(fread(FID,4,'*uint8'));
DataStruct.rms =  swapbytes(fread(FID,1,'*single'));

%Labels
DataStruct.nlabel =  swapbytes(fread(FID,1,'*uint32'));
DataStruct.labels =  swapbytes(fread(FID,200,'*single'));

%Read Data
switch DataStruct.mode
    case 0
        DataStruct.image =  swapbytes(fread(FID,[DataStruct.nx DataStruct.ny],'*int8'));
    case 1
        DataStruct.image =  swapbytes(fread(FID,[DataStruct.nx DataStruct.ny],'*int16'));
    case 2
        DataStruct.image =  swapbytes(fread(FID,[DataStruct.nx DataStruct.ny],'*single'));
    case {3,4}
        error('Complex data type not supported.')
    case 6
        DataStruct.image =  swapbytes(fread(FID,[DataStruct.nx DataStruct.ny],'*uint16'));

end

end