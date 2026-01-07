function [ log_absB1_shift, log_absH_shift, CORR1 ] = f_06_Spectrum_Correlation( b, h, opts )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function determines the most likely blur kernel from the evaluated 
    % candidates by calculating the correlation between the logarithmic spectral 
    % amplitude of the candidate and the logarithmic spectral amplitude of 
    % the blurred image.
    
    %%%%  Input  %%%%
    % b : Input blurred image
    % h : Input Estimated candidates
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % log_absB1_shift : Logarithmic spectrum of a blurred image
    % log_absH_shift  : Logarithmic spectrum of estimated candidates
    % CORR1 : Correlation coefficient between blurred image and the estimated candidates

    
    %%    Define Spectrum Size    %%
    
    [ Nx_b, Ny_b, ~     ] = size( b );
    [ Nx_h, Ny_h, Num_h ] = size( h );
    
    Nx_bh = Nx_b + Nx_h - 1;
    Ny_bh = Ny_b + Ny_h - 1;
    
    
    %%    Blurred Image    %%
    
    %%%%  Padding  %%%%
    b1 = wrap_boundary_liu(  b, [ Nx_bh, Ny_bh ]  );

    %%%%  FFT  %%%%
    B1 = fft2( b1 );
    B1_shift = fftshift( B1 );
    
    %%%%  Magnitude  %%%%
    absB1_shift = abs( B1_shift );

    %%%%  Gaussian Smoothing  %%%%
    absB1_shift = f_Gaussian_Smoothing( absB1_shift, opts.Corr_Sigma );
    
    %%%%  Logarithm  %%%%
    log_absB1_shift = log10(  absB1_shift  );
        
    
    %%    Resized Candidates    %%
    
    log_absH_shift = zeros( Nx_bh, Ny_bh, Num_h );
    CORR  = zeros( Num_h, 2 );
    
    for k = 1 : 1 : Num_h

        %%%%  Padding  %%%%
        h1 = padarray( h(:,:,k), [ floor(Nx_b/2), floor(Ny_b/2) ], 'Both' );
        h1 = h1( 1:Nx_bh, 1:Ny_bh );

        %%%%  Center to Upper-left  %%%%
        h1 = ifftshift( h1 );
        
        %%%%  FFT  %%%%
        H1 = fft2( h1 );
        H1_shift = fftshift( H1 );
        
        %%%%  Magnitude  %%%%
        absH1_shift = abs( H1_shift );
        
        %%%%  Gaussian Smoothing  %%%%
        absH1_shift = f_Gaussian_Smoothing( absH1_shift, opts.Corr_Sigma );
        
        %%%%  Logarithm  %%%%
        log_absH1_shift = log10(  absH1_shift  );
        
        
        %%%%  Calculate Correlation  %%%%
        Correlation = corr2(  log_absB1_shift , log_absH1_shift  );
        
        if isnan( Correlation )
            CORR( k,: ) = [ k, 0 ];
        else
            CORR( k,: ) = [ k, Correlation ];
        end
        
        log_absH_shift(:,:,k) = log_absH1_shift;

    end

    
    %%    Rearrange    %%
    
    CORR1 = sortrows( CORR, 2, 'descend' );
   
    
end

