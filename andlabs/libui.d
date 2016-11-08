module andlabs.libui;

import core.stdc.stdint: uintptr_t;
import core.stdc.stdint: uint32_t;
import core.stdc.stdint: intmax_t;
import core.stdc.stdint: uint64_t;

extern (C) nothrow {

	struct uiInitOptions {
		size_t Size;
	}

	const char *uiInit(uiInitOptions *options);
	void uiFreeInitError(const char *error);
	void  uiUninit();

	void uiMain();
	void uiMainSteps();
	void uiMainStep(int wait);
	void uiQuit();

	void uiQueueMain(void function(void *), void *);
	void uiOnShouldQuit(int function(void *), void *);

	void uiFreeText(char *text);

	struct uiControl {
		uint32_t Signature;
		uint32_t OSSignature;
		uint32_t TypeSignature;
		void function(uiControl*) Destroy;
		uintptr_t function(uiControl*) Handle;
		void function(uiControl *, uiControl*) Parent;
		void function(uiControl *, uiControl*) SetParent;
		int  function(uiControl*) TopLevel;
		int  function(uiControl*) Visible;
		void function(uiControl*) Show;
		void function(uiControl*) Hide;
		int  function(uiControl*) Enabled;
		void function(uiControl*) Enable;
		void function(uiControl*) Disable;
	}

	uiControl* uiAllocControl(size_t n, uint32_t, uint32_t, char*);
	void uiControlDestroy(uiControl *);
	uintptr_t uiControlHandle(uiControl *);
	uiControl* uiControlParent(uiControl *);
	void uiControlSetParent(uiControl *, uiControl *);
	int uiControlToplevel(uiControl *);
	int uiControlVisible(uiControl *);
	void uiControlShow(uiControl *);
	void uiControlHide(uiControl *);
	int uiControlEnabled(uiControl *);
	void uiControlEnable(uiControl *);
	void uiControlDisable(uiControl *);
	void uiFreeControl(uiControl *);

	void uiControlVerifySetParent(uiControl *, uiControl *);
	int uiControlEnabledToUser(uiControl *);
	void uiUserBugCannotSetParentOnToplevel(const char *type);

	struct uiWindow;

	uiWindow *uiNewWindow(const char *title, int width, int height, int hasMenubar);
	char *uiWindowTitle(uiWindow *);
	void uiWindowSetTitle(uiWindow *, const char *title);
	void uiWindowContentSize(uiWindow *, int *width, int *height);
	void uiWindowSetContentSize(uiWindow *, int width, int height);
	int uiWindowFullscreen(uiWindow *);
	void uiWindowSetFullscreen(uiWindow *, int fullscreen);
	void uiWindowOnContentSizeChanged(uiWindow *, void function(uiWindow *, void *), void *);
	void uiWindowOnClosing(uiWindow *, int function(uiWindow *, void *), void *);
	int uiWindowBorderless(uiWindow *);
	void uiWindowSetBorderless(uiWindow *, int borderless);
	void uiWindowSetChild(uiWindow *, uiControl *child);
	int uiWindowMargined(uiWindow *);
	void uiWindowSetMargined(uiWindow *w, int margined);

	struct uiButton;

	char *uiButtonText(uiButton *);
	void uiButtonSetText(uiButton *, const char *text);
	void uiButtonOnClicked(uiButton *, void function(uiButton *, void *), void *);
	uiButton *uiNewButton(const char *text);
	
	struct uiBox;

	void uiBoxAppend(uiBox *, uiControl *, int stretchy);
	void uiBoxDelete(uiBox *, int index);
	int uiBoxPadded(uiBox *);
	void uiBoxSetPadded(uiBox *, int padded);
	uiBox *uiNewHorizontalBox();
	uiBox *uiNewVerticalBox();

	struct uiCheckbox;

	char *uiCheckboxText(uiCheckbox *);
	void uiCheckboxSetText(uiCheckbox *, const char *text);
	void uiCheckboxOnToggled(uiCheckbox *, void function(uiCheckbox *, void *), void *);
	int uiCheckboxChecked(uiCheckbox *);
	void uiCheckboxSetChecked(uiCheckbox *, int checked);
	uiCheckbox *uiNewCheckbox(const char *text);

	struct uiEntry;

	char *uiEntryText(uiEntry *);
	void uiEntrySetText(uiEntry *, const char *text);
	void uiEntryOnChanged(uiEntry *, void function(uiEntry *, void *), void *);
	int uiEntryReadOnly(uiEntry *);
	void uiEntrySetReadOnly(uiEntry *, int readonly);
	uiEntry *uiNewEntry();
	uiEntry *uiNewPasswordEntry();
	uiEntry *uiNewSearchEntry();

	struct uiLabel;

	char *uiLabelText(uiLabel *);
	void uiLabelSetText(uiLabel *, const char *text);
	uiLabel *uiNewLabel(const char *text);

	struct uiTab;
	
	void uiTabAppend(uiTab *, const char *name, uiControl *c);
	void uiTabInsertAt(uiTab *, const char *name, int before, uiControl *c);
	void uiTabDelete(uiTab *, int index);
	int uiTabNumPages(uiTab *);
	int uiTabMargined(uiTab *, int page);
	void uiTabSetMargined(uiTab *, int page, int margined);
	uiTab *uiNewTab();

	struct uiGroup;

	char *uiGroupTitle(uiGroup *);
	void uiGroupSetTitle(uiGroup *, const char *title);
	void uiGroupSetChild(uiGroup *, uiControl *c);
	int uiGroupMargined(uiGroup *);
	void uiGroupSetMargined(uiGroup *, int margined);
	uiGroup *uiNewGroup(const char *title);

	struct uiSpinbox;

	int uiSpinboxValue(uiSpinbox *);
	void uiSpinboxSetValue(uiSpinbox *, int value);
	void uiSpinboxOnChanged(uiSpinbox *, void function(uiSpinbox *, void *), void *);
	uiSpinbox *uiNewSpinbox(int min, int max);	

	struct uiSlider;

	int uiSliderValue(uiSlider *);
	void uiSliderSetValue(uiSlider *, int value);
	void uiSliderOnChanged(uiSlider *, void function(uiSlider *, void *), void *);
	uiSlider *uiNewSlider(int min, int max);

	struct uiProgressBar;

	int uiProgressBarValue(uiProgressBar *);
	void uiProgressBarSetValue(uiProgressBar *, int n);
	uiProgressBar *uiNewProgressBar();

	struct uiSeparator;

	uiSeparator *uiNewHorizontalSeparator();
	uiSeparator *uiNewVerticalSeparator();

	struct uiCombobox;

	void uiComboboxAppend(uiCombobox *, const char *text);
	int uiComboboxSelected(uiCombobox *);
	void uiComboboxSetSelected(uiCombobox *, int n);
	void uiComboboxOnSelected(uiCombobox *, void function(uiCombobox *, void *), void *);
	uiCombobox *uiNewCombobox();

	struct uiEditableCombobox;

	void uiEditableComboboxAppend(uiEditableCombobox *, const char *text);
	char *uiEditableComboboxText(uiEditableCombobox *);
	void uiEditableComboboxSetText(uiEditableCombobox *, const char *text);
	void uiEditableComboboxOnChanged(uiEditableCombobox *, void function(uiEditableCombobox *, void *), void *);
	uiEditableCombobox *uiNewEditableCombobox();

	struct uiRadioButtons;

	void uiRadioButtonsAppend(uiRadioButtons *, const char *text);
	int uiRadioButtonsSelected(uiRadioButtons *);
	void uiRadioButtonsSetSelected(uiRadioButtons *, int n);
	void uiRadioButtonsOnSelected(uiRadioButtons *, void function(uiRadioButtons *, void *), void *);
	uiRadioButtons *uiNewRadioButtons();

	struct uiDateTimePicker;

	uiDateTimePicker *uiNewDateTimePicker();
	uiDateTimePicker *uiNewDatePicker();
	uiDateTimePicker *uiNewTimePicker();

	struct uiMultilineEntry;

	char *uiMultilineEntryText(uiMultilineEntry *);
	void uiMultilineEntrySetText(uiMultilineEntry *, const char *text);
	void uiMultilineEntryAppend(uiMultilineEntry *, const char *text);
	void uiMultilineEntryOnChanged(uiMultilineEntry *, void function(uiMultilineEntry *, void *), void *);
	int uiMultilineEntryReadOnly(uiMultilineEntry *);
	void uiMultilineEntrySetReadOnly(uiMultilineEntry *, int readonly);
	uiMultilineEntry *uiNewMultilineEntry();
	uiMultilineEntry *uiNewNonWrappingMultilineEntry();

	struct uiMenuItem;

	void uiMenuItemEnable(uiMenuItem *);
	void uiMenuItemDisable(uiMenuItem *);
	void uiMenuItemOnClicked(uiMenuItem *, void function(uiMenuItem *, uiWindow *, void *), void *);
	int uiMenuItemChecked(uiMenuItem *);
	void uiMenuItemSetChecked(uiMenuItem *, int checked);

	struct uiMenu;

	uiMenuItem *uiMenuAppendItem(uiMenu *, const char *name);
	uiMenuItem *uiMenuAppendCheckItem(uiMenu *, const char *name);
	uiMenuItem *uiMenuAppendQuitItem(uiMenu *);
	uiMenuItem *uiMenuAppendPreferencesItem(uiMenu *);
	uiMenuItem *uiMenuAppendAboutItem(uiMenu *);
	void uiMenuAppendSeparator(uiMenu *);
	uiMenu *uiNewMenu(const char *name);

	struct uiFontButton;

	uiDrawTextFont *uiFontButtonFont(uiFontButton *);
	void uiFontButtonOnChanged(uiFontButton *, void function(uiFontButton *, void *), void *);
	uiFontButton *uiNewFontButton();

	struct uiColorButton;

	void uiColorButtonColor(uiColorButton *, double *r, double *g, double *bl, double *a);
	void uiColorButtonSetColor(uiColorButton *, double r, double g, double bl, double a);
	void uiColorButtonOnChanged(uiColorButton *, void function(uiColorButton *, void *), void *);
	uiColorButton *uiNewColorButton();

	struct uiForm;

	void uiFormAppend(uiForm *, const char *label, uiControl *c, int stretchy);
	void uiFormDelete(uiForm *, int index);
	int uiFormPadded(uiForm *);
	void uiFormSetPadded(uiForm *, int padded);
	uiForm *uiNewForm();

	alias uiAlign = uint;
	enum {
		uiAlignFill,
		uiAlignStart,
		uiAlignCenter,
		uiAlignEnd,
	}

	alias uiAt = uint;
	enum {
		uiAtLeading,
		uiAtTop,
		uiAtTrailing,
		uiAtBottom,
	}

	struct uiGrid;

	void uiGridAppend(uiGrid *, uiControl *, int left, int top, int xspan, int yspan, int hexpand, uiAlign halign, int vexpand, uiAlign valign);
	void uiGridInsertAt(uiGrid *, uiControl *, uiControl *existing, uiAt at, int xspan, int yspan, int hexpand, uiAlign halign, int vexpand, uiAlign valign);
	int uiGridPadded(uiGrid *);
	void uiGridSetPadded(uiGrid *, int padded);
	uiGrid *uiNewGrid();


	char *uiOpenFile(uiWindow *);
	char *uiSaveFile(uiWindow *);
	void uiMsgBox(uiWindow *, const char *title, const char *description);
	void uiMsgBoxError(uiWindow *, const char *title, const char *description);

	struct uiArea;
	
	struct uiAreaHandler {
		void function(uiAreaHandler *, uiArea *, uiAreaDrawParams *)  Draw;
		void function(uiAreaHandler *, uiArea *, uiAreaMouseEvent *)  MouseEvent;
		void function(uiAreaHandler *, int left)                      MouseCrossed;
		void function(uiAreaHandler *, uiArea *)                      DragBroken;
		int function(uiAreaHandler *, uiArea *, uiAreaKeyEvent *)     KeyEvent;
	}
	
	struct uiDrawContext;

	struct uiAreaDrawParams {
		uiDrawContext *Context;
		double AreaWidth;
		double AreaHeight;
		double ClipX;
		double ClipY;
		double ClipWidth;
		double ClipHeight;
	}

	alias uiModifiers = uint;
	enum {
		uiModifierCtrl = 1 << 0,
		uiModifierAlt = 1 << 1,
		uiModifierShift = 1 << 2,
		uiModifierSuper = 1 << 3,
	}

	struct uiAreaMouseEvent {
		double X;
		double Y;

		double AreaWidth;
		double AreaHeight;

		int Down;
		int Up;

		int Count;

		uiModifiers Modifiers;

		uint64_t Held1To64;
	}

	alias uiExtKey = uint;
	enum {
		uiExtKeyEscape = 1,
		uiExtKeyInsert,
		uiExtKeyDelete,
		uiExtKeyHome,
		uiExtKeyEnd,
		uiExtKeyPageUp,
		uiExtKeyPageDown,
		uiExtKeyUp,
		uiExtKeyDown,
		uiExtKeyLeft,
		uiExtKeyRight,
		uiExtKeyF1,
		uiExtKeyF2,
		uiExtKeyF3,
		uiExtKeyF4,
		uiExtKeyF5,
		uiExtKeyF6,
		uiExtKeyF7,
		uiExtKeyF8,
		uiExtKeyF9,
		uiExtKeyF10,
		uiExtKeyF11,
		uiExtKeyF12,
		uiExtKeyN0,
		uiExtKeyN1,
		uiExtKeyN2,
		uiExtKeyN3,
		uiExtKeyN4,
		uiExtKeyN5,
		uiExtKeyN6,
		uiExtKeyN7,
		uiExtKeyN8,
		uiExtKeyN9,
		uiExtKeyNDot,
		uiExtKeyNEnter,
		uiExtKeyNAdd,
		uiExtKeyNSubtract,
		uiExtKeyNMultiply,
		uiExtKeyNDivide,
	}

	struct uiAreaKeyEvent {
		char Key;
		uiExtKey ExtKey;
		uiModifiers Modifier;

		uiModifiers Modifiers;

		int Up;
	}

	alias uiWindowResizeEdge = uint;
	
	enum {
		uiWindowResizeEdgeLeft,
		uiWindowResizeEdgeTop,
		uiWindowResizeEdgeRight,
		uiWindowResizeEdgeBottom,
		uiWindowResizeEdgeTopLeft,
		uiWindowResizeEdgeTopRight,
		uiWindowResizeEdgeBottomLeft,
		uiWindowResizeEdgeBottomRight,
	}

	uiArea* uiNewArea(uiAreaHandler *);
	uiArea* uiNewScrollingArea(uiAreaHandler *, int width, int height);
	void uiAreaQueueRedrawAll(uiArea *);
	void uiAreaScrollTo(uiArea *, double x, double y, double width, double height);
	void uiAreaSetSize(uiArea *, int width, int height);
	void uiAreaBeginUserWindowResize(uiArea *, uiWindowResizeEdge);

	alias uiDrawBrushType = uint;
	enum {
		uiDrawBrushTypeSolid,
		uiDrawBrushTypeLinearGradient,
		uiDrawBrushTypeRadialGradient,
		uiDrawBrushTypeImage,
	}
	alias uiDrawLineCap = uint;
	enum {
		uiDrawLineCapFlat,
		uiDrawLineCapRound,
		uiDrawLineCapSquare,
	}
	alias uiDrawLineJoin = uint;
	enum {
		uiDrawLineJoinMiter,
		uiDrawLineJoinRound,
		uiDrawLineJoinBevel,
	}
	alias uiDrawFillMode = uint;
	enum {
		uiDrawFillModeWinding,
		uiDrawFillModeAlternate,
	}

	immutable double uiDrawDefaultMiterLimit = 10.0;
	immutable double uiPi = 3.14159265358979323846264338327950288419716939937510582097494459;

	struct uiDrawPath;
	struct uiDrawBrush {
		uiDrawBrushType Type;
		double R;
		double G;
		double B;
		double A;
		
		double X0;
		double Y0;
		double X1;
		double Y1;
		double OuterRadius;
		uiDrawBrushGradientStop *Stops;
		size_t numStops;
	}
	struct uiDrawStrokeParams {
		uiDrawLineCap Cap;
		uiDrawLineJoin Join;
		double Thickness;
		double MiterLimit;
		double *Dashes;
		size_t NumDashes;
		double DashPhase;
	}
	struct uiDrawMatrix {
		double M11;
		double M12;
		double M21;
		double M22;
		double M31;
		double M32;
	}
	struct uiDrawBrushGradientStop {
		double Pos;
		double R;
		double G;
		double B;
		double A;
	}

	uiDrawPath *uiDrawNewPath(uiDrawFillMode);
	void uiDrawFreePath(uiDrawPath *);

	void uiDrawPathNewFigure(uiDrawPath *, double x, double y);
	void uiDrawPathNewFigureWithArc(uiDrawPath *, double xCenter, double yCenter, double radius, double startAngle, double sweep, int negative);
	void uiDrawPathLineTo(uiDrawPath *, double x, double y);
	void uiDrawPathArcTo(uiDrawPath *, double xCenter, double yCenter, double radius, double startAngle, double sweep, int negative);
	void uiDrawPathBezierTo(uiDrawPath *, double c1x, double c1y, double c2x, double c2y, double endX, double endY);
	void uiDrawPathCloseFigure(uiDrawPath *);
	void uiDrawPathAddRectangle(uiDrawPath *, double x, double y, double width, double height);
	void uiDrawPathEnd(uiDrawPath *);

	void uiDrawStroke(uiDrawContext *, uiDrawPath *, uiDrawBrush *, uiDrawStrokeParams *);
	void uiDrawFill(uiDrawContext *, uiDrawPath *, uiDrawBrush *);
	void uiDrawTransform(uiDrawContext *, uiDrawMatrix *);
	void uiDrawClip(uiDrawContext *, uiDrawPath *);
	void uiDrawSave(uiDrawContext *);
	void uiDrawRestore(uiDrawContext *);
	void uiDrawText(uiDrawContext *c, double x, double y, uiDrawTextLayout *layout);

	void uiDrawMatrixSetIdentity(uiDrawMatrix *);
	void uiDrawMatrixTranslate(uiDrawMatrix *, double x, double y);
	void uiDrawMatrixScale(uiDrawMatrix *, double xCenter, double yCenter, double x, double y);
	void uiDrawMatrixRotate(uiDrawMatrix *, double x, double y, double amount);
	void uiDrawMatrixSkew(uiDrawMatrix *, double x, double y, double xamount, double yamount);
	void uiDrawMatrixMultiply(uiDrawMatrix *, uiDrawMatrix *);
	int uiDrawMatrixInvertible(uiDrawMatrix *);
	int uiDrawMatrixInvert(uiDrawMatrix *);
	void uiDrawMatrixTransformPoint(uiDrawMatrix *, double *x, double *y);
	void uiDrawMatrixTransformSize(uiDrawMatrix *, double *x, double *y);

	struct uiDrawFontFamilies;

	uiDrawFontFamilies *uiDrawListFontFamilies();
	int uiDrawFontFamiliesNumFamilies(uiDrawFontFamilies *);
	char *uiDrawFontFamiliesFamily(uiDrawFontFamilies *, int n);
	void uiDrawFreeFontFamilies(uiDrawFontFamilies *);
	
	alias uiDrawTextWeight = uint;
	enum {
		uiDrawTextWeightThin,
		uiDrawTextWeightUltraLight,
		uiDrawTextWeightLight,
		uiDrawTextWeightBook,
		uiDrawTextWeightNormal,
		uiDrawTextWeightMedium,
		uiDrawTextWeightSemiBold,
		uiDrawTextWeightBold,
		uiDrawTextWeightUltraBold,
		uiDrawTextWeightHeavy,
		uiDrawTextWeightUltraHeavy,
	}
	
	alias uiDrawTextItalic = uint;
	enum {
		uiDrawTextItalicNormal,
		uiDrawTextItalicOblique,
		uiDrawTextItalicItalic,	
	}

	alias uiDrawTextStretch = uint;
	enum {
		uiDrawTextStretchUltraCondensed,
		uiDrawTextStretchExtraCondensed,
		uiDrawTextStretchCondensed,
		uiDrawTextStretchSemiCondensed,
		uiDrawTextStretchNormal,
		uiDrawTextStretchSemiExpanded,
		uiDrawTextStretchExpanded,
		uiDrawTextStretchExtraExpanded,
		uiDrawTextStretchUltraExpanded,
	}

	struct uiDrawTextFontDescriptor {
		const char *Family;
		double Size;
		uiDrawTextWeight Weight;
		uiDrawTextItalic Italic;
		uiDrawTextStretch Stretch;
	}

	struct uiDrawTextFontMetrics {
		double Ascent;
		double Descent;
		double Leading;
		double UnderlinePos;
		double UnderlineThickness;
	}

	struct uiDrawTextLayout;
	struct uiDrawTextFont;

	uiDrawTextFont *uiDrawLoadClosestFont(const uiDrawTextFontDescriptor *);
	void uiDrawFreeTextFont(uiDrawTextFont *font);
	uintptr_t uiDrawTextFontHandle(uiDrawTextFont *font);
	void uiDrawTextFontDescribe(uiDrawTextFont *font, uiDrawTextFontDescriptor *desc);
	void uiDrawTextFontGetMetrics(uiDrawTextFont *font, uiDrawTextFontMetrics *metrics);
	uiDrawTextLayout *uiDrawNewTextLayout(const char *text, uiDrawTextFont *defaultFont, double width);
	void uiDrawFreeTextLayout(uiDrawTextLayout *layout);
	void uiDrawTextLayoutSetWidth(uiDrawTextLayout *layout, double width);
	void uiDrawTextLayoutExtents(uiDrawTextLayout *layout, double *width, double *height);
	void uiDrawTextLayoutSetColor(uiDrawTextLayout *layout, int startChar, int endChar, double r, double g, double b, double a);
}
