% string_compare.m
echo on;
s1 = 'string1';
s2 = 'string2';

if( s1==s2 ), disp( 'Strings are equal' ), 
else, disp( 'Strings are not equal' ), end;
pause

if( isequal( s1, s2 ) ), disp( 'Strings are equal' ),
else, disp( 'Strings are not equal' ), end
pause

if( strncmpi( s1, s2, 6 ) ), disp( 'Strings start out equal' ),
else, disp( 'Strings do not start out equal' ), end;
echo off;