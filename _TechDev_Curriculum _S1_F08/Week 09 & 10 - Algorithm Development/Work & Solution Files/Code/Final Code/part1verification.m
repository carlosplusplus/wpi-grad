load part1
load part1clean
load shirt
p1 = data;
load rich
p2 = rich;
%%
figure;
specgram(p1s1)
cmap = colormap;
title({'Spectrogram of Corrupted Signal - p1s1','F_s = 8192 Hz'});
xlabel('Window (n) or Time (s*2*8192)');
ylabel('Normalized Frequency (y/_{F_s/2})')

figure;
specgram(p1s2)
colormap(cmap);
title({'Spectrogram of Corrupted Signal - p1s2','F_s = 8192 Hz'});
xlabel('Window (n) or Time (s*2*8192)');
ylabel('Normalized Frequency (y/_{F_s/2})')

%%
figure;
specgram(p1s1clean)
colormap(cmap);
title({'Spectrogram of Cleaned Signal - p1s1clean','F_s = 8192 Hz'});
xlabel('Window (n) or Time (s*2*8192)');
ylabel('Normalized Frequency (y/_{F_s/2})')

figure;
specgram(p1s2clean)
colormap(cmap);
title({'Spectrogram of Cleaned Signal - p1s2clean','F_s = 8192 Hz'});
xlabel('Window (n) or Time (s*2*8192)');
ylabel('Normalized Frequency (y/_{F_s/2})')