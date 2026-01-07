function ZeroMask = f_Zero_Finding( H1_shift, opts )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to find the zero points of the blurring kernel.
    
    %%%%  Input  %%%%
    % H1_shift : Frequency domain of the blurring kernel (complex)
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % ZeroMask : Mask of Zero points

    
    %%    Parameter    %%
    
    %%%%  Global  %%%%
    Distance = opts.ZeroFinding_Distance;

    
    %%    Zero Finding    %%
    
    [ Nx, Ny ] = size( H1_shift );

    ZeroMask = zeros( Nx, Ny );
    
    for u = 1+Distance : 1 : Nx-Distance
        for v = 1+Distance : 1 : Ny-Distance
            
            p = real( H1_shift(u+Distance,v) ) * real( H1_shift(u-Distance,v) ) + imag( H1_shift(u+Distance,v) ) * imag( H1_shift(u-Distance,v) );
            q = real( H1_shift(u,v+Distance) ) * real( H1_shift(u,v-Distance) ) + imag( H1_shift(u,v+Distance) ) * imag( H1_shift(u,v-Distance) );
            
            if p < 0 || q < 0
                ZeroMask(u, v) = 1;
            end
            
        end
    end


end



