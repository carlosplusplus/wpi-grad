% dlg_example.m

echo on
%inputdlg

prompt={'Enter the matrix size for x^2:','Enter the colormap name:'};
   def={'20','hsv'};
   dlgTitle='Input for Peaks function';
   lineNo=1;
   answer=inputdlg(prompt,dlgTitle,lineNo,def)
   
pause


%errordlg
errordlg('Stop confusing my brain with MATLAB')
pause

%listdlg
d = dir;
str = {d.name};
[s] = listdlg('PromptString','Select a file:',...
                      'SelectionMode','single',...
                      'ListString',str)
pause

%menu
color_choice = MENU('Choose a color','Red','Blue','Green')

pause
%Alternate menu usse
ccc = {'Red','Blue','Green'}
ans = menu( 'Choose a color', ccc );
disp( ['You chose ', ccc{ans}] )
pause

% questdlg
ButtonName=questdlg('What is your wish?', ...
                         'Genie Question', ...
                         'Food','Clothing','Money','Money');
 
   echo off
     switch ButtonName,
        case 'Food', 
         disp('Food is delivered');
       case 'Clothing',
         disp('The Emperor''s  new clothes have arrived.')
       case 'Money',
         disp('A ton of money falls out the sky.');
     end % switch
     echo on
     pause
     
% Waitbar
h = waitbar( 0, 'Please wait...' );
for(i=1:10)
   pause
   waitbar(i/10,h);
end;
pause

disp( 'Now we will kill the wait bar' )
delete(h)

echo off