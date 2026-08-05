from visidata import TableSheet, vd

vd.options.clipboard_copy_cmd = "pbcopy"

vd.unbindkey('~')
vd.allPrefixes += ['~']

TableSheet.addCommand(None, "cut-cell-or-selection", 'sheet.execCommand("cut-cells") if sheet.nSelectedRows > 0 else sheet.execCommand("cut-cell")')
TableSheet.addCommand(None, "resize-col-wider", "sheet.cursorCol.width = sheet.cursorCol.width + 5")
TableSheet.addCommand(None, "resize-col-narrower", "sheet.cursorCol.width = max(1, sheet.cursorCol.width - 5)")
TableSheet.addCommand(
    None,
    "scroll-halfpage-up",
    "sheet.cursorRowIndex = max(0, sheet.cursorRowIndex - "
    "sheet.nScreenRows // 2); "
    "sheet.topRowIndex = max(0, sheet.cursorRowIndex - "
    "sheet.nScreenRows // 2)",
)
TableSheet.addCommand(
    None,
    "scroll-halfpage-down",
    "sheet.cursorRowIndex = max(0, min(len(sheet.rows) - 1, "
    "sheet.cursorRowIndex + sheet.nScreenRows // 2)); "
    "sheet.topRowIndex = max(0, sheet.cursorRowIndex - "
    "sheet.nScreenRows // 2)",
)

TableSheet.unbindkey("y")
TableSheet.unbindkey("gy")
TableSheet.unbindkey("d")
TableSheet.unbindkey("gx")
TableSheet.unbindkey("$")

TableSheet.bindkey("y", "syscopy-cell")
TableSheet.bindkey("Y", "syscopy-row")
TableSheet.bindkey("d", "cut-cell-or-selection")
TableSheet.bindkey("$", "go-rightmost")
TableSheet.bindkey("0", "go-leftmost")
TableSheet.bindkey("~l", "resize-col-wider")
TableSheet.bindkey("~h", "resize-col-narrower")
TableSheet.bindkey("Ctrl+U", "scroll-halfpage-up")
TableSheet.bindkey("Ctrl+D", "scroll-halfpage-down")
