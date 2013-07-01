function out = gcd_ak( a, b )
if( b==0 )
    out=a;
else
    out = gcd_ak( b, mod(a,b) );
end;
return;
