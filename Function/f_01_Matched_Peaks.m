function [ bxy_P, bxy_N, Harris_b, bxy_P_MatchPeak, bxy_P_MatchHarris, bxy_N_MatchPeak, bxy_N_MatchHarris ] = f_01_Matched_Peaks( b, opts )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to calculate the positive and negative CPD
    % images of the input blurred image and find the positive and negative
    % CPD peaks that match the Harris corner points of the input blurred
    % image.
    
    %%%%  Input  %%%%
    % b   : Input Blurred Image
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % bxy_P            : Positive CPD image of the input blurred image
    % bxy_N            : Negative CPD image of the input blurred image
    % Harris_b         : Harris corners of the input blurred image
    % bxy_P_MatchPeak  : Positive CPD peaks that match the Harris corner points of the input blurred image
    % bxy_P_MatchHarris: Harris corner points that match the positive CPD peaks of the input blurred image
    % bxy_N_MatchPeak  : Negative CPD peaks that match the Harris corner points of the input blurred image
    % bxy_N_MatchHarris: Harris corner points that match the negative CPD peaks of the input blurred image
    
    
    %%    Start Algorithm    %%
    
    %%%%  Find Harris corners of blurred image.  %%%%
    Harris_b = f_Harris_Corners( b );
    
    %%%%  Calculate input image's CPD image, positive CPD image and negative CPD image.  %%%%
    [ bxy, bxy_P, bxy_N ] = f_Define_fxy( b, opts );

    %%%%  Find positive CPD peaks.  %%%%
    bxy_P_Peak = f_Non_Max_Suppress( bxy_P, opts );
    [ bxy_P_MatchPeak, bxy_P_MatchHarris ] = f_Filter_Peaks( bxy_P_Peak, Harris_b );
    
    %%%%  Find negative CPD peaks.  %%%%
    bxy_N_Peak = f_Non_Max_Suppress( bxy_N, opts );
    [ bxy_N_MatchPeak, bxy_N_MatchHarris ] = f_Filter_Peaks( bxy_N_Peak, Harris_b );

    
end









