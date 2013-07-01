echo on
% Warning: contains a bug

investments = [1000 10000 512; ...
               1000 0     1024; ...
               1000 0     1024; ...
               1000 0     2048]

 total_assets = sum(investments)
 num_asset_classes = size(investments,1)
 % One way:
 alloc_pct = zeros(size(investments))
 for( irow=1:size(investments,1) )
     alloc_pct(irow,:) = 100*investments(irow,:)./total_assets
 end;
 pause
 
 % Yet another, slightly more readable way:
 % PS: Can you find the bug in this line?
 alloc_pct3 = 100 * investments / repmat( total_assets, num_asset_classes, 1)
 echo off
 