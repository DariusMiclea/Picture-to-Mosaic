%proiect REALIZAREA DE MOZAICURI
%

%%
%seteaza parametri pentru functie

%params = struct('imgReferinta', [], 'numeDirector', [], 'tipImagine', [], 'numarPieseMozaicOrizontala', [], 'afiseazaPieseMozaic',[], 'modAranjare', [], 'criteriu', []);
%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
params.imgReferinta = imread('../data/imaginiTest/ferrari.jpeg');

%seteaza directorul cu imaginile folosite la realizarea mozaicului
%puteti inlocui numele directorului
params.numeDirector = '../data/colectie/';

params.tipImagine = 'png';

%seteaza numarul de piese ale mozaicului pe orizontala
%puteti inlocui aceasta valoare
params.numarPieseMozaicOrizontala = 100;
%numarul de piese ale mozaicului pe verticala va fi dedus automat

%seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din
%director
params.afiseazaPieseMozaic = 0;

%seteaza modul de aranjare a pieselor mozaicului
%optiuni: 'caroiaj','aleator','pieseAdiacenteDiferite'
params.modAranjare = 'pieseAdiacenteDiferite'; 

%am creat functia pieseAdiacenteDiferite pentru punctul c) pentru a putea 
%trece cu usurinta de la un mod de aranjare la altul

%seteaza criteriul dupa care realizeze mozaicul
%optiuni: 'aleator','distantaCuloareMedie'
params.criteriu = 'distantaCuloareMedie';

%%
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);

imwrite(imgMozaic,'mozaic.jpg');
figure, imshow(imgMozaic)