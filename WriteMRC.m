function WriteMRC(filepath,name,ext,WriteType, DataStruct)
%Construct Output Full File Path
OutName = strcat(name,'-out',ext);
OutPath = fullfile(filepath,OutName);

% Determine Mode
switch WriteType
    case 'int8'
        mode = 0;
    case 'int16'
        mode = 1;
    case 'single'
        mode = 2;
    case 'uint16'
        mode = 6;
    otherwise
        mode = DataStruct.mode;
end

prec = strcat('*',WriteType);


%Write File
[FID, FIDmessage] = fopen(OutPath,'w');

fwrite(FID,DataStruct.nx,'*uint32');
fwrite(FID,DataStruct.ny,'*uint32');
fwrite(FID,DataStruct.nz,'*uint32');

fwrite(FID,mode,'*uint32');

fwrite(FID,DataStruct.nxstart,'*uint32');
fwrite(FID,DataStruct.nystart,'*uint32');
fwrite(FID,DataStruct.nzstart,'*uint32');

fwrite(FID,DataStruct.mx,'*uint32');
fwrite(FID,DataStruct.my,'*uint32');
fwrite(FID,DataStruct.mz,'*uint32');

fwrite(FID,DataStruct.cella.x,'*single');
fwrite(FID,DataStruct.cella.y,'*single');
fwrite(FID,DataStruct.cella.z,'*single');

fwrite(FID,DataStruct.cellb.alpha,'*single');
fwrite(FID,DataStruct.cellb.beta,'*single');
fwrite(FID,DataStruct.cellb.gamma,'*single');

fwrite(FID,DataStruct.mapc,'*uint32');
fwrite(FID,DataStruct.mapr,'*uint32');
fwrite(FID,DataStruct.maps,'*uint32');

fwrite(FID,DataStruct.dmin,'*single');
fwrite(FID,DataStruct.dmax,'*single');
fwrite(FID,DataStruct.dmean,'*single');

fwrite(FID,DataStruct.ispg,'*single');
fwrite(FID,DataStruct.nsymbt,'*single');

fwrite(FID,DataStruct.extra,'*single');

fwrite(FID,DataStruct.origin,'*single');
fwrite(FID,DataStruct.map,'*single');
fwrite(FID,[68 68 68 68],'*uint8');
fwrite(FID,DataStruct.rms,'*single');
fwrite(FID,DataStruct.nlabel,'*uint32');
fwrite(FID,DataStruct.labels,'*single');

fwrite(FID,DataStruct.image,prec);

fclose(FID);
end