ARCHS = armv7 armv7s arm64

TARGET = iphone:clang::7.0

include theos/makefiles/common.mk

LIBRARY_NAME = Noteification-All
Noteification-All_FILES = NoteificationController.mm
Noteification-All_INSTALL_PATH = /System/Library/WeeAppPlugins/Noteification-All.bundle
Noteification-All_FRAMEWORKS = UIKit CoreGraphics CoreData Foundation
Noteification-All_PRIVATE_FRAMEWORKS = SpringBoardUIServices Notes

include $(THEOS_MAKE_PATH)/library.mk

after-stage::
	mv _/System/Library/WeeAppPlugins/Noteification-All.bundle/Noteification-All.dylib _/System/Library/WeeAppPlugins/Noteification-All.bundle/Noteification-All

after-install::
	install.exec "killall -9 SpringBoard"