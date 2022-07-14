if (get_window_class() == "Slack") then
    os.execute("xseticon -id " .. get_window_xid() .. " /var/lib/flatpak/exports/share/icons/hicolor/512x512/apps/com.slack.Slack.png")
end
