function  PSF_Out = f_04_Adjust_PSF_Center( PSF_In, opts )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to center and normalize all masks after noise 
    % removal, and then merge them into candidates objects. Before centering, 
    % we first eliminate input masks with very large ranges from the input 
    % masks.
    
    %%%%  Input  %%%%
    % PSF_In : Input masks after noise removal
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % PSF_Out : Output cnadidates


    %%    Parameter    %%

    %%%%  Global Parameter  %%%%
    MaskSize = opts.Kernel_Size_est;


    %%    Adjust PSF Center    %%
    
    [ Nx, Ny, Num ] = size( PSF_In );
    
    Reference = ones( Nx, Ny );
    Reference(  1+1:end-1 , 1+1:end-1  ) = 0;
        
    PSF1 = zeros( Nx, Ny, Num );
    PSF_Out = zeros( Nx, Ny, 1 );
    
    k = 0;
    for h = 1 : 1 : Num
        if sum(sum(  PSF_In(:,:,h).*Reference  )) == 0
            
            A = [];
     
            [ A(:,1), A(:,2) ] = find( PSF_In(:,:,h) ~= 0 );

            meanX = ceil(mean( A(:,1) ));
            meanY = ceil(mean( A(:,2) ));

            Delta_X = ceil(MaskSize/2) - meanX;
            Delta_Y = ceil(MaskSize/2) - meanY;
            
            if sum(logical(  A(:,1)+Delta_X > 0 & A(:,1)+Delta_X < Nx  )) - sum(logical(  A(:,2)+Delta_Y > 0 & A(:,2)+Delta_Y < Ny  )) == 0
            
                PSF1( A(:,1)+Delta_X, A(:,2)+Delta_Y, h ) = PSF_In( A(:,1), A(:,2), h );

                k = k + 1;
                PSF_Out(:,:,k) = PSF1(:,:,h) / sum(sum(  PSF1(:,:,h)  ));
            end

        end
    end


end





