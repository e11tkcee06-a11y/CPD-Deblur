function Mask = f_02_Produce_Masks( fxy, Peak, opts )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function determines the size of each mask using the matched CPD peaks as the center.
    
    %%%%  Input  %%%%
    % fxy : Input CPD Image
    % Peak: Matched CPD peaks of the input CPD image
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % Mask : Masks produced by each matched CPD peaks 
    
    
    %%    Parameter    %%
    
    %%%%  Global  %%%%
    MaskSize = opts.Kernel_Size_est;  % Mask's size

    
    %%    Start Algorithm    %%
    
    %%%%  Produce Masks  %%%% 
    Num = size( Peak, 1 );

    Mask = zeros( MaskSize, MaskSize, Num );
    
    switch mod( MaskSize, 2 )
        case 0
            for h = 1 : 1 : Num
                Mask(:,:,h) = fxy(  Peak(h,1) - floor( MaskSize/2 ) : Peak(h,1) + floor( MaskSize/2)-1, ...
                                    Peak(h,2) - floor( MaskSize/2 ) : Peak(h,2) + floor( MaskSize/2)-1 );
            end
            
        case 1
            for h = 1 : 1 : Num
                Mask(:,:,h) = fxy(  Peak(h,1) - floor( MaskSize/2 ) : Peak(h,1) + floor( MaskSize/2), ...
                                    Peak(h,2) - floor( MaskSize/2 ) : Peak(h,2) + floor( MaskSize/2) );
            end
            
    end
    
    
end