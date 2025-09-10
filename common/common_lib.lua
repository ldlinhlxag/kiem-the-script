function Lib:Trace(msg)
    print("Call stack: "..debug.traceback(msg))
end
function Lib:PrintTable(data)
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
