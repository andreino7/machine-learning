function X = parseText(filePath)
%% This function reads a csv file and returns a matrix with the values
%  The number of %s inside the textscan function should be accordingly to the
%  number of columns the table has
%
    fileID = fopen(filePath);
    C = textscan(fileID,'%s %s %s %s %s %s %s %s',...
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
    
    % Converting data
    for i = 1:r
        for j = 1:c
            s =  sprintf('%s', Z{i,j});
            n = size(s);
            ch = '-';
            if strcmp(s, '"0"') == 1
                X(i, j) = 0.0;
            else if strcmp(s, '"1"') == 1
                X(i, j) = 1.0;
                else if n(2) == 10 % date
                        num0 = str2double(s(1:4));
                        num1 = str2double(s(6:7));
                        num2 = str2double(s(9:10));
                        X(i, j) = 365*num0 + 30*num1 + num2;
                    else if size(str2double(s)) > 0 % check empty column
                            num = str2double(s);
                            X(i, j) = num;
                        end
                    end
                end
            end
        end
    end
end
