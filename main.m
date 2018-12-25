function[] = main()
    function writeTo(content)
        filename = 'result.txt';
        dlmwrite(filename, content, '-append', 'delimiter', ' ')
    end

    function content = readFile(file_index, sheet_index)
        fi = num2str(file_index);
        si = num2str(sheet_index);
        X = xlsread([fi '.xlsx'], si, 'B:B');
        Y = xlsread([fi '.xlsx'], si, 'C:C');
        [fitresult] = createFit(X, Y);
        
        y0 = fitresult.y0;
        A1 = fitresult.A1;
        A2 = fitresult.A2;
        t1 = fitresult.t1;
        t2 = fitresult.t2;
        content = {y0, A1, A2, t1, t2}; 
    end

    function analysis(file_count, sheet_count)
        for i = 1:file_count
            for j = 1:sheet_count
                content = readFile(i, j);
                writeTo(content);
            end
        end
    end
    
%   参数一：xlsx文件数量
%   参数二：每个xlsx文件中的sheet数量
%   Notice1：文件和sheet命名，均需要从1开始，类似：1、2、3...
%   Notice2：X默认取第二列数据，Y默认取第三列数据
%   Notice3：需要确认数据趋势满足给定函数（不满足会报错）
%   举例：2个文件，每个文件中10个sheet
    analysis(2, 10)

end