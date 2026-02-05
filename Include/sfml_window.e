--EuSFML Window 3
--Written by Andy P.
--Copyright (c) 2026
include std/ffi.e
include std/machine.e
include std/os.e

public atom win

ifdef WINDOWS then
	win = open_dll("csfml-window-3.dll")
	elsifdef LINUX or FREEBSD then
	win = open_dll("libcsfml-window-3.so")
	elsifdef OSX then
	win = open_dll("libcsfml-window-3.dylib")
end ifdef

if win = -1 then
	puts(1,"Failed to load csfml-window-3!\n")
	abort(0)
end if

include sfml_system.e

--Videomode

public constant sfVideoMode = define_c_struct({
	sfVector2u, --size
	C_UINT --bitsPerPixel
})

public constant xsfVideoMode_getDesktopMode = define_c_func(win,"+sfVideoMode_getDesktopMode",{},sfVideoMode)

public function sfVideoMode_getDesktopMode()
	return c_func(xsfVideoMode_getDesktopMode,{})
end function

public constant xsfVideoMode_getFullscreenModes = define_c_func(win,"+sfVideoMode_getFullscreenModes",{C_POINTER},C_POINTER)

public function sfVideoMode_getFullscreenModes(atom count)
	return c_func(xsfVideoMode_getFullscreenModes,{count})
end function

public constant xsfVideoMode_isValid = define_c_func(win,"+sfVideoMode_isValid",{sfVideoMode},C_BOOL)

public function sfVideoMode_isValid(sequence mode)
	return c_func(xsfVideoMode_isValid,{mode})
end function

--Clipboard

public constant xsfClipboard_getString = define_c_func(win,"+sfClipboard_getString",{},C_STRING)

public function sfClipboard_getString()
	return c_func(xsfClipboard_getString,{})
end function

public constant xsfClipboard_getUnicodeString = define_c_func(win,"+sfClipboard_getUnicodeString",{},C_POINTER)

public function sfClipboard_getUnicodeString()
	return c_func(xsfClipboard_getUnicodeString,{})
end function

public constant xsfClipboard_setString = define_c_proc(win,"+sfClipboard_setString",{C_STRING})

public procedure sfClipboard_setString(sequence text)
	c_proc(xsfClipboard_setString,{text})
end procedure

public constant xsfClipboard_setUnicodeString = define_c_proc(win,"+sfClipboard_setUnicodeString",{C_POINTER})

public procedure sfClipboard_setUnicodeString(sequence text)
	atom str = allocate_string(text,1)
	c_proc(xsfClipboard_setUnicodeString,{str})
end procedure

--Keyboard

public enum type sfKeyCode
	sfKeyUnknown = -1, --///< Unhandled key
    sfKeyA = 0,         --   ///< The A key
    sfKeyB,           -- ///< The B key
    sfKeyC,           -- ///< The C key
    sfKeyD,           -- ///< The D key
    sfKeyE,           -- ///< The E key
    sfKeyF,           -- ///< The F key
    sfKeyG,           -- ///< The G key
    sfKeyH,           -- ///< The H key
    sfKeyI,           -- ///< The I key
    sfKeyJ,           -- ///< The J key
    sfKeyK,           -- ///< The K key
    sfKeyL,           -- ///< The L key
    sfKeyM,           -- ///< The M key
    sfKeyN,            --///< The N key
    sfKeyO,            --///< The O key
    sfKeyP,            --///< The P key
    sfKeyQ,            --///< The Q key
    sfKeyR,            --///< The R key
    sfKeyS,           -- ///< The S key
    sfKeyT,           -- ///< The T key
    sfKeyU,           --- ///< The U key
    sfKeyV,            --///< The V key
    sfKeyW,            --///< The W key
    sfKeyX,           -- ///< The X key
    sfKeyY,            --///< The Y key
    sfKeyZ,            --///< The Z key
    sfKeyNum0,         --///< The 0 key
    sfKeyNum1,         --///< The 1 key
    sfKeyNum2,         --///< The 2 key
    sfKeyNum3,         --///< The 3 key
    sfKeyNum4,         --///< The 4 key
    sfKeyNum5,         --///< The 5 key
    sfKeyNum6,         --///< The 6 key
    sfKeyNum7,         --///< The 7 key
    sfKeyNum8,         --///< The 8 key
    sfKeyNum9,         --///< The 9 key
    sfKeyEscape,       --///< The Escape key
    sfKeyLControl,     --///< The left Control key
    sfKeyLShift,       --///< The left Shift key
    sfKeyLAlt,         --///< The left Alt key
    sfKeyLSystem,      --///< The left OS specific key: window (Windows and Linux), apple (macOS), ...
    sfKeyRControl,     --///< The right Control key
    sfKeyRShift,       --///< The right Shift key
    sfKeyRAlt,         --///< The right Alt key
    sfKeyRSystem,      --///< The right OS specific key: window (Windows and Linux), apple (macOS), ...
    sfKeyMenu,         --///< The Menu key
    sfKeyLBracket,     --///< The [ key
    sfKeyRBracket,    -- ///< The ] key
    sfKeySemicolon,   -- ///< The ; key
    sfKeyComma,        --///< The , key
    sfKeyPeriod,       --///< The . key
    sfKeyApostrophe,   --///< The ' key
    sfKeySlash,        --///< The / key
    sfKeyBackslash,    --///< The \ key
    sfKeyGrave,        --///< The ` key
    sfKeyEqual,        --///< The = key
    sfKeyHyphen,       --///< The - key (hyphen)
    sfKeySpace,        --///< The Space key
    sfKeyEnter,        --///< The Enter/Return key
    sfKeyBackspace,    --///< The Backspace key
    sfKeyTab,          --///< The Tabulation key
    sfKeyPageUp,       --///< The Page up key
    sfKeyPageDown,     --///< The Page down key
    sfKeyEnd,          --///< The End key
    sfKeyHome,         --///< The Home key
    sfKeyInsert,       --///< The Insert key
    sfKeyDelete,       --///< The Delete key
    sfKeyAdd,          --///< The + key
    sfKeySubtract,     --///< The - key (minus, usually from numpad)
    sfKeyMultiply,     --///< The * key
    sfKeyDivide,       --///< The / key
    sfKeyLeft,         --///< Left arrow
    sfKeyRight,        --///< Right arrow
    sfKeyUp,           --///< Up arrow
    sfKeyDown,         --///< Down arrow
    sfKeyNumpad0,      --///< The numpad 0 key
    sfKeyNumpad1,      --///< The numpad 1 key
    sfKeyNumpad2,      --///< The numpad 2 key
    sfKeyNumpad3,      --///< The numpad 3 key
    sfKeyNumpad4,      --///< The numpad 4 key
    sfKeyNumpad5,      --///< The numpad 5 key
    sfKeyNumpad6,      --///< The numpad 6 key
    sfKeyNumpad7,      --///< The numpad 7 key
    sfKeyNumpad8,      --///< The numpad 8 key
    sfKeyNumpad9,      --///< The numpad 9 key
    sfKeyF1,           --///< The F1 key
    sfKeyF2,           --///< The F2 key
    sfKeyF3,           --///< The F3 key
    sfKeyF4,           --///< The F4 key
    sfKeyF5,           --///< The F5 key
    sfKeyF6,           --///< The F6 key
    sfKeyF7,           --///< The F7 key
    sfKeyF8,           --///< The F8 key
    sfKeyF9,           --///< The F8 key
    sfKeyF10,          --///< The F10 key
    sfKeyF11,          --///< The F11 key
    sfKeyF12,          --///< The F12 key
    sfKeyF13,          --///< The F13 key
    sfKeyF14,          --///< The F14 key
    sfKeyF15,          --///< The F15 key
    sfKeyPause        --///< The Pause key
end type

public constant sfKeyCount = sfKeyPause + 1

public enum type sfScancode
	 sfScanUnknown = -1,-- //!< Represents any scancode not present in this enum
    sfScanA       = 0,  --//!< Keyboard a and A key
    sfScanB,            --//!< Keyboard b and B key
    sfScanC,            --//!< Keyboard c and C key
    sfScanD,           -- //!< Keyboard d and D key
    sfScanE,           -- //!< Keyboard e and E key
    sfScanF,           -- //!< Keyboard f and F key
    sfScanG,           -- //!< Keyboard g and G key
    sfScanH,           -- //!< Keyboard h and H key
    sfScanI,           -- //!< Keyboard i and I key
    sfScanJ,           -- //!< Keyboard j and J key
    sfScanK,           -- //!< Keyboard k and K key
    sfScanL,           -- //!< Keyboard l and L key
    sfScanM,           -- //!< Keyboard m and M key
    sfScanN,           -- //!< Keyboard n and N key
    sfScanO,           -- //!< Keyboard o and O key
    sfScanP,           -- //!< Keyboard p and P key
    sfScanQ,            --//!< Keyboard q and Q key
    sfScanR,            --//!< Keyboard r and R key
    sfScanS,            --//!< Keyboard s and S key
    sfScanT,            --//!< Keyboard t and T key
    sfScanU,            --//!< Keyboard u and U key
    sfScanV,            --//!< Keyboard v and V key
    sfScanW,            --//!< Keyboard w and W key
    sfScanX,            --//!< Keyboard x and X key
    sfScanY,            --//!< Keyboard y and Y key
    sfScanZ,            --//!< Keyboard z and Z key
    sfScanNum1,         --//!< Keyboard 1 and ! key
    sfScanNum2,         --//!< Keyboard 2 and @ key
    sfScanNum3,         --//!< Keyboard 3 and # key
    sfScanNum4,         --//!< Keyboard 4 and $ key
    sfScanNum5,         --//!< Keyboard 5 and % key
    sfScanNum6,         --//!< Keyboard 6 and ^ key
    sfScanNum7,         --//!< Keyboard 7 and & key
    sfScanNum8,         --//!< Keyboard 8 and * key
    sfScanNum9,         --//!< Keyboard 9 and ) key
    sfScanNum0,         --//!< Keyboard 0 and ) key
    sfScanEnter,        --//!< Keyboard Enter/Return key
    sfScanEscape,       --//!< Keyboard Escape key
    sfScanBackspace,    --//!< Keyboard Backspace key
    sfScanTab,          --//!< Keyboard Tab key
    sfScanSpace,        --//!< Keyboard Space key
    sfScanHyphen,       --//!< Keyboard - and _ key
    sfScanEqual,        --//!< Keyboard = and +
    sfScanLBracket,     --//!< Keyboard [ and { key
    sfScanRBracket,     --//!< Keyboard ] and } key
    --// For US keyboards mapped to key 29 (Microsoft Keyboard Scan Code Specification)
    --// For Non-US keyboards mapped to key 42 (Microsoft Keyboard Scan Code Specification)
    --// Typical language mappings: Belg:£µ` FrCa:<>} Dan:*' Dutch:`´ Fren:µ* Ger:'# Ital:§ù LatAm:[}` Nor:*@ Span:ç} Swed:*' Swiss:$£} UK:~# Brazil:}]
    sfScanBackslash,     -- //!< Keyboard \ and | key OR various keys for Non-US keyboards
    sfScanSemicolon,      --//!< Keyboard ; and : key
    sfScanApostrophe,     --//!< Keyboard ' and " key
    sfScanGrave,          --//!< Keyboard ` and ~ key
    sfScanComma,          --//!< Keyboard , and < key
    sfScanPeriod,         --//!< Keyboard . and > key
    sfScanSlash,          --//!< Keyboard / and ? key
    sfScanF1,             --//!< Keyboard F1 key
    sfScanF2,             --//!< Keyboard F2 key
    sfScanF3,             --//!< Keyboard F3 key
    sfScanF4,             --//!< Keyboard F4 key
    sfScanF5,             --//!< Keyboard F5 key
    sfScanF6,             --//!< Keyboard F6 key
    sfScanF7,             --//!< Keyboard F7 key
    sfScanF8,             --//!< Keyboard F8 key
    sfScanF9,             --//!< Keyboard F9 key
    sfScanF10,            --//!< Keyboard F10 key
    sfScanF11,            --//!< Keyboard F11 key
    sfScanF12,            --//!< Keyboard F12 key
    sfScanF13,            --//!< Keyboard F13 key
    sfScanF14,            --//!< Keyboard F14 key
    sfScanF15,            --//!< Keyboard F15 key
    sfScanF16,            --//!< Keyboard F16 key
    sfScanF17,            --//!< Keyboard F17 key
    sfScanF18,            --//!< Keyboard F18 key
    sfScanF19,            --//!< Keyboard F19 key
    sfScanF20,            --//!< Keyboard F20 key
    sfScanF21,            --//!< Keyboard F21 key
    sfScanF22,            --//!< Keyboard F22 key
    sfScanF23,            --//!< Keyboard F23 key
    sfScanF24,            --//!< Keyboard F24 key
    sfScanCapsLock,       --//!< Keyboard Caps %Lock key
    sfScanPrintScreen,    --//!< Keyboard Print Screen key
    sfScanScrollLock,     --//!< Keyboard Scroll %Lock key
    sfScanPause,          --//!< Keyboard Pause key
    sfScanInsert,         --//!< Keyboard Insert key
    sfScanHome,           --//!< Keyboard Home key
    sfScanPageUp,         --//!< Keyboard Page Up key
    sfScanDelete,         --//!< Keyboard Delete Forward key
    sfScanEnd,            --//!< Keyboard End key
    sfScanPageDown,       --//!< Keyboard Page Down key
    sfScanRight,          --//!< Keyboard Right Arrow key
    sfScanLeft,           --//!< Keyboard Left Arrow key
    sfScanDown,           --//!< Keyboard Down Arrow key
    sfScanUp,             --//!< Keyboard Up Arrow key
    sfScanNumLock,        --//!< Keypad Num %Lock and Clear key
    sfScanNumpadDivide,   --//!< Keypad / key
    sfScanNumpadMultiply, --//!< Keypad * key
    sfScanNumpadMinus,    --//!< Keypad - key
    sfScanNumpadPlus,     --//!< Keypad + key
    sfScanNumpadEqual,    --//!< keypad = key
    sfScanNumpadEnter,    --//!< Keypad Enter/Return key
    sfScanNumpadDecimal,  --//!< Keypad . and Delete key
    sfScanNumpad1,        --//!< Keypad 1 and End key
    sfScanNumpad2,        --//!< Keypad 2 and Down Arrow key
    sfScanNumpad3,        --//!< Keypad 3 and Page Down key
    sfScanNumpad4,        --//!< Keypad 4 and Left Arrow key
    sfScanNumpad5,        --//!< Keypad 5 key
    sfScanNumpad6,        --//!< Keypad 6 and Right Arrow key
    sfScanNumpad7,        --//!< Keypad 7 and Home key
    sfScanNumpad8,        --//!< Keypad 8 and Up Arrow key
    sfScanNumpad9,        --//!< Keypad 9 and Page Up key
    sfScanNumpad0,        --//!< Keypad 0 and Insert key
   -- // For US keyboards doesn't exist
    --// For Non-US keyboards mapped to key 45 (Microsoft Keyboard Scan Code Specification)
    --// Typical language mappings: Belg:<\> FrCa:«°» Dan:<\> Dutch:]|[ Fren:<> Ger:<|> Ital:<> LatAm:<> Nor:<> Span:<> Swed:<|> Swiss:<\> UK:\| Brazil: \|.
    sfScanNonUsBackslash,    -- //!< Keyboard Non-US \ and | key
    sfScanApplication,       -- //!< Keyboard Application key
    sfScanExecute,           -- //!< Keyboard Execute key
    sfScanModeChange,        -- //!< Keyboard Mode Change key
    sfScanHelp,              -- //!< Keyboard Help key
    sfScanMenu,              -- //!< Keyboard Menu key
    sfScanSelect,             --//!< Keyboard Select key
    sfScanRedo,               --//!< Keyboard Redo key
    sfScanUndo,               --//!< Keyboard Undo key
    sfScanCut,                --//!< Keyboard Cut key
    sfScanCopy,               --//!< Keyboard Copy key
    sfScanPaste,              --//!< Keyboard Paste key
    sfScanVolumeMute,         --//!< Keyboard Volume Mute key
    sfScanVolumeUp,           --//!< Keyboard Volume Up key
    sfScanVolumeDown,         --//!< Keyboard Volume Down key
    sfScanMediaPlayPause,     --//!< Keyboard Media Play Pause key
    sfScanMediaStop,          --//!< Keyboard Media Stop key
    sfScanMediaNextTrack,     --//!< Keyboard Media Next Track key
    sfScanMediaPreviousTrack, --//!< Keyboard Media Previous Track key
    sfScanLControl,           --//!< Keyboard Left Control key
    sfScanLShift,             --//!< Keyboard Left Shift key
    sfScanLAlt,              -- //!< Keyboard Left Alt key
    sfScanLSystem,            --//!< Keyboard Left System key
    sfScanRControl,           --//!< Keyboard Right Control key
    sfScanRShift,             --//!< Keyboard Right Shift key
    sfScanRAlt,               --//!< Keyboard Right Alt key
    sfScanRSystem,            --//!< Keyboard Right System key
    sfScanBack,               --//!< Keyboard Back key
    sfScanForward,            --//!< Keyboard Forward key
    sfScanRefresh,            --//!< Keyboard Refresh key
    sfScanStop,               --//!< Keyboard Stop key
    sfScanSearch,             --//!< Keyboard Search key
    sfScanFavorites,          --//!< Keyboard Favorites key
    sfScanHomePage,           --//!< Keyboard Home Page key
    sfScanLaunchApplication1, --//!< Keyboard Launch Application 1 key
    sfScanLaunchApplication2, --//!< Keyboard Launch Application 2 key
    sfScanLaunchMail,         --//!< Keyboard Launch Mail key
    sfScanLaunchMediaSelect  --//!< Keyboard Launch Media Select key
end type

public constant sfScancodeCount = sfScanLaunchMediaSelect + 1

public constant xsfKeyboard_isKeyPressed = define_c_func(win,"+sfKeyboard_isKeyPressed",{C_INT},C_BOOL)

public function sfKeyboard_isKeyPressed(sfKeyCode key)
	return c_func(xsfKeyboard_isKeyPressed,{key})
end function

public constant xsfKeyboard_isScancodePressed = define_c_func(win,"+sfKeyboard_isScancodePressed",{C_INT},C_BOOL)

public function sfKeyboard_isScancodePressed(sfScancode code)
	return c_func(xsfKeyboard_isScancodePressed,{code})
end function

public constant xsfKeyboard_localize = define_c_func(win,"+sfKeyboard_localize",{C_INT},C_INT)

public function sfKeyboard_localize(sfScancode code)
	return c_func(xsfKeyboard_localize,{code})
end function

public constant xsfKeyboard_delocalize = define_c_func(win,"+sfKeyboard_delocalize",{C_INT},C_INT)

public function sfKeyboard_delocalize(sfKeyCode key)
	return c_func(xsfKeyboard_delocalize,{key})
end function

public constant xsfKeyboard_getDescription = define_c_func(win,"+sfKeyboard_getDescription",{C_INT},C_STRING)

public function sfKeyboard_getDescription(sfScancode code)
	return c_func(xsfKeyboard_getDescription,{code})
end function

public constant xsfKeyboard_setVirtualKeyboardVisible = define_c_proc(win,"+sfKeyboard_setVirtualKeyboardVisible",{C_BOOL})

public procedure sfKeyboard_setVirtualKeyboardVisible(atom visible)
	c_proc(xsfKeyboard_setVirtualKeyboardVisible,{visible})
end procedure

--JoystickIdentification

public constant sfJoystickIdentification = define_c_struct({
	C_STRING, --name
	C_UINT, --vendorId
	C_UINT  --productId
})

--Joystick

public enum sfJoystickCount = 8,
		    sfJoystickButtonCount = 32,
		    sfJoystickAxisCount = 8
		    
public enum type sfJoystickAxis
	sfJoystickX = 0,  --  ///< The X axis
    sfJoystickY,   -- ///< The Y axis
    sfJoystickZ,   -- ///< The Z axis
    sfJoystickR,   -- ///< The R axis
    sfJoystickU,   -- ///< The U axis
    sfJoystickV,   -- ///< The V axis
    sfJoystickPovX, --///< The X axis of the point-of-view hat
    sfJoystickPovY  --///< The Y axis of the point-of-view hat
end type

public constant xsfJoystick_isConnected = define_c_func(win,"+sfJoystick_isConnected",{C_UINT},C_BOOL)

public function sfJoystick_isConnected(atom joystick)
	return c_func(xsfJoystick_isConnected,{joystick})
end function

public constant xsfJoystick_getButtonCount = define_c_func(win,"+sfJoystick_getButtonCount",{C_UINT},C_UINT)

public function sfJoystick_getButtonCount(atom joystick)
	return c_func(xsfJoystick_getButtonCount,{joystick})
end function

public constant xsfJoystick_hasAxis = define_c_func(win,"+sfJoystick_hasAxis",{C_UINT,C_INT},C_BOOL)

public function sfJoystick_hasAxis(atom joystick,sfJoystickAxis axis)
	return c_func(xsfJoystick_hasAxis,{joystick,axis})
end function

public constant xsfJoystick_isButtonPressed = define_c_func(win,"+sfJoystick_isButtonPressed",{C_UINT,C_UINT},C_BOOL)

public function sfJoystick_isButtonPressed(atom joystick,atom button)
	return c_func(xsfJoystick_isButtonPressed,{joystick,button})
end function

public constant xsfJoystick_getAxisPosition = define_c_func(win,"+sfJoystick_getAxisPosition",{C_UINT,C_INT},C_FLOAT)

public function sfJoystick_getAxisPosition(atom joystick,sfJoystickAxis axis)
	return c_func(xsfJoystick_getAxisPosition,{joystick,axis})
end function

public constant xsfJoystick_getIdentification = define_c_func(win,"+sfJoystick_getIdentification",{C_UINT},sfJoystickIdentification)

public function sfJoystick_getIdentification(atom joystick)
	return c_func(xsfJoystick_getIdentification,{joystick})
end function

public constant xsfJoystick_update = define_c_proc(win,"+sfJoystick_update",{})

public procedure sfJoystick_update()
	c_proc(xsfJoystick_update,{})
end procedure

--Mouse

public enum type sfMouseButton
	sfMouseLeft = 0,     --    ///< The left mouse button
    sfMouseRight,        --///< The right mouse button
    sfMouseMiddle,       --///< The middle (wheel) mouse button
    sfMouseButtonExtra1, --///< The first extra mouse button
    sfMouseButtonExtra2 --///< The second extra mouse button
end type

public constant sfMouseButtonCount = sfMouseButtonExtra2 + 1

public enum type sfMouseWheel
	sfMouseVerticalWheel = 0, -- ///< The vertical mouse wheel
    sfMouseHorizontalWheel -- ///< The horizontal mouse wheel
end type

public constant xsfMouse_isButtonPressed = define_c_func(win,"+sfMouse_isButtonPressed",{C_INT},C_BOOL)

public function sfMouse_isButtonPressed(sfMouseButton button)
	return c_func(xsfMouse_isButtonPressed,{button})
end function

public constant xsfMouse_getPosition = define_c_func(win,"+sfMouse_getPosition",{C_POINTER},sfVector2i)

public function sfMouse_getPosition(atom relativeto)
	return c_func(xsfMouse_getPosition,{relativeto})
end function

public constant xsfMouse_setPosition = define_c_proc(win,"+sfMouse_setPosition",{sfVector2i,C_POINTER})

public procedure sfMouse_setPosition(sequence pos,atom relativeto)
	c_proc(xsfMouse_setPosition,{pos,relativeto})
end procedure

public constant xsfMouse_getPositionWindowBase = define_c_func(win,"+sfMouse_getPositionWindowBase",{C_POINTER},sfVector2i)

public function sfMouse_getPositionWindowBase(atom relativeto)
	return c_func(xsfMouse_getPositionWindowBase,{relativeto})
end function

public constant xsfMouse_setPositionWindowBase = define_c_proc(win,"+sfMouse_setPositionWindowBase",{sfVector2i,C_POINTER})

public procedure sfMouse_setPositionWindowBase(sequence pos,atom relativeto)
	c_proc(xsfMouse_setPositionWindowBase,{pos,relativeto})
end procedure

--Sensor

public enum type sfSensorType
	sfSensorAccelerometer = 0, --///< Measures the raw acceleration (m/s^2)
    sfSensorGyroscope,     --///< Measures the raw rotation rates (degrees/s)
    sfSensorMagnetometer,  --///< Measures the ambient magnetic field (micro-teslas)
    sfSensorGravity, --///< Measures the direction and intensity of gravity, independent of device acceleration (m/s^2)
    sfSensorUserAcceleration, --///< Measures the direction and intensity of device acceleration, independent of the gravity (m/s^2)
    sfSensorOrientation --///< Measures the absolute 3D orientation (degrees)
end type

public constant sfSensorCount = sfSensorOrientation + 1

public constant xsfSensor_isAvailable = define_c_func(win,"+sfSensor_isAvailable",{C_INT},C_BOOL)

public function sfSensor_isAvailable(sfSensorType sensor)
	return c_func(xsfSensor_isAvailable,{sensor})
end function

public constant xsfSensor_setEnabled = define_c_proc(win,"+sfSensor_setEnabled",{C_INT,C_BOOL})

public procedure sfSensor_setEnabled(sfSensorType sensor,atom enabled)
	c_proc(xsfSensor_setEnabled,{sensor,enabled})
end procedure

public constant xsfSensor_getValue = define_c_func(win,"+sfSensor_getValue",{C_INT},sfVector3f)

public function sfSensor_getValue(sfSensorType sensor)
	return c_func(xsfSensor_getValue,{sensor})
end function

--Event

public enum type sfEventType
	sfEvtClosed = 0,          --       ///< The window requested to be closed (no data)
    sfEvtResized,              --  ///< The window was resized (data in event.size)
    sfEvtFocusLost,             -- ///< The window lost the focus (no data)
    sfEvtFocusGained,           -- ///< The window gained the focus (no data)
    sfEvtTextEntered,           -- ///< A character was entered (data in event.text)
    sfEvtKeyPressed,            -- ///< A key was pressed (data in event.key)
    sfEvtKeyReleased,           -- ///< A key was released (data in event.key)
    sfEvtMouseWheelScrolled,    -- ///< The mouse wheel was scrolled (data in event.mouseWheelScroll)
    sfEvtMouseButtonPressed,    -- ///< A mouse button was pressed (data in event.mouseButton)
    sfEvtMouseButtonReleased,   -- ///< A mouse button was released (data in event.mouseButton)
    sfEvtMouseMoved,            -- ///< The mouse cursor moved (data in event.mouseMove)
    sfEvtMouseMovedRaw,         -- ///< The mouse cursor moved (data in event.mouseMove)
    sfEvtMouseEntered,           --///< The mouse cursor entered the area of the window (no data)
    sfEvtMouseLeft,              --///< The mouse cursor left the area of the window (no data)
    sfEvtJoystickButtonPressed,  --///< A joystick button was pressed (data in event.joystickButton)
    sfEvtJoystickButtonReleased, --///< A joystick button was released (data in event.joystickButton)
    sfEvtJoystickMoved,          --///< The joystick moved along an axis (data in event.joystickMove)
    sfEvtJoystickConnected,      --///< A joystick was connected (data in event.joystickConnect)
    sfEvtJoystickDisconnected,   --///< A joystick was disconnected (data in event.joystickConnect)
    sfEvtTouchBegan,             --///< A touch event began (data in event.touch)
    sfEvtTouchMoved,             --///< A touch moved (data in event.touch)
    sfEvtTouchEnded,             --///< A touch event ended (data in event.touch)
    sfEvtSensorChanged,          --///< A sensor value changed (data in event.sensor)

    sfEvtCount --///< Keep last -- the total number of event types
end type

public constant sfKeyEvent = define_c_struct({
	C_INT, --type sfEventType
	C_INT, --code sfKeyCode
	C_INT, --scancode sfScancode
	C_BOOL, --alt
	C_BOOL, --control
	C_BOOL, --shift
	C_BOOL  --system
})

public constant sfTextEvent = define_c_struct({
	C_INT, --type sfEventType
	C_UINT32 --unicode
})

public constant sfMouseMoveEvent = define_c_struct({
	C_INT, --type sfEventType
	sfVector2i --position
})

public constant sfMouseMoveRawEvent = define_c_struct({
	C_INT, --type sfEventType
	sfVector2i --delta
})

public constant sfMouseButtonEvent = define_c_struct({
	C_INT, --sfEventType type
	C_INT, --button sfMouseButton
	sfVector2i --position
})

public constant sfMouseWheelScrollEvent = define_c_struct({
	C_INT, --type sfEventType
	C_INT, --wheel sfMouseWheel
	C_FLOAT, --detla
	sfVector2i --position
})

public constant sfJoystickMoveEvent = define_c_struct({
	C_INT, --type sfEventType
	C_UINT, --joystickId
	C_INT, --axis sfJoystickAxis
	C_FLOAT --position
})

public constant sfJoystickButtonEvent = define_c_struct({
	C_INT, --sfEventTYpe type
	C_UINT, --joystickId
	C_UINT  --button
})

public constant sfJoystickConnectEvent = define_c_struct({
	C_INT, --type sfEventType
	C_UINT --joystickId
})

public constant sfSizeEvent = define_c_struct({
	C_INT, --sfEventType type
	sfVector2u --size
})

public constant sfTouchEvent = define_c_struct({
	C_INT, --sfEventType type
	C_UINT, --finger
	sfVector2i --position
})

public constant sfSensorEvent = define_c_struct({
	C_INT, --type sfEventType
	C_INT, --sensorType
	sfVector3f --value
})

public constant sfEvent = define_c_union({
	C_INT, --type sfEventType
	sfSizeEvent, --size
	sfKeyEvent, --key
	sfTextEvent, --text
	sfMouseMoveEvent, --mouseMove
	sfMouseMoveRawEvent, --mouseMoveRaw
	sfMouseButtonEvent, --mousebutton
	sfMouseWheelScrollEvent, --mouseWheelscroll
	sfJoystickMoveEvent, --joystickMove
	sfJoystickButtonEvent, --joystickButton
	sfJoystickConnectEvent, --joystickConnect
	sfTouchEvent, --touch
	sfSensorEvent --sensor
})

--Vulkan

public constant xsfVulkan_isAvailable = define_c_func(win,"+sfVulkan_isAvailable",{C_BOOL},C_BOOL)

public function sfVulkan_isAvailable(atom requireGraphics)
	return c_func(xsfVulkan_isAvailable,{requireGraphics})
end function

public constant xsfVulkan_getFunction = define_c_func(win,"+sfVulkan_getFunction",{C_STRING},C_POINTER)

public function sfVulkan_getFunction(sequence name)
	return c_func(xsfVulkan_getFunction,{name})
end function

public constant xsfVulkan_getGraphicsRequiredInstanceExtensions = define_c_func(win,"+sfVulkan_getGraphicsRequiredInstanceExtensions",{C_POINTER},C_POINTER)

public function sfVulkan_getGraphicsRequiredInstanceExtensions(atom count)
	return c_func(xsfVulkan_getGraphicsRequiredInstanceExtensions,{count})
end function

--WindowBase

public enum type sfWindowStyle
	sfNone = 0,
	sfTitlebar = 1, -- 1 << 0
	sfResize = 2, -- 1 << 1
	sfClose = 4, -- 1 << 2
	sfDefaultStyle = 7 --sfTitlebar | sfResize | sfClose
end type

public enum type sfWindowState
	sfWindowed = 0,
	sfFullscreen
end type

public constant xsfWindowBase_create = define_c_func(win,"+sfWindowBase_create",{sfVideoMode,C_STRING,C_UINT32,C_INT},C_POINTER)

public function sfWindowBase_create(sequence mode,sequence title,atom style,sfWindowState state)
	return c_func(xsfWindowBase_create,{mode,title,style,state})
end function

public constant xsfWindowBase_createUnicode = define_c_func(win,"+sfWindowBase_createUnicode",{sfVideoMode,C_POINTER,C_UINT32,C_INT},C_POINTER)

public function sfWindowBase_createUnicode(sequence mode,sequence title,atom style,sfWindowState state)
	atom str = allocate_string(title,1)
	return c_func(xsfWindowBase_createUnicode,{mode,str,style,state})
end function

public constant xsfWindowBase_createFromHandle = define_c_func(win,"+sfWindowBase_createFromHandle",{C_POINTER},C_POINTER)

public function sfWindowBase_createFromHandle(atom handle)
 	return c_func(xsfWindowBase_createFromHandle,{handle})
end function

public constant xsfWindowBase_destroy = define_c_proc(win,"+sfWindowBase_destroy",{C_POINTER})

public procedure sfWindowBase_destroy(atom windowBase)
	c_proc(xsfWindowBase_destroy,{windowBase})
end procedure

public constant xsfWindowBase_close = define_c_proc(win,"+sfWindowBase_close",{C_POINTER})

public procedure sfWindowBase_close(atom windowBase)
	c_proc(xsfWindowBase_close,{windowBase})
end procedure

public constant xsfWindowBase_isOpen = define_c_func(win,"+sfWindowBase_isOpen",{C_POINTER},C_BOOL)

public function sfWindowBase_isOpen(atom windowBase)
	return c_func(xsfWindowBase_isOpen,{windowBase})
end function

public constant xsfWindowBase_pollEvent = define_c_func(win,"+sfWindowBase_pollEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfWindowBase_pollEvent(atom windowBase,atom event)
	return c_func(xsfWindowBase_pollEvent,{windowBase,event})
end function

public constant xsfWindowBase_waitEvent = define_c_func(win,"+sfWindowBase_waitEvent",{C_POINTER,sfTime,C_POINTER},C_BOOL)

public function sfWindowBase_waitEvent(atom windowBase,sequence timeout,atom event)
	return c_func(xsfWindowBase_waitEvent,{windowBase,timeout,event})
end function

public constant xsfWindowBase_getPosition = define_c_func(win,"+sfWindowBase_getPosition",{C_POINTER},sfVector2i)

public function sfWindowBase_getPosition(atom windowBase)
	return c_func(xsfWindowBase_getPosition,{windowBase})
end function

public constant xsfWindowBase_setPosition = define_c_proc(win,"+sfWindowBase_setPosition",{C_POINTER,sfVector2i})

public procedure sfWindowBase_setPosition(atom windowBase,sequence pos)
	c_proc(xsfWindowBase_setPosition,{windowBase,pos})
end procedure

public constant xsfWindowBase_getSize = define_c_func(win,"+sfWindowBase_getSize",{C_POINTER},sfVector2u)

public function sfWindowBase_getSize(atom windowBase)
	return c_func(xsfWindowBase_getSize,{windowBase})
end function

public constant xsfWindowBase_setSize = define_c_proc(win,"+sfWindowBase_setSize",{C_POINTER,sfVector2u})

public procedure sfWindowBase_setSize(atom windowBase,sequence size)
	c_proc(xsfWindowBase_setSize,{windowBase,size})
end procedure

public constant xsfWindowBase_setMinimumSize = define_c_proc(win,"+sfWindowBase_setMinimumSize",{C_POINTER,C_POINTER})

public procedure sfWindowBase_setMinimumSize(atom windowBase,atom minSize)
	c_proc(xsfWindowBase_setMinimumSize,{windowBase,minSize})
end procedure

public constant xsfWindowBase_setMaximumSize = define_c_proc(win,"+sfWindowBase_setMaximumSize",{C_POINTER,C_POINTER})

public procedure sfWindowBase_setMaximumSize(atom windowBase,atom maxSize)
	c_proc(xsfWindowBase_setMaximumSize,{windowBase,maxSize})
end procedure

public constant xsfWindowBase_setTitle = define_c_proc(win,"+sfWindowBase_setTitle",{C_POINTER,C_STRING})

public procedure sfWindowBase_setTitle(atom windowBase,sequence title)
	c_proc(xsfWindowBase_setTitle,{windowBase,title})
end procedure

public constant xsfWindowBase_setUnicodeTitle = define_c_proc(win,"+sfWindowBase_setUnicodeTitle",{C_POINTER,C_POINTER})

public procedure sfWindowBase_setUnicodeTitle(atom windowBase,sequence title)
	atom str = allocate_string(title,1)
	c_proc(xsfWindowBase_setUnicodeTitle,{windowBase,str})
end procedure

public constant xsfWindowBase_setIcon = define_c_proc(win,"+sfWindowBase_setIcon",{C_POINTER,sfVector2u,C_POINTER})

public procedure sfWindowBase_setIcon(atom windowBase,sequence size,atom pixels)
	c_proc(xsfWindowBase_setIcon,{windowBase,size,pixels})
end procedure

public constant xsfWindowBase_setVisible = define_c_proc(win,"+sfWindowBase_setVisible",{C_POINTER,C_BOOL})

public procedure sfWindowBase_setVisible(atom windowBase,atom visible)
	c_proc(xsfWindowBase_setVisible,{windowBase,visible})
end procedure

public constant xsfWindowBase_setMouseCursorVisible = define_c_proc(win,"+sfWindowBase_setMouseCursorVisible",{C_POINTER,C_BOOL})

public procedure sfWindowBase_setMouseCursorVisible(atom windowBase,atom visible)
	c_proc(xsfWindowBase_setMouseCursorVisible,{windowBase,visible})
end procedure

public constant xsfWindowBase_setMouseCursorGrabbed = define_c_proc(win,"+sfWindowBase_setMouseCursorGrabbed",{C_POINTER,C_BOOL})

public procedure sfWindowBase_setMouseCursorGrabbed(atom windowBase,atom grabbed)
	c_proc(xsfWindowBase_setMouseCursorGrabbed,{windowBase,grabbed})
end procedure

public constant xsfWindowBase_setMouseCursor = define_c_proc(win,"+sfWindowBase_setMouseCursor",{C_POINTER,C_POINTER})

public procedure sfWindowBase_setMouseCursor(atom windowBase,atom cursor)
	c_proc(xsfWindowBase_setMouseCursor,{windowBase,cursor})
end procedure

public constant xsfWindowBase_setKeyRepeatEnabled = define_c_proc(win,"+sfWindowBase_setKeyRepeatEnabled",{C_POINTER,C_BOOL})

public procedure sfWindowBase_setKeyRepeatEnabled(atom windowBase,atom enabled)
	c_proc(xsfWindowBase_setKeyRepeatEnabled,{windowBase,enabled})
end procedure

public constant xsfWindowBase_setJoystickThreshold = define_c_proc(win,"+sfWindowBase_setJoystickThreshold",{C_POINTER,C_FLOAT})

public procedure sfWindowBase_setJoystickThreshold(atom windowBase,atom threshold)
	c_proc(xsfWindowBase_setJoystickThreshold,{windowBase,threshold})
end procedure

public constant xsfWindowBase_requestFocus = define_c_proc(win,"+sfWindowBase_requestFocus",{C_POINTER})

public procedure sfWindowBase_requestFocus(atom windowBase)
	c_proc(xsfWindowBase_requestFocus,{windowBase})
end procedure

public constant xsfWindowBase_hasFocus = define_c_func(win,"+sfWindowBase_hasFocus",{C_POINTER},C_BOOL)

public function sfWindowBase_hasFocus(atom windowBase)
	return c_func(xsfWindowBase_hasFocus,{windowBase})
end function

public constant xsfWindowBase_getNativeHandle = define_c_func(win,"+sfWindowBase_getNativeHandle",{C_POINTER},C_POINTER)

public function sfWindowBase_getNativeHandle(atom windowBase)
	return c_func(xsfWindowBase_getNativeHandle,{windowBase})
end function

public constant xsfWindowBase_createVulkanSurface = define_c_func(win,"+sfWindowBase_createVulkanSurface",{C_POINTER,C_POINTER,C_POINTER,C_POINTER},C_BOOL)

public function sfWindowBase_createVulkanSurface(atom windowBase,atom xinstance,atom surface,atom allocator)
	return c_func(xsfWindowBase_createVulkanSurface,{windowBase,xinstance,surface,allocator})
end function

--Window

public enum type sfContextAttribute
	sfContextDefault = 0,
	sfContextCore = 1,
	sfContextDebug = 4
end type

public constant sfContextSettings = define_c_struct({
	C_UINT, --depthBits
	C_UINT, --stencilBits
	C_UINT, --antiAliasingLevel
	C_UINT, --majorVersion
	C_UINT, --minorVersion
	C_UINT32, --attribureFlags
	C_BOOL   --sRgbCapable
})

public constant xsfWindow_create = define_c_func(win,"+sfWindow_create",{sfVideoMode,C_STRING,C_UINT32,C_INT,C_POINTER},C_POINTER)

public function sfWindow_create(sequence mode,sequence title,atom style,sfWindowState state,atom settings)
	return c_func(xsfWindow_create,{mode,title,style,state,settings})
end function

public constant xsfWindow_createUnicode = define_c_func(win,"+sfWindow_createUnicode",{sfVideoMode,C_POINTER,C_UINT32,C_INT,C_POINTER},C_POINTER)

public function sfWindow_createUnicode(sequence mode,sequence title,atom style,sfWindowState state,atom settings)
	atom str = allocate_string(title,1)
	return c_func(xsfWindow_createUnicode,{mode,str,style,state,settings})
end function

public constant xsfWindow_createFromHandle = define_c_func(win,"+sfWindow_createFromHandle",{C_POINTER,C_POINTER},C_POINTER)

public function sfWindow_createFromHandle(atom handle,atom settings)
	return c_func(xsfWindow_createFromHandle,{handle,settings})
end function

public constant xsfWindow_destroy = define_c_proc(win,"+sfWindow_destroy",{C_POINTER})

public procedure sfWindow_destroy(atom window)
	c_proc(xsfWindow_destroy,{window})
end procedure

public constant xsfWindow_close = define_c_proc(win,"+sfWindow_close",{C_POINTER})

public procedure sfWindow_close(atom window)
	c_proc(xsfWindow_close,{window})
end procedure

public constant xsfWindow_isOpen = define_c_func(win,"+sfWindow_isOpen",{C_POINTER},C_BOOL)

public function sfWindow_isOpen(atom window)
	return c_func(xsfWindow_isOpen,{window})
end function

public constant xsfWindow_getSettings = define_c_func(win,"+sfWindow_getSettings",{C_POINTER},sfContextSettings)

public function sfWindow_getSettings(atom window)
	return c_func(xsfWindow_getSettings,{window})
end function

public constant xsfWindow_pollEvent = define_c_func(win,"+sfWindow_pollEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfWindow_pollEvent(atom window,atom event)
	return c_func(xsfWindow_pollEvent,{window,event})
end function

public constant xsfWindow_waitEvent = define_c_func(win,"+sfWindow_waitEvent",{C_POINTER,sfTime,C_POINTER},C_BOOL)

public function sfWindow_waitEvent(atom window,sequence timeout,atom event)
	return c_func(xsfWindow_waitEvent,{window,timeout,event})
end function

public constant xsfWindow_getPosition = define_c_func(win,"+sfWindow_getPosition",{C_POINTER},sfVector2i)

public function sfWindow_getPosition(atom window)
	return c_func(xsfWindow_getPosition,{window})
end function

public constant xsfWindow_setPosition = define_c_proc(win,"+sfWindow_setPosition",{C_POINTER,sfVector2i})

public procedure sfWindow_setPosition(atom window,sequence pos)
	c_proc(xsfWindow_setPosition,{window,pos})
end procedure

public constant xsfWindow_getSize = define_c_func(win,"+sfWindow_getSize",{C_POINTER},sfVector2u)

public function sfWindow_getSize(atom window)
	return c_func(xsfWindow_getSize,{window})
end function

public constant xsfWindow_setSize = define_c_proc(win,"+sfWindow_setSize",{C_POINTER,sfVector2u})

public procedure sfWindow_setSize(atom window,sequence size)
	c_proc(xsfWindow_setSize,{window,size})
end procedure

public constant xsfWindow_setMinimumSize = define_c_proc(win,"+sfWindow_setMinimumSize",{C_POINTER,C_POINTER})

public procedure sfWindow_setMinimumSize(atom window,atom minSize)
	c_proc(xsfWindow_setMinimumSize,{window,minSize})
end procedure

public constant xsfWindow_setMaximumSize = define_c_proc(win,"+sfWindow_setMaximumSize",{C_POINTER,C_POINTER})

public procedure sfWindow_setMaximumSize(atom window,atom maxSize)
	c_proc(xsfWindow_setMaximumSize,{window,maxSize})
end procedure

public constant xsfWindow_setTitle = define_c_proc(win,"+sfWindow_setTitle",{C_POINTER,C_STRING})

public procedure sfWindow_setTitle(atom window,sequence title)
	c_proc(xsfWindow_setTitle,{window,title})
end procedure

public constant xsfWindow_setUnicodeTitle = define_c_proc(win,"+sfWindow_setUnicodeTitle",{C_POINTER,C_POINTER})

public procedure sfWindow_setUnicodeTitle(atom window,sequence title)
	atom str = allocate_string(title,1)
	c_proc(xsfWindow_setUnicodeTitle,{window,str})
end procedure

public constant xsfWindow_setIcon = define_c_proc(win,"+sfWindow_setIcon",{C_POINTER,sfVector2u,C_POINTER})

public procedure sfWindow_setIcon(atom window,sequence size,atom pixels)
	c_proc(xsfWindow_setIcon,{window,size,pixels})
end procedure

public constant xsfWindow_setVisible = define_c_proc(win,"+sfWindow_setVisible",{C_POINTER,C_BOOL})

public procedure sfWindow_setVisible(atom window,atom visible)
	c_proc(xsfWindow_setVisible,{window,visible})
end procedure

public constant xsfWindow_setVerticalSyncEnabled = define_c_proc(win,"+sfWindow_setVerticalSyncEnabled",{C_POINTER,C_BOOL})

public procedure sfWindow_setVerticalSyncEnabled(atom window,atom enabled)
	c_proc(xsfWindow_setVerticalSyncEnabled,{window,enabled})
end procedure

public constant xsfWindow_setMouseCursorVisible = define_c_proc(win,"+sfWindow_setMouseCursorVisible",{C_POINTER,C_BOOL})

public procedure sfWindow_setMouseCursorVisible(atom window,atom visible)
	c_proc(xsfWindow_setMouseCursorVisible,{window,visible})
end procedure

public constant xsfWindow_setMouseCursorGrabbed = define_c_proc(win,"+sfWindow_setMouseCursorGrabbed",{C_POINTER,C_BOOL})

public procedure sfWindow_setMouseCursorGrabbed(atom window,atom grabbed)
	c_proc(xsfWindow_setMouseCursorGrabbed,{window,grabbed})
end procedure

public constant xsfWindow_setMouseCursor = define_c_proc(win,"+sfWindow_setMouseCursor",{C_POINTER,C_POINTER})

public procedure sfWindow_setMouseCursor(atom window,atom cursor)
	c_proc(xsfWindow_setMouseCursor,{window,cursor})
end procedure

public constant xsfWindow_setKeyRepeatEnabled = define_c_proc(win,"+sfWindow_setKeyRepeatEnabled",{C_POINTER,C_BOOL})

public procedure sfWindow_setKeyRepeatEnabled(atom window,atom enabled)
	c_proc(xsfWindow_setKeyRepeatEnabled,{window,enabled})
end procedure

public constant xsfWindow_setFramerateLimit = define_c_proc(win,"+sfWindow_setFramerateLimit",{C_POINTER,C_UINT})

public procedure sfWindow_setFramerateLimit(atom window,atom limit)
	c_proc(xsfWindow_setFramerateLimit,{window,limit})
end procedure

public constant xsfWindow_setJoystickThreshold = define_c_proc(win,"+sfWindow_setJoystickThreshold",{C_POINTER,C_FLOAT})

public procedure sfWindow_setJoystickThreshold(atom window,atom threshold)
	c_proc(xsfWindow_setJoystickThreshold,{window,threshold})
end procedure

public constant xsfWindow_setActive = define_c_func(win,"+sfWindow_setActive",{C_POINTER,C_BOOL},C_BOOL)

public function sfWindow_setActive(atom window,atom active)
	return c_func(xsfWindow_setActive,{window,active})
end function

public constant xsfWindow_requestFocus = define_c_proc(win,"+sfWindow_requestFocus",{C_POINTER})

public procedure sfWindow_requestFocus(atom window)
	c_proc(xsfWindow_requestFocus,{window})
end procedure

public constant xsfWindow_hasFocus = define_c_func(win,"+sfWindow_hasFocus",{C_POINTER},C_BOOL)

public function sfWindow_hasFocus(atom window)
	return c_func(xsfWindow_hasFocus,{window})
end function

public constant xsfWindow_display = define_c_proc(win,"+sfWindow_display",{C_POINTER})

public procedure sfWindow_display(atom window)
	c_proc(xsfWindow_display,{window})
end procedure

public constant xsfWindow_getNativeHandle = define_c_func(win,"+sfWindow_getNativeHandle",{C_POINTER},C_POINTER)

public function sfWindow_getNativeHandle(atom window)
	return c_func(xsfWindow_getNativeHandle,{window})
end function

public constant xsfWindow_createVulkanSurface = define_c_func(win,"+sfWindow_createVulkanSurface",{C_POINTER,C_POINTER,C_POINTER,C_POINTER},C_BOOL)

public function sfWindow_createVulkanSurface(atom window,atom xinstance,atom surface,atom allocator)
	return c_func(xsfWindow_createVulkanSurface,{window,xinstance,surface,allocator})
end function

--Cursor

public enum type sfCursorType
	sfCursorArrow = 0,           --       ///< Arrow cursor (default)
    sfCursorArrowWait,            --  ///< Busy arrow cursor
    sfCursorWait,                  -- ///< Busy cursor
    sfCursorText,                  -- ///< I-beam, cursor when hovering over a field allowing text entry
    sfCursorHand,                  -- ///< Pointing hand cursor
    sfCursorSizeHorizontal,        -- ///< Horizontal double arrow cursor
    sfCursorSizeVertical,          -- ///< Vertical double arrow cursor
    sfCursorSizeTopLeftBottomRight,-- ///< Double arrow cursor going from top-left to bottom-right
    sfCursorSizeBottomLeftTopRight, --///< Double arrow cursor going from bottom-left to top-right
    sfCursorSizeLeft,               --///< Left arrow cursor on Linux, same as SizeHorizontal on other platforms
    sfCursorSizeRight,              --///< Right arrow cursor on Linux, same as SizeHorizontal on other platforms
    sfCursorSizeTop,                --///< Up arrow cursor on Linux, same as SizeVertical on other platforms
    sfCursorSizeBottom,             --///< Down arrow cursor on Linux, same as SizeVertical on other platforms
    sfCursorSizeTopLeft,     --///< Top-left arrow cursor on Linux, same as SizeTopLeftBottomRight on other platforms
    sfCursorSizeBottomRight, --///< Bottom-right arrow cursor on Linux, same as SizeTopLeftBottomRight on other platforms
    sfCursorSizeBottomLeft,  --///< Bottom-left arrow cursor on Linux, same as SizeBottomLeftTopRight on other platforms
    sfCursorSizeTopRight,    --///< Top-right arrow cursor on Linux, same as SizeBottomLeftTopRight on other platforms
    sfCursorSizeAll,         --///< Combination of SizeHorizontal and SizeVertical
    sfCursorCross,           --///< Crosshair cursor
    sfCursorHelp,            --///< Help cursor
    sfCursorNotAllowed       --///< Action not allowed cursor
end type

public constant xsfCursor_createFromPixels = define_c_func(win,"+sfCursor_createFromPixels",{C_POINTER,sfVector2u,sfVector2u},C_POINTER)

public function sfCursor_createFromPixels(atom pixels,sequence size,sequence hotspot)
	return c_func(xsfCursor_createFromPixels,{pixels,size,hotspot})
end function

public constant xsfCursor_createFromSystem = define_c_func(win,"+sfCursor_createFromSystem",{C_INT},C_POINTER)

public function sfCursor_createFromSystem(sfCursorType ctype)
	return c_func(xsfCursor_createFromSystem,{ctype})
end function

public constant xsfCursor_destroy = define_c_proc(win,"+sfCursor_destroy",{C_POINTER})

public procedure sfCursor_destroy(atom cursor)
	c_proc(xsfCursor_destroy,{cursor})
end procedure

--Context

public constant xsfContext_create = define_c_func(win,"+sfContext_create",{},C_POINTER)

public function sfContext_create()
	return c_func(xsfContext_create,{})
end function

public constant xsfContext_destroy = define_c_proc(win,"+sfContext_destroy",{C_POINTER})

public procedure sfContext_destroy(atom context)
	c_proc(xsfContext_destroy,{context})
end procedure

public constant xsfContext_isExtensionAvailable = define_c_func(win,"+sfContext_isExtensionAvailable",{C_STRING},C_BOOL)

public function sfContext_isExtensionAvailable(sequence name)
	return c_func(xsfContext_isExtensionAvailable,{name})
end function

public constant xsfContext_setActive = define_c_func(win,"+sfContext_setActive",{C_POINTER,C_BOOL},C_BOOL)

public function sfContext_setActive(atom context,atom active)
	return c_func(xsfContext_setActive,{context,active})
end function

public constant xsfContext_getFunction = define_c_func(win,"+sfContext_getFunction",{C_STRING},C_POINTER)

public function sfContext_getFunction(sequence name)
	return c_func(xsfContext_getFunction,{name})
end function

public constant xsfContext_getSettings = define_c_func(win,"+sfContext_getSettings",{C_POINTER},sfContextSettings)

public function sfContext_getSettings(atom context)
	return c_func(xsfContext_getSettings,{context})
end function

public constant xsfContext_getActiveContextId = define_c_func(win,"+sfContext_getActiveContextId",{},C_UINT64)

public function sfContext_getActiveContextId()
	return c_func(xsfContext_getActiveContextId,{})
end function
­3.20