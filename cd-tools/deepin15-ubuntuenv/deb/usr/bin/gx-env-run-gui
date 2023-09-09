#!/usr/bin/env python3
import os
import sys
import PyQt5.QtWidgets as QtWidgets

def RunProgram():
    window.hide()
    if os.system("which gx-env-run"):
        QtWidgets.QMessageBox.critical(window, "错误", "gx-env-run 不存在！")
        return
    if runProgramWithRoot.isChecked():
        if os.getenv("HOME") + "/.config/gx-env/bwrap":
            envDist = os.environ
            envSet = "DISPLAY=$DISPLAY "
            for i in envDist:
                envSet += "{}=${} ".format(i, i)
            os.system("pkexec env " + envSet + " gx-env-run " + programPath.text())
            return
        else:
            os.system("gx-env-run-root " + programPath.text())
            return
    os.system("gx-env-run " + programPath.text())
    sys.exit(0)

app = QtWidgets.QApplication(sys.argv)
window = QtWidgets.QMainWindow()
widget = QtWidgets.QWidget()
layout = QtWidgets.QGridLayout()

programPath = QtWidgets.QLineEdit()
browser = QtWidgets.QPushButton("浏览……")
runProgramWithRoot = QtWidgets.QCheckBox("以 root 权限运行应用")
layout.addWidget(QtWidgets.QLabel("""你可以在兼容模式下运行程序"""), 0, 0, 1, 4)
layout.addWidget(QtWidgets.QLabel("程序路径："), 1, 0)
layout.addWidget(programPath, 1, 1, 1, 3)
#layout.addWidget(browser, 1, 3)

controlLayout = QtWidgets.QHBoxLayout()
cancelButton = QtWidgets.QPushButton("取消")
okButton = QtWidgets.QPushButton("确定")
okButton.clicked.connect(RunProgram)
controlLayout.addWidget(runProgramWithRoot)
controlLayout.addWidget(browser)
controlLayout.addWidget(cancelButton)
controlLayout.addWidget(okButton)
layout.addLayout(controlLayout, 2, 2, 1, 2)

widget.setLayout(layout)
window.setCentralWidget(widget)
window.show()
sys.exit(app.exec_())