--[[
    Advanced _G.HTTP Wrapper
    https://wiki.facepunch.com/gmod/Global.HTTP
    https://wiki.facepunch.com/gmod/Structures/HTTPRequest

    NOTE -----!
    HTTP-requests to destinations on private networks (such as 192.168.0.1, or 127.0.0.1) won't work.
    To enable HTTP-requests to destinations on private networks use Command Line Parameters -allowlocalhttp. (Dedicated servers only)
--]]

AddCSLuaFile() -- Add to clients too

local httpex = {}

--- [ Initialzie Body Types ] ---

-- Plain Text
httpex.MIME_PLAINTEXT     = "text/plain; charset=utf-8"

-- HTML
httpex.MIME_HTML          = "text/html; charset=utf-8"

-- JSON
httpex.MIME_JSON          = "application/json"

-- XML
httpex.MIME_XML           = "application/xml"
httpex.MIME_TEXT_XML      = "text/xml"

-- Form Data
httpex.MIME_FORM_URLENC   = "application/x-www-form-urlencoded"
httpex.MIME_FORM_DATA     = "multipart/form-data"

-- JavaScript
httpex.MIME_JS            = "application/javascript"

-- CSS
httpex.MIME_CSS           = "text/css"

-- Images
httpex.MIME_PNG           = "image/png"
httpex.MIME_JPEG          = "image/jpeg"
httpex.MIME_GIF           = "image/gif"
httpex.MIME_WEBP          = "image/webp"
httpex.MIME_SVG           = "image/svg+xml"

-- Audio / Video
httpex.MIME_MP3           = "audio/mpeg"
httpex.MIME_OGG           = "audio/ogg"
httpex.MIME_WAV           = "audio/wav"
httpex.MIME_MP4           = "video/mp4"
httpex.MIME_WEBM          = "video/webm"

-- PDF / Documents
httpex.MIME_PDF           = "application/pdf"
httpex.MIME_ZIP           = "application/zip"
httpex.MIME_OCTET_STREAM  = "application/octet-stream"

-- CSV / Excel
httpex.MIME_CSV           = "text/csv"
httpex.MIME_EXCEL         = "application/vnd.ms-excel"
httpex.MIME_EXCELX        = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

-- Fonts
httpex.MIME_TTF           = "font/ttf"
httpex.MIME_WOFF          = "font/woff"
httpex.MIME_WOFF2         = "font/woff2"
httpex.MIME_OTF           = "font/otf"

-- Manifest
httpex.MIME_MANIFEST      = "application/manifest+json"

-- ICO
httpex.MIME_ICO           = "image/x-icon"

--- [ Main ] ---

local baseHTTP  = HTTP
local isstring  = isstring
local isnumber  = isnumber
local istable   = istable
local assert    = assert

--- [ Maybe params? ] ---
httpex.default_timeout  = 60
httpex.default_headers  = {}
httpex.default_body     = "httpex"

httpex.default_params = {}

local function nilAssert(var, condition, msg)
    if var ~= nil then assert(condition(var), msg) end
end

local function validate_common(url, data)
    assert(isstring(url), "URL must be a string.")

    data = data or {}
    local body      = data.body or httpex.default_body
    local headers   = data.headers or httpex.default_headers
    local bType     = data.type or httpex.MIME_PLAINTEXT -- plain text is by default
    local timeout   = data.timeout or httpex.default_timeout
    local params    = data.parameters or httpex.default_params

    nilAssert(body, isstring, "Body must be a string.")
    nilAssert(headers, istable, "Headers must be a table.")
    nilAssert(bType, isstring, "Type must be a string.")
    nilAssert(timeout, isnumber, "Timeout must be a number.")
    nilAssert(params, istable, "Parameters must be a table.")

    return {
        url     = url,
        body    = body,
        headers = headers,
        type    = bType,
        timeout = timeout,
        success = data.success,
        failed  = data.failed,

        parameters = params
    }
end

local function http_method(method)
    return function(url, data)
        local req = validate_common(url, data)
        req.method = method
        baseHTTP(req)
    end
end

--- [ Register all methods ] ---
httpex.get     = http_method("GET")
httpex.head    = http_method("HEAD")
httpex.post    = http_method("POST")
httpex.put     = http_method("PUT")
httpex.delete  = http_method("DELETE")
httpex.patch   = http_method("PATCH")
httpex.options = http_method("OPTIONS")

return httpex