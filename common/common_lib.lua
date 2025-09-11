function Lib:Trace(msg)
    print("Call stack: " .. debug.traceback(msg))
end

function Lib:GenerateFileName(name)
    if not name then
        name = "Development";
    end
    local nNeedDate = GetLocalDate("%Y_%m_%d_%H_%M_%S", GetTime())
    local szOutFile = "\\log\\"..name.."_" .. nNeedDate .. ".txt";
    return szOutFile;
end

function Lib:Print(msg)
    local szOutFile = Lib:GenerateFileName()
    KFile.AppendFile(szOutFile, "#####################################################\n");
    local szContent = tostring(msg) .. "\n";
    KFile.AppendFile(szOutFile, szContent);
    KFile.AppendFile(szOutFile, "#####################################################\n");
end

function Lib:PrintTrace(msg)
    local szOutFile = Lib:GenerateFileName()
    KFile.AppendFile(szOutFile, "#####################################################\n");
    local szContent = debug.traceback(tostring(msg)) .. "\n";
    KFile.AppendFile(szOutFile, szContent);
    KFile.AppendFile(szOutFile, "#####################################################\n");
end

function Lib:PrintTable(data, keyword)
    local szOutFile = Lib:GenerateFileName()
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
    local szOutFile = Lib:GenerateFileName()
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
    if (dataType == "table") then
        Lib:PrintTable(data, keyword);
    elseif (dataType == "userdata") then
        Lib:PrintMetatable(data, keyword);
    else
        Lib:Print(data);
    end
end
