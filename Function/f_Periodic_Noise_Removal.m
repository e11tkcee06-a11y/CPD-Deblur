function G2_shift = f_Periodic_Noise_Removal( H_NP, G1_shift, opts )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to remove periodic noise.
    
    %%%%  Input  %%%%
    % H_NP : Mask of the zero points
    % G1_shift : Frequency domain of the reconstructed image (Complex)
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % G2_shift : Frequency domain of the reconstructed image after periodic noise removal
    
    
    %%    Parameter    %%

    %%%%  Global  %%%%
    Win = opts.Kernel_Size_est;
    
    
    %%    Periodic Noise Removal    %%

    G1 = ifftshift(  G1_shift  );
    g1 = ifft2( G1 );

    N1_shift = H_NP .* G1_shift;

    N1 = ifftshift( N1_shift );
    n1 = ifft2( N1 );

    Kernel = ones( 1, Win ) * 1/Win;

    Term1 = g1 .* n1;
    Term2 = g1;
    Term3 = n1;
    Term4 = n1.^2;

    Term1_1 = conv2( conv2( Term1, Kernel', 'same' ), Kernel, 'same' );
    Term2_1 = conv2( conv2( Term2, Kernel', 'same' ), Kernel, 'same' );
    Term3_1 = conv2( conv2( Term3, Kernel', 'same' ), Kernel, 'same' );
    Term4_1 = conv2( conv2( Term4, Kernel', 'same' ), Kernel, 'same' );

    %%%%  Weighting  %%%%
    w1 = ( Term1_1 - Term2_1 .* Term3_1 ) ./ ( Term4_1 - Term3_1.^2 );

    gg1 = g1 - w1 .* n1;

    %%%%  Normalization  %%%%
    gg1 = gg1 * mean2(g1) / mean2( gg1 );

    G2 = fft2( gg1 );
    G2_shift = fftshift( G2 );
    

end






