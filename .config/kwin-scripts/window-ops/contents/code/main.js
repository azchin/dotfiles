const MOVE_OFFSET=100;

registerShortcut('MoveWindowOffsetLeft', 'Move Window Left', 'Meta+Alt+h', function() { moveWindowOffsets(-MOVE_OFFSET, 0); });
registerShortcut('MoveWindowOffsetRight', 'Move Window Right', 'Meta+Alt+l', function() { moveWindowOffsets(MOVE_OFFSET, 0); });
registerShortcut('MoveWindowOffsetUp', 'Move Window Up', 'Meta+Alt+k', function() { moveWindowOffsets(0, -MOVE_OFFSET); });
registerShortcut('MoveWindowOffsetDown', 'Move Window Down', 'Meta+Alt+j', function() { moveWindowOffsets(0, MOVE_OFFSET); });

registerShortcut('RestoreWindowManual', 'Manually Restore Window', 'Meta+j', function() { manualMaximize(false, false); });
registerShortcut('MaximizeWindowManual', 'Manually Maximize Window', 'Meta+k', function() { manualMaximize(true, true); });

function moveWindowOffsets(x, y) {
  let client = workspace.activeClient;
  let maxArea = workspace.clientArea(KWin.MaximizeArea, client);
  if(client.moveable) {
    let newX = client.frameGeometry.x + x;
    let newY = client.frameGeometry.y + y;
    if(newX <= maxArea.width + maxArea.x) {
      client.frameGeometry.x = newX;
    }
    if(newY <= maxArea.height + maxArea.y) {
      client.frameGeometry.y = newY;
    }
  }
}

function manualMaximize(vertically, horizontally) {
  let client = workspace.activeClient;
  if(client.maximizable) {
    client.setMaximize(vertically, horizontally);
  }
}
