function X = parseText(filePath)
%% This function reads a csv file and returns a matrix with the values
%  The number of %s inside the textscan function should be accordingly to the
%  number of columns the table has
%
    fileID = fopen(filePath);
    C = textscan(fileID,'%s %s %s %s %s %s %s %s %s',...
        'Delimiter',',','EmptyValue',-Inf);
        % ,'TreatAsEmpty',{'NA','na'},
    fclose(fileID);
    
    S = size(C);
    c = S(2);
    for i = 1:c
        Z(:,i) = C{i};
    end
    
    S = size(Z);
    r = S(1); % number of rows in X
    c = S(2); % number of columns in X
    
    for i = 2:r
        for j = 1:c
            s =  sprintf('%s', Z{i,j});
            ch = '-';
            if strcmp(s, '"0"') == 1
                X(i, j) = 0;
            else if strcmp(s, '"1"') == 1
                X(i, j) = 1;
                else if size(s) > 5 & strcmp(s(5), ch(1)) == 1
                        X(i, j) = s;
                    else if size(str2num(s)) > 0
                            num = str2num(s);
                            X(i, j) = num;
                        end
                    end
                end
            end
            
        end
    end
end
