function open_url(url)
    local command = string.format("xdg-open '%s'", url)
    os.execute(command)
end

function open_linkedin()
    open_url("https://linkedin.com")
end
