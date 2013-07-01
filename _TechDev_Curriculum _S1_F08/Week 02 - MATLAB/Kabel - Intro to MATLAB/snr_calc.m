snr = sum(noiseless_volts.^2)./sum(noise.^2)
snr_db = 10*log10(snr)