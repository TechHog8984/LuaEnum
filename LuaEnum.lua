local LuaEnumItem = {};
local LuaEnum = {};

function LuaEnumItem.new(parent, name, enumitemnames)
    assert(type(parent) == "table" and (getmetatable(parent) == LuaEnum or getmetatable(parent) == LuaEnumItem), "Expected lEnum or lEnumItem for parent, got " .. type(parent));
    assert(type(name) == "string", "Expected type 'string' for name, got " .. type(name));

    local enumitems = {};
    local self = setmetatable({
        parent = parent,
        name = name,
        enumitems = enumitems
    }, LuaEnumItem);

    if type(enumitemnames) == "table" then
        for _, Name in next, enumitemnames do
            enumitems[Name] = LuaEnumItem.new(self, Name);
        end;
    end;

    return self;
end;
function LuaEnumItem.__tostring(self)
    return tostring(self.parent) .. "." .. self.name;
end;
function LuaEnumItem.__index(self, Key)
    if self.enumitems[Key] then
        return self.enumitems[Key];
    end;
    return error(tostring(Key) .. " is not a valid lEnumItem of lEnumItem " .. tostring(self));
end;

function LuaEnum.new(name, enumitemnames)
    assert(type(name) == "string", "Expected type 'string' for name, got " .. type(name));
    assert(type(enumitemnames) == "table", "Expected type 'table' for enumitemnames, got " .. type(enumitemnames));

    local enumitems = {};
    local self = setmetatable({
        name = name,
        enumitems = enumitems
    }, LuaEnum);

    for Key, Value in next, enumitemnames do
        if type(Key) == "number" then
            enumitems[Value] = LuaEnumItem.new(self, Value);
        else
            enumitems[Key] = LuaEnumItem.new(self, Key, Value);
        end;
    end;

    return self;
end;
function LuaEnum.__index(self, Key)
    if self.enumitems[Key] then
        return self.enumitems[Key];
    end;
    return error(tostring(Key) .. " is not a valid lEnumItem of lEnum " .. tostring(self));
end;
function LuaEnum.__tostring(self)
    return self.name;
end;

return setmetatable({new = LuaEnum.new}, {__call = function(_, ...)
    return LuaEnum.new(...);
end});
