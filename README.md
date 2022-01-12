# nvim-treesitter-lua

Lua parser for [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter).

## Installation

Install the plugins with your preferred plugin manager. For example, with
[`vim-plug`](https://github.com/junegunn/vim-plug):

```vim
Plug 'MunifTanjim/nvim-treesitter-lua'
Plug 'nvim-treesitter/nvim-treesitter'
```

And put this in your config file:

```lua
require("nvim-treesitter-lua").setup()
```

After that you can install the parser using this command:

```vim
:TSInstall lua
```

## Tree-sitter Queries

This Lua parser is different than the default one that comes with
[`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter).
So all the plugin that comes with tree-sitter queries for that default
parser won't work with this one.

So, `nvim-treesitter-lua` includes queries for a few plugins in the
[./queries/lua](https://github.com/MunifTanjim/nvim-treesitter-lua/tree/main/queries/lua)
folder:

- [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter).
- [`nvim-treesitter/nvim-treesitter-textobjects`](https://github.com/nvim-treesitter/nvim-treesitter-textobjects).
- [`RRethy/nvim-treesitter-textsubjects`](https://github.com/RRethy/nvim-treesitter-textsubjects).

If you want to contribute queries for other plugins, please open a Pull Request.

It also returns some functions you can use to add/remove queries.

### `treesitter_lua.get_query`

Returns the query content for `name`.

**Signature:** `get_query(name: string) -> string`

| Name   | Type     | Description |
| ------ | -------- | ----------- |
| `name` | `string` | Query name  |

**Examples:**

```lua
local treesitter_lua = require("nvim-treesitter-lua")

treesitter_lua.get_query('injections')
```

### `treesitter_lua.set_query`

Sets (append/prepend/replace) the query content for `name` and returns it.

**Signature:**

- `set_query(filepath: string, mode?: string) -> string`
- `set_query(name: string, content: string, mode?: string) -> string`

| Name       | Type                                               | Description                 |
| ---------- | -------------------------------------------------- | --------------------------- |
| `filepath` | `string`                                           | Absolute path to query file |
| `name`     | `string`                                           | Query name                  |
| `content`  | `string`                                           | Query content               |
| `mode`     | `"append"` _(default)_ / `"prepend"` / `"replace"` | Mode for `set_query`        |

**Examples:**

```lua
local treesitter_lua = require("nvim-treesitter-lua")

-- using filepath
treesitter_lua.set_query("/absolute/path/to/queries/lua/indent.scm", "replace")

-- using name and content
treesitter_lua.set_query("injections", [[
((function_call
  name: (_) @_nvim_exec
  arguments: (arguments (string content: _ @vim)))
  (#match? @_nvim_exec "(^|\.)nvim_exec$"))
]], "append")
```

## License

Licensed under the MIT License. Check the [LICENSE](./LICENSE) file for details.
