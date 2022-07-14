if (get_window_name() == "Unnamed Window" or get_window_name() == "Spotify") then
    local output = io.popen("xprop WM_NAME -id " .. get_window_xid())
    if (string.find(output:read("*a"), "Spotify")) then
        os.execute("xseticon -id " .. get_window_xid() .. " /usr/local/share/icons/hicolor/128x128/apps/spotify.png")
        maximize()
    end
    output:close()
end
