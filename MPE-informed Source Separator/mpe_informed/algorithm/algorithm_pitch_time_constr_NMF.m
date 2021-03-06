function [W, H, optinf] = algorithm_pitch_time_constr_NMF(p_stft, used_pitch, H, freq, param)
% OUTPUT:
%
% INPUT:

%% Setting time-frequency constraint 
% (initialize the frequency template matrix, W)
% (initialize the activation matrix, H)
t = size(p_stft, 2);
[W] = template_init(H, used_pitch, freq, t);
%% multiplicative NMF
[W, H, optinf] = nnmf(p_stft, W, H, size(W, 2), param.iteration, param.error_criterion);
end
   