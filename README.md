# httpex

A lightweight helper library for Garry's Mod Lua, designed to simplify [_G.HTTP](https://wiki.facepunch.com/gmod/Global.HTTP) requests.

## Features

- Provides default headers, params, body, and timeout
- MIME type constants for common content types
- Supports optional parameters table
- Clean and extendable API

## Example usage

```lua
-- default params can be set like this:
httpex.default_timeout  = 60
httpex.default_headers  = {}
httpex.default_body     = "httpex"

httpex.default_params = {}
```

```lua
local httpex = include("mylibs/httpex.lua")
local body = util.TableToJSON({ hello = "world" }) -- JSON data

-- POST method
httpex.post("https://httpbin.org/post", {
    body = body,
    type = httpex.MIME_JSON,
    success = function(code, body, headers)
        print("Posted! Response:", body)
    end,
    failed = function(err)
        print("Error while posting:", err)
    end
})

-- GET method
httpex.get("https://httpbin.org/get", {
    success = function(code, body, headers)
        print("Get! Response:", body)
    end,
    failed = function(err)
        print("Error while getting:", err)
    end
})

-- PUT method
httpex.put("https://httpbin.org/put", {
    body = body,
    type = httpex.MIME_JSON,
    success = function(code, body, headers)
        print("Put! Response:", body)
    end,
    failed = function(err)
        print("Error while putting:", err)
    end
})

-- PATCH method
httpex.patch("https://httpbin.org/patch", {
    body = body,
    type = httpex.MIME_JSON,
    success = function(code, body, headers)
        print("Patched! Response:", body)
    end,
    failed = function(err)
        print("Error while patching:", err)
    end
})

-- DELETE method
httpex.delete("https://httpbin.org/delete", {
    success = function(code, body, headers)
        print("Deleted! Response:", body)
    end,
    failed = function(err)
        print("Error while deleting:", err)
    end
})

-- HEAD method
httpex.head("https://httpbin.org/get", {
    success = function(code, body, headers)
        print("Headers received:", headers)
    end,
    failed = function(err)
        print("Error while requesting headers:", err)
    end
})
```