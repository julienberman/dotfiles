from visidata import TableSheet, vd

vd.unbindkey('~')
vd.allPrefixes += ['~']

TableSheet.addCommand(
    None,
    "yank-cell-or-selection",
    'sheet.execCommand("syscopy-cells") if sheet.nSelectedRows > 0 '
    'else sheet.execCommand("syscopy-cell")',
)
TableSheet.addCommand(None, "cut-cell-or-selection", 'sheet.execCommand("cut-cells") if sheet.nSelectedRows > 0 else sheet.execCommand("cut-cell")')
TableSheet.addCommand(None, "resize-col-wider", "sheet.cursorCol.width = sheet.cursorCol.width + 5")
TableSheet.addCommand(None, "resize-col-narrower", "sheet.cursorCol.width = max(1, sheet.cursorCol.width - 5)")
TableSheet.addCommand(
    None,
    "scroll-halfpage-up",
    "cursorUp(nScreenRows // 2); "
    "sheet.topRowIndex -= nScreenRows // 2",
)
TableSheet.addCommand(
    None,
    "scroll-halfpage-down",
    "cursorDown(nScreenRows // 2); "
    "sheet.topRowIndex += nScreenRows // 2",
)

TableSheet.unbindkey("y")
TableSheet.unbindkey("gy")
TableSheet.unbindkey("d")
TableSheet.unbindkey("gx")

TableSheet.bindkey("y", "yank-cell-or-selection")
TableSheet.bindkey("d", "cut-cell-or-selection")
TableSheet.bindkey("~l", "resize-col-wider")
TableSheet.bindkey("~h", "resize-col-narrower")
TableSheet.bindkey("Ctrl+U", "scroll-halfpage-up")
TableSheet.bindkey("Ctrl+D", "scroll-halfpage-down")
