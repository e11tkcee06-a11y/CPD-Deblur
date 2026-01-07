function b_out = f_Gaussian_Smoothing( b, Sigma )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to smooth the input image.
    
    %%%%  Input  %%%%
    % b : Input image
    % Sigma: Standard deviation of smoothed Gaussian kernel
    
    %%%%  Output  %%%%
    % b_out : Output smoothed image
    
    
    %%    Start the Function    %%

    Win = ceil( Sigma*3 ) * 2 + 1;

    h = fspecial( 'Gaussian', Win, Sigma );
    
    [ Nx_b, Ny_b, ~ ] = size( b );
    [ Nx_h, Ny_h, ~ ] = size( h );
    
    
    %%    Padding    %%
    
    %%%%  Blurred Image  %%%%
    b1 = wrap_boundary_liu(  b, [ Nx_b+Nx_h, Ny_b+Ny_h ]  );

    %%%%  Kernel  %%%%
    h1 = padarray( h, [ floor(Nx_b/2), floor(Ny_b/2) ], 'Both' );
    
    if size(h1,1) ~= size(b1,1)
        h1 = padarray( h1, [ 1, 0 ], 'Post' );
    end
    if size(h1,2) ~= size(b1,2)
        h1 = padarray( h1, [ 0, 1 ], 'Post' );
    end
    
    %%%%  Center to Upper-left  %%%%
    h1 = ifftshift( h1 );
    
    
    %%    FFT    %%
    
    %%%%  Blurred Image  %%%%
    B1 = fft2(b1);
   
    %%%%  Kernel  %%%%
    H1 = fft2(h1);

    %%%%  Convolution of FFT  %%%%
    B2 = H1 .* B1;
    
    %%%%  IFFT  %%%%
    b2 = real(ifft2( B2 ));
    
    b_out = b2(1:Nx_b,1:Ny_b);
    
    
end




