using lazy.nvim

```
return {
    "maxzwerin/oldfiles.nvim",
    cmd = "PickOld",
    config = function()
        require("oldfiles").pick_old()
    end,
}
```
