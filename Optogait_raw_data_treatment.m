%%extraction des données du fichier XML
%/!\ attention, les adresses sont basées spécifiquement sur les fichiers 
%directement extraits de l'optogait sur le poste dédié à l'acquisition,
%enregistrer des modifications avec une version différente de Excel (ou
%avec une même version, a vérifier) engendre des modifications dans la
%structure et va générer des erreurs
main = parseXML('walk.xml');    %reading of the file, following a tree organization. might take some time to compute
dim_array_row=(size(main(2).Children(6).Children(2).Children,2)-1)/2;  %get the number of rows of the array
dim_array_col_tot=(size(main(2).Children(6).Children(2).Children(2).Children,2)-1)/2;  %get the number of columns
%get the raw values and fill a 'data' array with strings. 
for i=1:dim_array_row
    dim_array_col=(size(main(2).Children(6).Children(2).Children(i*2).Children,2)-1)/2; 
    for j=1:dim_array_col          
        data(i,j)=string(main(2).Children(6).Children(2).Children(i*2).Children(j*2).Children(2).Children.Data); %the 'adress' of the value in the tree        
    end
end 

data=fillmissing(data,'constant',"0"); %fill the <missing> data with strings of 0, to ease the next steps of the algorithm
for i=1:dim_array_row-1 %only get the timestamp, as a numerical value, to facilitate the following incrementation
    only_numerical(i,1)=str2num(data(i+1,4));
end
for i=1:dim_array_row-1 %only get numerical values for the edges detected by the optogait
    for j=1:dim_array_col_tot/2-2
        only_numerical(i,j+1)=str2num(data(i+1,j*2+3));
    end
end