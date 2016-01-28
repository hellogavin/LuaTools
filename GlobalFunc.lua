GlobalFunc = {}

--将table输出为string打印
function GlobalFunc.sz_T2S(_t)
    local szRet = "{"
    function doT2S(_i, _v)
        if "number" == type(_i) then
            szRet = szRet .. "[" .. _i .. "] = "
            if "number" == type(_v) then
                szRet = szRet .. _v .. ","
            elseif "string" == type(_v) then
                szRet = szRet .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                szRet = szRet .. sz_T2S(_v) .. ","
            else
                szRet = szRet .. "nil,"
            end
        elseif "string" == type(_i) then
            szRet = szRet .. '["' .. _i .. '"] = '
            if "number" == type(_v) then
                szRet = szRet .. _v .. ","
            elseif "string" == type(_v) then
                szRet = szRet .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                szRet = szRet .. sz_T2S(_v) .. ","
            else
                szRet = szRet .. "nil,"
            end
        end
    end
    table.foreach(_t, doT2S)
    szRet = szRet .. "}"
    return szRet
end

function GlobalFunc.print(cls,...)
    GlobalFunc.printTag("default",cls,...)
end

_tagTable = {"default","error"}

function GlobalFunc.printTag(tag,cls,...)
    device.environment == "device" then
       return nil 
    end
    if DEBUG AND DEBUG ~=1 then return end
    local tagName = tag
    if type(tagName) ~= "string" then
        tagName = "default"
    end
    local validTag = false
    for i, value in _tagTable do
        if value == tagName then
            validTag = true
            break
        end
    end
    if validTag == false then return end
    echo("[" .. tagName .. "]" .. string.format(tostring(cls), ...))
end

return GlobalFunc
