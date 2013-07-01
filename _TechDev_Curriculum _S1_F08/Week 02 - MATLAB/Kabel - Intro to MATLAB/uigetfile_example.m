% uigetfile_example.m
[file, path] = uigetfile( '*.m', 'Pick an M-file' );
fid = fopen( [path,file], 'rt' );
line1 = fgetl(fid);
fclose(fid);

[file,path] = uiputfile( '*.line1', 'Pick an output file name' );
fod = fopen( [path,file], 'wt' );
fprintf( fod, '%s', line1 );
fclose(fod);
