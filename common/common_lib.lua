function Lib:Trace(msg)
    print("Call stack: "..debug.traceback(msg))
end

function Lib:Print(msg)
    local nDate = Lib:GetDate2Time(nDate)
    local nNeedDate = tonumber(os.date("%Y%m%d", nDate));
    local szOutFile = "\\log\\Development_" .. nNeedDate .. ".txt";
    KFile.AppendFile(szOutFile, "#####################################################\n");    
    local szContent = tostring(msg).."\n";
    KFile.AppendFile(szOutFile, szContent);
    KFile.AppendFile(szOutFile, "#####################################################\n");
end

function Lib:PrintTrace(msg)
    local nDate = Lib:GetDate2Time(nDate)
    local nNeedDate = tonumber(os.date("%Y%m%d", nDate));
    local szOutFile = "\\log\\Development_" .. nNeedDate .. ".txt";
    KFile.AppendFile(szOutFile, "#####################################################\n");    
    local szContent = debug.traceback(tostring(msg)).."\n";
    KFile.AppendFile(szOutFile, szContent);
    KFile.AppendFile(szOutFile, "#####################################################\n");
end

function Lib:PrintTable(data,keyword)
    local nDate = Lib:GetDate2Time(nDate)
    local nNeedDate = tonumber(os.date("%Y%m%d", nDate));
    local szOutFile = "\\log\\Development_" .. nNeedDate .. ".txt";
    KFile.AppendFile(szOutFile, "#####################################################\n");
    for key, value in pairs(data) do
        if keyword then
            if string.find(key, keyword) then
                local szContent = key .. " : " .. tostring(value) .. "\n";
                KFile.AppendFile(szOutFile, szContent);
            end
        elseif not keyword then
            local szContent = key .. " : " .. tostring(value) .. "\n";
            KFile.AppendFile(szOutFile, szContent);
        end
    end
    KFile.AppendFile(szOutFile, "#####################################################\n");
end

function Lib:PrintMetatable(data, keyword)
    local nDate = Lib:GetDate2Time(nDate)
    local nNeedDate = tonumber(os.date("%Y%m%d", nDate));
    local szOutFile = "\\log\\Development_" .. nNeedDate .. ".txt";
    KFile.AppendFile(szOutFile, "#####################################################\n");
    for key, value in pairs(getmetatable(data)) do
        if keyword then
            if string.find(key, keyword) then
                local szContent = key .. " : " .. tostring(value) .. "\n";
                KFile.AppendFile(szOutFile, szContent);
            end
        elseif not keyword then
            local szContent = key .. " : " .. tostring(value) .. "\n";
            KFile.AppendFile(szOutFile, szContent);
        end
    end
    KFile.AppendFile(szOutFile, "#####################################################\n");
end

function Lib:PrintData(data, keyword)
    if not keyword then
        keyword = "";
    end
    local dataType = type(data);
    if(dataType == "table") then
        Lib:PrintTable(data,keyword);
    elseif (dataType == "userdata") then
        Lib:PrintMetatable(data,keyword);
    elseif (dataType == "string") then
        Lib:Print(data);
    else
        Lib:Print(data);
    end
end
