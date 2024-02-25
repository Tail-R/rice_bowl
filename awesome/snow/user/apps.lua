local A = {}

A.terminal = "urxvt"
A.editor = os.getenv("EDITOR") or "nano"
A.editor_cmd = A.terminal .. " -e " .. A.editor

A.cli_fm = A.terminal .. " -e " .. "ranger"
A.gui_fm = "nemo"

A.music = A.terminal .. " -e ncmpcpp"
-- A.music = [[
--     alacritty -o font.size=10
--     window.dimensions.lines=18
--     window.dimensions.columns=46
--     window.padding.x=32
--     window.padding.y=32
--     --title " "
--     --class ncmpcpp
--     --command ncmpcpp
-- ]]

return A

