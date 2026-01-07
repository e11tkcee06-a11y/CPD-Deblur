function [ Peak2, Harris2 ] = f_Filter_Peaks( Peak, Harris )


    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to get the matched CPD peaks and matched Harris corner points.
    
    %%%%  Input  %%%%
    % Peak   : Total CPD Peaks
    % Harris : Total Harris Corner Point
    
    %%%%  Output  %%%%
    % Peak2   : Matched CPD Peaks
    % Harris2 : Matched Harris Corner Point


    %%    Parameter    %%
    
    %%%%  Local  %%%%
    Radius = 10;

    
    %%    Start the Function    %%
    
    Num_Peak = size( Peak, 1 );

    Peak2   = zeros( 1, 7 );
    Harris2 = zeros( 1, 2 );

    k = 1;
    for i = 1 : 1 : Num_Peak
        
        SearchRange_X1 = Peak(i,2) - Radius;
        SearchRange_X2 = Peak(i,2) + Radius;
        SearchRange_Y1 = Peak(i,1) - Radius;
        SearchRange_Y2 = Peak(i,1) + Radius;
        
        [ Row, ~ ] = find( Harris( :,1 ) >= SearchRange_X1 & ...
                           Harris( :,1 ) <= SearchRange_X2 & ...
                           Harris( :,2 ) >= SearchRange_Y1 & ...
                           Harris( :,2 ) <= SearchRange_Y2 );
                       
        Num_Harris = size( Row, 1 );
        
        if Num_Harris ~= 0
            Harris1 = Harris( Row, : );
            
            Distance = zeros( 1, Num_Harris );
            for j = 1 : 1 : Num_Harris
                Distance( 1, j ) = sqrt(  (Peak(i,2)-Harris1(j,1))^2 + (Peak(i,1)-Harris1(j,2))^2  );
            end
            [ ~, I ] = min( Distance( 1, : ) );
            
            
            Peak2( k, : ) = Peak( i, : );
            Harris2( k,: ) = Harris1( I, : );
            k = k + 1;
        end

    end
    

end