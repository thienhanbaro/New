TARGET := iphone:clang:latest:15.0
INSTALL_TARGET_PROCESSES = ToolBox

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = ToolBox
ToolBox_FILES = main.m ToolBoxAppDelegate.m ToolBoxRootViewController.m
ToolBox_FRAMEWORKS = UIKit CoreGraphics
ToolBox_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/application.mk
