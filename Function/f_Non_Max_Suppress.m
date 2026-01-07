function Record_CPD_Peak = f_Non_Max_Suppress( CPDImg, opts )
    

    %%    Sub-function Description    %%

    %%%%  Summary  %%%%
    % This function is used to find sparse CPD Peaks by proposed
    % non-maximum suppression and sparsity screening.
    
    %%%%  Input  %%%%
    % CPDImg : Cross partial derivative of the image
    % opts: Global Parameters
    
    %%%%  Output  %%%%
    % Record_CPD_Peak : Ouput sparse CPD peaks


    %%    Parameter    %%
    
    %%%%  Global  %%%%
    CutValue = ceil( opts.Kernel_Size_est/2 )+1;
    Sparsity = opts.NMS_Sparsity; 
    
    %%%%  Local  %%%%
    Threshold = 0.01;
    ReduceSize = [ 3, 3 ];
	Radius     = ceil(  (prod(ReduceSize)*2-1)/2  );

    
    %%    Normalize & Filter    %%
    
    CPDImg = CPDImg ./ max(max(CPDImg));
    CPDImg(  CPDImg(:,:) < Threshold  ) = 0;

    
    %%    Non-Maximum Procession    %%
    
    CPDImg1 = CPDImg * 0;
    CPDImg1(  1+CutValue:end-CutValue, 1+CutValue:end-CutValue  ) = CPDImg(  1+CutValue:end-CutValue, 1+CutValue:end-CutValue  );
   
    [ CPDImg1_NonZero(:,1), CPDImg1_NonZero(:,2) ] = find( CPDImg1 > 0 );
    [     ~,    ~         , CPDImg1_NonZero(:,3) ] = find( CPDImg1(CPDImg1(:,:) > 0 ) );
    
    %%%%  N*N Filter  %%%%
    Num_Layer = size( ReduceSize, 2 );
    
    CPDImg2 = CPDImg1;
    for t = 1 : 1 : Num_Layer
        
        Divisor = ReduceSize(1,t);
        CPDImg2 = f_Reduce_Matrix_Size( CPDImg2, Divisor );
               
    end
    
    %%%%  Further Filter  %%%% 
    [ CPDImg2_NonZero(:,1), CPDImg2_NonZero(:,2) ] = find( CPDImg2(:,:) > 0 );
    [     ~,    ~         , CPDImg2_NonZero(:,3) ] = find( CPDImg2(CPDImg2(:,:) > 0) );
    
    [ C, ia, ib ] = intersect( CPDImg1_NonZero(:,3), CPDImg2_NonZero(:,3), 'stable', 'row' );
    
    InterSect_CPDImg1 = CPDImg1_NonZero( ia, : );
    InterSect_CPDImg2 = CPDImg2_NonZero( ib, : );
    
    Record_CPDImg = zeros( 1, 8 );
    
    k = 0;
    for h = 1 : 1 : size(C,1)

        %%%%  Property 3  %%%%
        if CPDImg2(InterSect_CPDImg2(h,1),InterSect_CPDImg2(h,2)) == max(max(  CPDImg2(InterSect_CPDImg2(h,1)-1:InterSect_CPDImg2(h,1)+1,InterSect_CPDImg2(h,2)-1:InterSect_CPDImg2(h,2)+1)  ))
            k = k + 1;
            Record_CPDImg( k, : ) = [ InterSect_CPDImg1(h,:), k, InterSect_CPDImg2(h,:), k ];
            
        %%%%  Property 2  %%%%
        else
            if CPDImg1(InterSect_CPDImg1(h,1),InterSect_CPDImg1(h,2)) == max(max(  CPDImg1(InterSect_CPDImg1(h,1)-Radius:InterSect_CPDImg1(h,1)+Radius,InterSect_CPDImg1(h,2)-Radius:InterSect_CPDImg1(h,2)+Radius)  ))
                k = k + 1;
                Record_CPDImg( k, : ) = [ InterSect_CPDImg1(h,:), k, InterSect_CPDImg2(h,:), k ];
            end
        end
        
    end

    
    %%    Sparse Weighting    %%
    
    %%%%  Define Mask  %%%%
    Mask = ones( 7, 7 );
    Mask( 2:6, 2:6 ) = 25;
    Mask( 3:5, 3:5 ) = 500;
    Mask( 4,4 ) = 0;
    
    %%%%  Use CPDImg2 to Produce Flag and Value  %%%%
    CPDImg2_Sparse_Flag  = CPDImg2 * 0;
    CPDImg2_Sparse_Value = CPDImg2 * 0;
    
    for w = 1 : 1 : size( Record_CPDImg, 1 )
        
        CPDImg2_Sparse_Flag(  Record_CPDImg(w,5), Record_CPDImg(w,6) ) = 1;
        CPDImg2_Sparse_Value( Record_CPDImg(w,5), Record_CPDImg(w,6) ) = Record_CPDImg(w,3);
        
    end
    
    %%%%  Exclude peaks close to the edge of the image.  %%%%
    [ Nx, Ny, ~ ] = size( CPDImg2 );
    [ Idx,~ ] = find( Record_CPDImg(:,5) < 1+3 | Record_CPDImg(:,6) < 1+3 | Record_CPDImg(:,5) > Nx-3 | Record_CPDImg(:,6) > Ny-3 );

    Record_CPDImg( Idx, : ) = [];
    
    %%%%  Sparsity Calculation  %%%%
    for q = 1 : 1 : size( Record_CPDImg, 1 )
        
        for i = -3 : 1 : 3
            for j = -3 : 1 : 3
                
                if CPDImg2_Sparse_Flag( Record_CPDImg(q,5)+i, Record_CPDImg(q,6)+j ) ~= 0
                    
                    if CPDImg2_Sparse_Value( Record_CPDImg(q,5), Record_CPDImg(q,6) ) >= CPDImg2_Sparse_Value( Record_CPDImg(q,5)+i, Record_CPDImg(q,6)+j )
                        CPDImg2_Sparse_Flag( Record_CPDImg(q,5)+i, Record_CPDImg(q,6)+j ) = CPDImg2_Sparse_Flag( Record_CPDImg(q,5)+i, Record_CPDImg(q,6)+j ) + Mask(i+4,j+4);
                    end
                    
                end
                
            end
        end

    end
    
    %%%%  Exclude peaks that the flag number is bigger than the sparsity threshold. %%%%
    CPDImg2_Sparse_Flag( CPDImg2_Sparse_Flag(:,:) > Sparsity ) = 0;
    CPDImg3 = CPDImg2 .* sign(CPDImg2_Sparse_Flag);
    
    [ CPDImg4_NonZero(:,1), CPDImg4_NonZero(:,2) ] = find( CPDImg3(:,:) > 0 );
    [     ~,    ~         , CPDImg4_NonZero(:,3) ] = find( CPDImg3(CPDImg3(:,:) > 0) );
    
    [ C4, ia4, ib4 ] = intersect( CPDImg1_NonZero(:,3), CPDImg4_NonZero(:,3), 'stable', 'row' );
    
    InterSect_CPDImg3 = CPDImg1_NonZero(ia4,:);
    InterSect_CPDImg4 = CPDImg4_NonZero(ib4,:);
    
    Record_CPD_Peak = [ InterSect_CPDImg3, zeros(size(C4)), InterSect_CPDImg4 ];
    Record_CPD_Peak = sortrows( Record_CPD_Peak, 3, 'descend' );
 
    
end



