function Harris = f_Harris_Corners( Img )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to calculate the Harris corners of the image.
    
    %%%%  Input  %%%%
    % Img : Input image
    
    %%%%  Output  %%%%
    % Harris : Harris corner point of the image


    %%    Parmeter    %%

    %%%%  Local  %%%%
    FilterSize = 13;
    MinQuality = 0.01;
    
    
    %%    Calculate Harris Corners    %%
    
    Corners = detectHarrisFeatures( Img, 'FilterSize', FilterSize, 'MinQuality', MinQuality );
    Corners = selectStrongest(  Corners, size(Corners,1)  );

    Harris = double( Corners.Location );


end




