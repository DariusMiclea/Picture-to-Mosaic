function imgMozaic = adaugaPieseMozaicPeCaroiaj(params)
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
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala   
                fereastra = params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,:);
                
                cRf=mean(mean(fereastra(:,:,1)));
                cGf=mean(mean(fereastra(:,:,2)));
                cBf=mean(mean(fereastra(:,:,3)));
                for k=1:size(params.pieseMozaic,4)
                    de(k)= sqrt(sum((mediiPiese(k,:)-[cRf cGf cBf]).^2));
                    [val, locatie]= min(de);
                    
                end
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,locatie);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
    
       end
            
    otherwise
        printf('EROARE, optiune necunoscuta \n');
    
end
    
    
    
    
    
