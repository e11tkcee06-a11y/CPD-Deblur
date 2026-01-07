function Img2 = f_Reduce_Matrix_Size( Img1, Divisor )


    [ Nx1, Ny1 ] = size( Img1 );
    
    N1 = max( Nx1, Ny1 );
    
    Nx1_1 = N1 + (  sign(mod(N1,Divisor)) * Divisor - mod(N1,Divisor)  );
    Ny1_1 = N1 + (  sign(mod(N1,Divisor)) * Divisor - mod(N1,Divisor)  );
    
    Img1_pad = padarray( Img1, [ Nx1_1-Nx1, Ny1_1-Ny1 ], 'Post' );
    Img2     = zeros( Nx1_1/Divisor, Ny1_1/Divisor );

    for i = 1 : 1 : Nx1_1/Divisor
        for j = 1 : 1 : Ny1_1/Divisor
            Img2(i,j) = max(max(  Img1_pad( (i-1)*Divisor+1 : i*Divisor ,(j-1)*Divisor+1:j*Divisor )  ));
        end
    end


end