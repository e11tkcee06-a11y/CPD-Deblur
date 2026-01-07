function [ fxy, fxy_P, fxy_N ] = f_Define_fxy( Img, opts )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to calculate the cross partial derivative of
    % the image.
    
    %%%%  Input  %%%%
    % Img : Input image
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % fxy   : Cross partial derivative of the image
    % fxy_P : Positive value of the cross partial derivative of the image
    % fxy_N : Negative value of the cross partial derivative of the image
    

    %%    Parameter    %%
    
    %%%%  Global  %%%%
    CPD_Sigma = opts.CPD_Sigma;
        
    
    %%    Define fxy    %%
    
    %%%%  Parameter of Gradient  %%%%
    Win = ceil( CPD_Sigma*3 )*2 + 1;
    x = -floor(Win/2) : 1 : floor(Win/2);
    [ AZ, EL ] = meshgrid( x );

    %%%%  (SD) grad2_fxy  %%%%
    grad2_fxy = 1/(2*pi*CPD_Sigma*CPD_Sigma) .* exp( -(AZ.^2/(2*CPD_Sigma^2) + EL.^2/(2*CPD_Sigma^2) ) ) .* (-1*AZ/CPD_Sigma^2) .* (-1*EL/CPD_Sigma^2);

    %%%%  Normalize grad2_fxy(:,:) > 0  %%%%
    grad2_fxy( grad2_fxy(:,:)>0 ) = grad2_fxy( grad2_fxy(:,:)>0 ) / sum(sum(  grad2_fxy( grad2_fxy(:,:)>0 )  ));

    %%%%  Normalize grad2_fxy(:,:) < 0  %%%%
    grad2_fxy( grad2_fxy(:,:)<0 ) = grad2_fxy( grad2_fxy(:,:)<0 ) / sum(sum(  grad2_fxy( grad2_fxy(:,:)<0 )  )) * (-1);


    %%    Calculate fxy    %%
    
    %%%%  fxy  %%%%
    fxy = conv2( Img, grad2_fxy, 'same' );
   
    %%%%  Positive fxy_P  %%%%
    fxy_P = fxy;
    fxy_P(  fxy(:,:) < 0 ) = 0;
    
    %%%%  Negative fxy_N  %%%%
    fxy_N = fxy;
    fxy_N(  fxy(:,:) > 0 ) = 0;
    fxy_N = abs( fxy_N );
 
   
end





