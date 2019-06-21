function imgMozaic = adaugaPieseMozaicModAleator(params)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

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
for i =1:params.numarPieseMozaicVerticala*2
     for j=1:params.numarPieseMozaicOrizontala*2
         %alege un indice aleator din cele N
          indiceI = randi(h-H-1);
          indiceJ = randi(w-W-1);
          fereastra = params.imgReferintaRedimensionata(indiceI:indiceI+H-1,indiceJ:indiceJ+W-1,:);
          fprintf(string((indiceI-1)*H+1));
          cRf=mean(mean(fereastra(:,:,1)));
          cGf=mean(mean(fereastra(:,:,2)));
          cBf=mean(mean(fereastra(:,:,3)));
          for k=1:size(params.pieseMozaic,4)
              de(k)= sqrt(sum((mediiPiese(k,:)-[cRf cGf cBf]).^2));
              [val, locatie]= min(de);
           end
           imgMozaic(indiceI:indiceI+H-1,indiceJ:indiceJ+W-1,:) = params.pieseMozaic(:,:,:,locatie);
           nrPieseAdaugate = nrPieseAdaugate+1;
           fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese/4);
      end
    
end
            

end