function open_url(url)
    local OS = vim.loop.os_uname().sysname
    if OS == "OSX32" or OS == "OSX64" then
        os.execute('open "" "' .. url .. '"')
    else
        os.execute('start "" "' .. url .. '"')
    end
end

function open_linkedin()
    open_url("https://linkedin.com")
end
