function Mask_Out = f_03_Connected_Component_Analysis( Mask, opts )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to do connected component analysis on the input
    % mask to remove unwanted noise within the mask.
    
    %%%%  Input  %%%%
    % Mask : Input mask with unwanted noise
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % Mask_Out : Output mask without noise
    
    
    %%    Parameter    %%
    
    %%%%  Global  %%%%
    CCA_Threshold_1 = max(max(Mask)) * opts.CCA_Scale;
    CCA_ConnectType = opts.CCA_ConnectType;

    
    %%    Calculate    %%
    
    [ Nx_Mask, Ny_Mask ] = size( Mask );
    
    Mask( Mask(:,:) < CCA_Threshold_1 ) = 0;
    
    Mask_1 = double(labelmatrix(  bwconncomp(Mask,CCA_ConnectType)  ));
    
    Index = Mask_1(  ceil((Nx_Mask+1)/2),ceil((Ny_Mask+1)/2)  );
    
    if Index == 0
        Index = mode(  Mask_1(Mask_1(:,:)~=0)  );
    end
    
    Mask_1( Mask_1(:,:)~=Index ) = 0;

    Mask_Out = Mask .* Mask_1 / Index;
        
    
end



