# LuaEnum
## An implementation of enums in Lua

Example:
```lua
local LuaEnum = require("LuaEnum");

local InputType = LuaEnum("InputType", {
    Mouse = {
       "BUTTON1",
       "BUTTON2",
    },
    Keyboard = {
        "A",
        "B",
        "C",
        "D",
        "INS",
        "ESC",
        "SPACE"
    }
});

print(InputType.Mouse.BUTTON1);
print(InputType.Keyboard.SPACE);
print(InputType.Keyboard.NOTREAL);
```
