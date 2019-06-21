function imgMozaic = pieseAdiacenteDiferite(params)
%
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);    
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'
        mediiPiese= [];
        for i=1:size(params.pieseMozaic,4)
            piesaCurenta=params.pieseMozaic(:,:,:,i);
            cR= mean(mean(piesaCurenta(:,:,1)));
            cG= mean(mean(piesaCurenta(:,:,2)));
            cB= mean(mean(piesaCurenta(:,:,3)));
            mediiPiese=[mediiPiese;[cR cG cB]];
       end
        
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        
        pieseAdaugate = zeros(h/H, w/W);
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala   
                fereastra = params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,:);
                
                cRf=mean(mean(fereastra(:,:,1)));
                cGf=mean(mean(fereastra(:,:,2)));
                cBf=mean(mean(fereastra(:,:,3)));
                for k=1:size(params.pieseMozaic,4)
                    de(k)= sqrt(sum((mediiPiese(k,:)-[cRf cGf cBf]).^2));
                    [val, locatie]= min(de);
                   % minimePiese(k,:,:) = [k, val, locatie];
                    
                end
                
           
                if  i == 1 && j == 1
                    imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,locatie);
                    pieseAdaugate(i,j) = locatie;
                else
                    [~, locatie2] = sort(de);
                    k = 1;
                    if i == 1
                        while 1
                            if pieseAdaugate(i, j-1) ~= locatie2(k)
                                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,locatie2(k));
                                pieseAdaugate(i,j) = locatie2(k);
                                k = 1;
                                break
                            end
                            k = k+1;
                        end
                    else
                         if j == 1
                             while 1
                                if pieseAdaugate(i-1, j) ~= locatie2(k)
                                    imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,locatie2(k));
                                    pieseAdaugate(i,j) = locatie2(k);
                                    k = 1;
                                    break;
                                end
                                k = k+1;
                             end
                         else
                             while 1
                                if pieseAdaugate(i-1, j) ~= locatie2(k) && pieseAdaugate(i, j-1) ~= locatie2(k)
                                    imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,locatie2(k));
                                    pieseAdaugate(i,j) = locatie2(k);
                                    k = 1;
                                    break;
                                end
                                k = k+1;
                             end
                         end
                    end
                end
                             
                        
                            
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
    
       end
            
    otherwise
        printf('EROARE, optiune necunoscuta \n');
    
end
    
    
    
    
    
