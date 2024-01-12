# Usage

## Lua

Run single file
```bash
lua file.lua 
```

Run lapis server
```bash 
lapis server development
```

## Moonscript

To compile moonscript files use
```bash
moonc .
```
This command should compile files in entire directory. 

Next run

```bash
lapis server development
```


## API Tests

Tests are located in `lua` directory. Start lua-api before running tests.

```bash
cd /lua/tests
```

```bash
lua APITests.lua
```


# Requirements

- Lua >= 5.3.3
- LuaRocks
- Lapis
- Moonscript
- WSL/Ubuntu
- mysql
- OpenResty