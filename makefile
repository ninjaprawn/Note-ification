THEOS_DEVICE_IP = 192.168.1.130

ARCHS = armv7 armv7s arm64

TARGET = iphone:clang::7.0

include theos/makefiles/common.mk

LIBRARY_NAME = Noteification
Noteification_FILES = NoteificationController.mm
Noteification_INSTALL_PATH = /System/Library/WeeAppPlugins/Noteification.bundle
Noteification_FRAMEWORKS = UIKit CoreGraphics CoreData Foundation
Noteification_PRIVATE_FRAMEWORKS = SpringBoardUIServices Notes

include $(THEOS_MAKE_PATH)/library.mk

after-stage::
	mv _/System/Library/WeeAppPlugins/Noteification.bundle/Noteification.dylib _/System/Library/WeeAppPlugins/Noteification.bundle/Noteification

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += noteification
SUBPROJECTS += noteification-all
include $(THEOS_MAKE_PATH)/aggregate.mk
