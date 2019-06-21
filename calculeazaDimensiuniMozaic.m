function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine si imaginea de referinta redimensionata avand aceleasi dimensiuni
%ca mozaicul

[H, W, C] = size(params.imgReferinta);
[h, w, c] = size(params.pieseMozaic(:,:,:,1));

%calculeaza automat numarul de piese pe verticala
params.numarPieseMozaicVerticala = round((H*w*params.numarPieseMozaicOrizontala)/(W*h));

%calculeaza si imaginea de referinta redimensionata avand aceleasi dimensiuni ca mozaicul
params.imgReferintaRedimensionata = imresize(params.imgReferinta, [h*params.numarPieseMozaicVerticala, w*params.numarPieseMozaicOrizontala]);