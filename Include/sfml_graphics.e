--EuSFML Graphics 3
--Written by Andy P.
--Copyright (c) 2026
include std/ffi.e
include std/machine.e
include std/os.e

public atom gfx

ifdef WINDOWS then
	gfx = open_dll("csfml-graphics-3.dll")
	elsifdef LINUX or FREEBSD then
	gfx = open_dll("libcsfml-graphics-3.so")
	elsifdef OSX then
	gfx = open_dll("libcsfml-graphics-3.dylib")
end ifdef

if gfx = -1 then
	puts(1,"Failed to load csfml-graphics-3!\n")
	abort(0)
end if

include sfml_system.e
include sfml_window.e

--printf(1,"%d",{gfx})

--CoordinateType
public enum type sfCoordinateType
	sfCoordinateTypeNormalized = 0,
	sfCoordinateTypePixels
end type

--Color

public constant sfColor = define_c_struct({
	C_UINT8, --r
	C_UINT8, --g
	C_UINT8, --b
	C_UINT8  --a
})

public constant xsfBlack = define_c_func(gfx,"+sfBlack",{},sfColor)

public function sfBlack()
	return c_func(xsfBlack,{})
end function

public constant xsfWhite = define_c_func(gfx,"+sfWhite",{},sfColor)

public function sfWhite()
	return c_func(xsfWhite,{})
end function

public constant xsfRed = define_c_func(gfx,"+sfRed",{},sfColor)

public function sfRed()
	return c_func(xsfRed,{})
end function

public constant xsfGreen = define_c_func(gfx,"+sfGreen",{},sfColor)

public function sfGreen()
	return c_func(xsfGreen,{})
end function

public constant xsfBlue = define_c_func(gfx,"+sfBlue",{},sfColor)

public function sfBlue()
	return c_func(xsfBlue,{})
end function

public constant xsfYellow = define_c_func(gfx,"+sfYellow",{},sfColor)

public function sfYellow()
	return c_func(xsfYellow,{})
end function

public constant xsfMagenta = define_c_func(gfx,"+sfMagenta",{},sfColor)

public function sfMagenta()
	return c_func(xsfMagenta,{})
end function

public constant xsfCyan = define_c_func(gfx,"+sfCyan",{},sfColor)

public function sfCyan()
	return c_func(xsfCyan,{})
end function

public constant xsfTransparent = define_c_func(gfx,"+sfTransparent",{},sfColor)

public function sfTransparent()
	return c_func(xsfTransparent,{})
end function

public constant xsfColor_fromRGB = define_c_func(gfx,"+sfColor_fromRGB",{C_UINT8,C_UINT8,C_UINT8},sfColor)

public function sfColor_fromRGB(atom red,atom green,atom blue)
	return c_func(xsfColor_fromRGB,{red,green,blue})
end function

public constant xsfColor_fromRGBA = define_c_func(gfx,"+sfColor_fromRGBA",{C_UINT8,C_UINT8,C_UINT8,C_UINT8},sfColor)

public function sfColor_fromRGBA(atom red,atom green,atom blue,atom alpha)
	return c_func(xsfColor_fromRGBA,{red,green,blue,alpha})
end function

public constant xsfColor_fromInteger = define_c_func(gfx,"+sfColor_fromInteger",{C_UINT32},sfColor)

public function sfColor_fromInteger(atom color)
	return c_func(xsfColor_fromInteger,{color})
end function

public constant xsfColor_toInteger = define_c_func(gfx,"+sfColor_toInteger",{sfColor},C_UINT32)

public function sfColor_toInteger(sequence color)
	return c_func(xsfColor_toInteger,{color})
end function

public constant xsfColor_add = define_c_func(gfx,"+sfColor_add",{sfColor,sfColor},sfColor)

public function sfColor_add(sequence color1,sequence color2)
	return c_func(xsfColor_add,{color1,color2})
end function

public constant xsfColor_subtract = define_c_func(gfx,"+sfColor_subtract",{sfColor,sfColor},sfColor)

public function sfColor_subtract(sequence color1,sequence color2)
	return c_func(xsfColor_subtract,{color1,color2})
end function

public constant xsfColor_modulate = define_c_func(gfx,"+sfColor_modulate",{sfColor,sfColor},sfColor)

public function sfColor_modulate(sequence color1,sequence color2)
	return c_func(xsfColor_modulate,{color1,color2})
end function

--PrimitiveType

public enum type sfPrimitiveType
	sfPoints = 0,  --      ///< List of individual points
    sfLines,        -- ///< List of individual lines
    sfLineStrip,    -- ///< List of connected lines, a point uses the previous point to form a line
    sfTriangles,    -- ///< List of individual triangles
    sfTriangleStrip, --///< List of connected triangles, a point uses the two previous points to form a triangle
    sfTriangleFan --///< List of connected triangles, a point uses the common center and the previous point to form a triangle
end type

--Rect

public constant sfFloatRect = define_c_struct({
	sfVector2f, --position
	sfVector2f  --size
})

public constant sfIntRect = define_c_struct({
	sfVector2i, --position
	sfVector2i  --size
})

public constant xsfFloatRect_contains = define_c_func(gfx,"+sfFloatRect_contains",{C_POINTER,sfVector2f},C_BOOL)

public function sfFloatRect_contains(atom rect,sequence point)
	return c_func(xsfFloatRect_contains,{rect,point})
end function

public constant xsfIntRect_contains = define_c_func(gfx,"+sfIntRect_contains",{C_POINTER,sfVector2i},C_BOOL)

public function sfIntRect_contains(atom rect,sequence point)
	return c_func(xsfIntRect_contains,{rect,point})
end function

public constant xsfFloatRect_intersects = define_c_func(gfx,"+sfFloatRect_intersects",{C_POINTER,C_POINTER,C_POINTER},C_BOOL)

public function sfFloatRect_intersects(atom rect1,atom rect2,atom intersection)
	return c_func(xsfFloatRect_intersects,{rect1,rect2,intersection})
end function

public constant xsfIntRect_intersects = define_c_func(gfx,"+sfIntRect_intersects",{C_POINTER,C_POINTER,C_POINTER},C_BOOL)

public function sfIntRect_intersects(atom rect1,atom rect2,atom intersection)
	return c_func(xsfIntRect_intersects,{rect1,rect2,intersection})
end function

--Blendmode
public enum type sfBlendFactor
	sfBlendFactorZero = 0,       --      ///< (0, 0, 0, 0)
    sfBlendFactorOne,             -- ///< (1, 1, 1, 1)
    sfBlendFactorSrcColor,         --///< (src.r, src.g, src.b, src.a)
    sfBlendFactorOneMinusSrcColor, --///< (1, 1, 1, 1) - (src.r, src.g, src.b, src.a)
    sfBlendFactorDstColor,         --///< (dst.r, dst.g, dst.b, dst.a)
    sfBlendFactorOneMinusDstColor, --///< (1, 1, 1, 1) - (dst.r, dst.g, dst.b, dst.a)
    sfBlendFactorSrcAlpha,         --///< (src.a, src.a, src.a, src.a)
    sfBlendFactorOneMinusSrcAlpha, --///< (1, 1, 1, 1) - (src.a, src.a, src.a, src.a)
    sfBlendFactorDstAlpha,         --///< (dst.a, dst.a, dst.a, dst.a)
    sfBlendFactorOneMinusDstAlpha  --///< (1, 1, 1, 1) - (dst.a, dst.a, dst.a, dst.a)
end type

public enum type sfBlendEquation
	sfBlendEquationAdd = 0,     --        ///< Pixel = Src * SrcFactor + Dst * DstFactor
    sfBlendEquationSubtract,      --  ///< Pixel = Src * SrcFactor - Dst * DstFactor
    sfBlendEquationReverseSubtract, --///< Pixel = Dst * DstFactor - Src * SrcFactor
    sfBlendEquationMin,             --///< Pixel = min(Dst, Src)
    sfBlendEquationMax             -- ///< Pixel = max(Dst, Src)
end type

public constant sfBlendMode = define_c_struct({
	C_INT, --colorSrcFactor
	C_INT, --colorDstFactor
	C_INT, --colorEquation
	C_INT, --alphaSrcFactor
	C_INT, --alphaDstFactor
	C_INT  --alphaEquation
})

public constant xsfBlendAlpha = define_c_func(gfx,"+sfBlendAlpha",{},sfBlendMode)

public function sfBlendAlpha()
	return c_func(xsfBlendAlpha,{})
end function

public constant xsfBlendAdd = define_c_func(gfx,"+sfBlendAdd",{},sfBlendMode)

public function sfBlendAdd()
	return c_func(xsfBlendAdd,{})
end function

public constant xsfBlendMultiply = define_c_func(gfx,"+sfBlendMultiply",{},sfBlendMode)

public function sfBlendMultiply()
	return c_func(xsfBlendMultiply,{})
end function

public constant xsfBlendMin = define_c_func(gfx,"+sfBlendMin",{},sfBlendMode)

public function sfBlendMin()
	return c_func(xsfBlendMin,{})
end function

public constant xsfBlendMax = define_c_func(gfx,"+sfBlendMax",{},sfBlendMode)

public function sfBlendMax()
	return c_func(xsfBlendMax,{})
end function

public constant xsfBlendNone = define_c_func(gfx,"+sfBlendNone",{},sfBlendMode)

public function sfBlendNone()
	return c_func(xsfBlendNone,{})
end function

--Transform

public constant sfTransform = define_c_struct({
	{C_FLOAT,9} --matrix[9]
})

public constant xsfTransform_fromMatrix = define_c_func(gfx,"+sfTransform_fromMatrix",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT},sfTransform)

public function sfTransform_fromMatrix(atom a00,atom a01,atom a02,atom a10,atom a11,atom a12,atom a20,atom a21,atom a22)
	return c_func(xsfTransform_fromMatrix,{a00,a01,a02,a10,a11,a12,a20,a21,a22})
end function

public constant xsfTransform_getMatrix = define_c_proc(gfx,"+sfTransform_getMatrix",{C_POINTER,C_POINTER})

public procedure sfTransform_getMatrix(atom transform,atom matrix)
	c_proc(xsfTransform_getMatrix,{transform,matrix})
end procedure

public constant xsfTransform_getInverse = define_c_func(gfx,"+sfTransform_getInverse",{C_POINTER},sfTransform)

public function sfTransform_getInverse(atom transform)
	return c_func(xsfTransform_getInverse,{transform})
end function

public constant xsfTransform_transformPoint = define_c_func(gfx,"+sfTransform_transformPoint",{C_POINTER,sfVector2f},sfVector2f)

public function sfTransform_transformPoint(atom transform,sequence point)
	return c_func(xsfTransform_transformPoint,{transform,point})
end function

public constant xsfTransform_transformRect = define_c_func(gfx,"+sfTransform_transformRect",{C_POINTER,sfFloatRect},sfFloatRect)

public function sfTransform_transformRect(atom transform,sequence rect)
	return c_func(xsfTransform_transformRect,{transform,rect})
end function

public constant xsfTransform_combine = define_c_proc(gfx,"+sfTransform_combine",{C_POINTER,C_POINTER})

public procedure sfTransform_combine(atom transform,atom other)
	c_proc(xsfTransform_combine,{transform,other})
end procedure

public constant xsfTransform_translate = define_c_proc(gfx,"+sfTransform_translate",{C_POINTER,sfVector2f})

public procedure sfTransform_translate(atom transform,sequence offset)
	c_proc(xsfTransform_translate,{transform,offset})
end procedure

public constant xsfTransform_rotate = define_c_proc(gfx,"+sfTransform_rotate",{C_POINTER,C_FLOAT})

public procedure sfTransform_rotate(atom transform,atom angle)
	c_proc(xsfTransform_rotate,{transform,angle})
end procedure

public constant xsfTransform_rotateWithCenter = define_c_proc(gfx,"+sfTransform_rotateWithCenter",{C_POINTER,C_FLOAT,sfVector2f})

public procedure sfTransform_rotateWithCenter(atom transform,atom angle,sequence center)
	c_proc(xsfTransform_rotateWithCenter,{transform,angle,center})
end procedure

public constant xsfTransform_scale = define_c_proc(gfx,"+sfTransform_scale",{C_POINTER,sfVector2f})

public procedure sfTransform_scale(atom transform,sequence scale)
	c_proc(xsfTransform_scale,{transform,scale})
end procedure

public constant xsfTransform_scaleWithCenter = define_c_proc(gfx,"+sfTransform_scaleWithCenter",{C_POINTER,sfVector2f,sfVector2f})

public procedure sfTransform_scaleWithCenter(atom transform,sequence scale,sequence center)
	c_proc(xsfTransform_scaleWithCenter,{transform,scale,center})
end procedure

public constant xsfTransform_equal = define_c_func(gfx,"+sfTransform_equal",{C_POINTER,C_POINTER},C_BOOL)

public function sfTransform_equal(atom left,atom right)
	return c_func(xsfTransform_equal,{left,right})
end function

--Stencilmode
public enum type sfStencilComparison
	sfStencilComparisonNever = 0, --//!< The stencil test never passes
    sfStencilComparisonLess,  --//!< The stencil test passes if the new value is less than the value in the stencil buffer
    sfStencilComparisonLessEqual, --//!< The stencil test passes if the new value is less than or equal to the value in the stencil buffer
    sfStencilComparisonGreater, --//!< The stencil test passes if the new value is greater than the value in the stencil buffer
    sfStencilComparisonGreaterEqual,-- //!< The stencil test passes if the new value is greater than or equal to the value in the stencil buffer
    sfStencilComparisonEqual, --//!< The stencil test passes if the new value is strictly equal to the value in the stencil buffer
    sfStencilComparisonNotEqual, --//!< The stencil test passes if the new value is strictly unequal to the value in the stencil buffer
    sfStencilComparisonAlways --//!< The stencil test always passes
end type

public enum type sfStencilUpdateOperation
	sfStencilUpdateOperationKeep = 0, --//!< If the stencil test passes, the value in the stencil buffer is not modified
    sfStencilUpdateOperationZero, --//!< If the stencil test passes, the value in the stencil buffer is set to zero
    sfStencilUpdateOperationReplace, --//!< If the stencil test passes, the value in the stencil buffer is set to the new value
    sfStencilUpdateOperationIncrement, --//!< If the stencil test passes, the value in the stencil buffer is incremented and if required clamped
    sfStencilUpdateOperationDecrement, --//!< If the stencil test passes, the value in the stencil buffer is decremented and if required clamped
    sfStencilUpdateOperationInvert --//!< If the stencil test passes, the value in the stencil buffer is bitwise inverted
end type

public constant sfStencilValue = define_c_struct({
	C_UINT --value
})

public constant sfStencilMode = define_c_struct({
	C_INT, --stencilCompariosn
	C_INT, --stencilUpdateOperation
	sfStencilValue, --stencilReference
	sfStencilValue, --stencilMask
	C_BOOL  	   --stencilOnly
})

public constant xsfStencilMode_default = define_c_func(gfx,"+sfStencilMode_default",{},sfStencilMode)

public function sfStencilMode_default()
	return c_func(xsfStencilMode_default,{})
end function

--Renderstates
public constant sfRenderStates = define_c_struct({
	sfBlendMode, --blendMode
	sfStencilMode, --stencilMode
	sfTransform,   --transform
	C_INT,         --coordinateType
	C_POINTER,     --texture
	C_POINTER      --shader
})

public constant xsfRenderStates_default = define_c_func(gfx,"+sfRenderStates_default",{},sfRenderStates)

public function sfRenderStates_default()
	return c_func(xsfRenderStates_default,{})
end function

--Vertex
public constant sfVertex = define_c_struct({
	sfVector2f, --position
	sfColor,    --color
	sfVector2f  --texCoords
})

--FontInfo
public constant sfFontInfo = define_c_struct({
	C_STRING --family
})

--Glyph
public constant sfGlyph = define_c_struct({
	C_FLOAT, --advance
	sfFloatRect, --bounds
	sfIntRect   --textureRect
})

--Glsl
public constant sfGlslVec2 = sfVector2f
public constant sfGlslIvec2 = sfVector2i

public constant sfGlslBvec2 = define_c_struct({
	C_BOOL, --x
	C_BOOL  --y
})

public constant sfGlslVec3 = sfVector3f

public constant sfGlslIvec3 = define_c_struct({
	C_INT, --x
	C_INT, --y
	C_INT  --z
})

public constant sfGlslBvec3 = define_c_struct({
	C_BOOL, --x
	C_BOOL, --y
	C_BOOL  --z
})

public constant sfGlslVec4 = define_c_struct({
	C_FLOAT, --x
	C_FLOAT, --y
	C_FLOAT, --z
	C_FLOAT  --w
})

public constant sfGlslIvec4 = define_c_struct({
	C_INT, --x
	C_INT, --y
	C_INT, --z
	C_INT  --w
})

public constant sfGlslBvec4 = define_c_struct({
	C_BOOL, --x
	C_BOOL, --y
	C_BOOL, --z
	C_BOOL  --w
})

public constant sfGlslMat3 = define_c_struct({
	{C_FLOAT,3 * 3} --array[3 * 3]
})

public constant sfGlslMat4 = define_c_struct({
	{C_FLOAT,4 * 4} --array[4 * 4]
})

--Font

public constant xsfFont_createFromFile = define_c_func(gfx,"+sfFont_createFromFile",{C_STRING},C_POINTER)

public function sfFont_createFromFile(sequence fname)
	return c_func(xsfFont_createFromFile,{fname})
end function

public constant xsfFont_createFromMemory = define_c_func(gfx,"+sfFont_createFromMemory",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfFont_createFromMemory(atom data,atom size)
	return c_func(xsfFont_createFromMemory,{data,size})
end function

public constant xsfFont_createFromStream = define_c_func(gfx,"+sfFont_createFromStream",{C_POINTER},C_POINTER)

public function sfFont_createFromStream(atom stream)
	return c_func(xsfFont_createFromStream,{stream})
end function

public constant xsfFont_copy = define_c_func(gfx,"+sfFont_copy",{C_POINTER},C_POINTER)

public function sfFont_copy(atom font)
	return c_func(xsfFont_copy,{font})
end function

public constant xsfFont_destroy = define_c_proc(gfx,"+sfFont_destroy",{C_POINTER})

public procedure sfFont_destroy(atom font)
	c_proc(xsfFont_destroy,{font})
end procedure

public constant xsfFont_getGlyph = define_c_func(gfx,"+sfFont_getGlyph",{C_POINTER,C_UINT32,C_UINT,C_BOOL,C_FLOAT},sfGlyph)

public function sfFont_getGlyph(atom font,atom codePoint,atom charSize,atom bold,atom outlineThick)
	return c_func(xsfFont_getGlyph,{font,codePoint,charSize,bold,outlineThick})
end function

public constant xsfFont_hasGlyph = define_c_func(gfx,"+sfFont_hasGlyph",{C_POINTER,C_UINT32},C_BOOL)

public function sfFont_hasGlyph(atom font,atom codePoint)
	return c_func(xsfFont_hasGlyph,{font,codePoint})
end function

public constant xsfFont_getKerning = define_c_func(gfx,"+sfFont_getKerning",{C_POINTER,C_UINT32,C_UINT32,C_UINT},C_FLOAT)

public function sfFont_getKerning(atom font,atom first,atom second,atom charSize)
	return c_func(xsfFont_getKerning,{font,first,second,charSize})
end function

public constant xsfFont_getBoldKerning = define_c_func(gfx,"+sfFont_getBoldKerning",{C_POINTER,C_UINT32,C_UINT32,C_UINT},C_FLOAT)

public function sfFont_getBoldKerning(atom font,atom first,atom second,atom charSize)
	return c_func(xsfFont_getBoldKerning,{font,first,second,charSize})
end function

public constant xsfFont_getLineSpacing = define_c_func(gfx,"+sfFont_getLineSpacing",{C_POINTER,C_UINT},C_FLOAT)

public function sfFont_getLineSpacing(atom font,atom charSize)
	return c_func(xsfFont_getLineSpacing,{font,charSize})
end function

public constant xsfFont_getUnderlinePosition = define_c_func(gfx,"+sfFont_getUnderlinePosition",{C_POINTER,C_UINT},C_FLOAT)

public function sfFont_getUnderlinePosition(atom font,atom charSize)
	return c_func(xsfFont_getUnderlinePosition,{font,charSize})
end function

public constant xsfFont_getUnderlineThickness = define_c_func(gfx,"+sfFont_getUnderlineThickness",{C_POINTER,C_UINT},C_FLOAT)

public function sfFont_getUnderlineThickness(atom font,atom charSize)
	return c_func(xsfFont_getUnderlineThickness,{font,charSize})
end function

public constant xsfFont_getTexture = define_c_func(gfx,"+sfFont_getTexture",{C_POINTER,C_UINT},C_POINTER)

public function sfFont_getTexture(atom font,atom charSize)
	return c_func(xsfFont_getTexture,{font,charSize})
end function

public constant xsfFont_setSmooth = define_c_proc(gfx,"+sfFont_setSmooth",{C_POINTER,C_BOOL})

public procedure sfFont_setSmooth(atom font,atom smooth)
	c_proc(xsfFont_setSmooth,{font,smooth})
end procedure

public constant xsfFont_isSmooth = define_c_func(gfx,"+sfFont_isSmooth",{C_POINTER},C_BOOL)

public function sfFont_isSmooth(atom font)
	return c_func(xsfFont_isSmooth,{font})
end function

public constant xsfFont_getInfo = define_c_func(gfx,"+sfFont_getInfo",{C_POINTER},sfFontInfo)

public function sfFont_getInfo(atom font)
	return c_func(xsfFont_getInfo,{font})
end function

--RenderWindow

public constant xsfRenderWindow_create = define_c_func(gfx,"+sfRenderWindow_create",{sfVideoMode,C_STRING,C_UINT32,C_INT,C_POINTER},C_POINTER)

public function sfRenderWindow_create(sequence mode,sequence title,atom style,sfWindowState state,atom settings)
	return c_func(xsfRenderWindow_create,{mode,title,style,state,settings})
end function

public constant xsfRenderWindow_createUnicode = define_c_func(gfx,"+sfRenderWindow_createUnicode",{sfVideoMode,C_POINTER,C_UINT32,C_INT,C_POINTER},C_POINTER)

public function sfRenderWindow_createUnicode(sequence mode,sequence title,atom style,sfWindowState state,atom settings)
	atom str = allocate_string(title,1)
	return c_func(xsfRenderWindow_createUnicode,{mode,str,style,state,settings})
end function

public constant xsfRenderWindow_createFromHandle = define_c_func(gfx,"+sfRenderWindow_createFromHandle",{C_POINTER,C_POINTER},C_POINTER)

public function sfRenderWindow_createFromHandle(atom handle,atom settings)
	return c_func(xsfRenderWindow_createFromHandle,{handle,settings})
end function

public constant xsfRenderWindow_destroy = define_c_proc(gfx,"+sfRenderWindow_destroy",{C_POINTER})

public procedure sfRenderWindow_destroy(atom renderWindow)
	c_proc(xsfRenderWindow_destroy,{renderWindow})
end procedure

public constant xsfRenderWindow_close = define_c_proc(gfx,"+sfRenderWindow_close",{C_POINTER})

public procedure sfRenderWindow_close(atom renderWindow)
	c_proc(xsfRenderWindow_close,{renderWindow})
end procedure

public constant xsfRenderWindow_isOpen = define_c_func(gfx,"+sfRenderWindow_isOpen",{C_POINTER},C_BOOL)

public function sfRenderWindow_isOpen(atom renderWindow)
	return c_func(xsfRenderWindow_isOpen,{renderWindow})
end function

public constant xsfRenderWindow_getSettings = define_c_func(gfx,"+sfRenderWindow_getSettings",{C_POINTER},sfContextSettings)

public function sfRenderWindow_getSettings(atom renderWindow)
	return c_func(xsfRenderWindow_getSettings,{renderWindow})
end function

public constant xsfRenderWindow_pollEvent = define_c_func(gfx,"+sfRenderWindow_pollEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfRenderWindow_pollEvent(atom renderWindow,atom event)
	return c_func(xsfRenderWindow_pollEvent,{renderWindow,event})
end function

public constant xsfRenderWindow_waitEvent = define_c_func(gfx,"+sfRenderWindow_waitEvent",{C_POINTER,sfTime,C_POINTER},C_BOOL)

public function sfRenderWindow_waitEvent(atom renderWindow,sequence timeout,atom event)
	return c_func(xsfRenderWindow_waitEvent,{renderWindow,timeout,event})
end function

public constant xsfRenderWindow_getPosition = define_c_func(gfx,"+sfRenderWindow_getPosition",{C_POINTER},sfVector2i)

public function sfRenderWindow_getPosition(atom renderWindow)
	return c_func(xsfRenderWindow_getPosition,{renderWindow})
end function

public constant xsfRenderWindow_setPosition = define_c_proc(gfx,"+sfRenderWindow_setPosition",{C_POINTER,sfVector2i})

public procedure sfRenderWindow_setPosition(atom renderWindow,sequence pos)
	c_proc(xsfRenderWindow_setPosition,{renderWindow,pos})
end procedure

public constant xsfRenderWindow_getSize = define_c_func(gfx,"+sfRenderWindow_getSize",{C_POINTER},sfVector2u)

public function sfRenderWindow_getSize(atom renderWindow)
	return c_func(xsfRenderWindow_getSize,{renderWindow})
end function

public constant xsfRenderWindow_isSrgb = define_c_func(gfx,"+sfRenderWindow_isSrgb",{C_POINTER},C_BOOL)

public function sfRenderWindow_isSrgb(atom renderWindow)
	return c_func(xsfRenderWindow_isSrgb,{renderWindow})
end function

public constant xsfRenderWindow_setSize = define_c_proc(gfx,"+sfRenderWindow_setSize",{C_POINTER,sfVector2u})

public procedure sfRenderWindow_setSize(atom renderWindow,sequence size)
	c_proc(xsfRenderWindow_setSize,{renderWindow,size})
end procedure

public constant xsfRenderWindow_setMinimumSize = define_c_proc(gfx,"+sfRenderWindow_setMinimumSize",{C_POINTER,C_POINTER})

public procedure sfRenderWindow_setMinimumSize(atom renderWindow,atom minSize)
	c_proc(xsfRenderWindow_setMinimumSize,{renderWindow,minSize})
end procedure

public constant xsfRenderWindow_setMaximumSize = define_c_proc(gfx,"+sfRenderWindow_setMaximumSize",{C_POINTER,C_POINTER})

public procedure sfRenderWindow_setMaximumSize(atom renderWindow,atom maxSize)
	c_proc(xsfRenderWindow_setMaximumSize,{renderWindow,maxSize})
end procedure

public constant xsfRenderWindow_setTitle = define_c_proc(gfx,"+sfRenderWindow_setTitle",{C_POINTER,C_STRING})

public procedure sfRenderWindow_setTitle(atom renderWindow,sequence title)
	c_proc(xsfRenderWindow_setTitle,{renderWindow,title})
end procedure

public constant xsfRenderWindow_setUnicodeTitle = define_c_proc(gfx,"+sfRenderWindow_setUnicodeTitle",{C_POINTER,C_POINTER})

public procedure sfRenderWindow_setUnicodeTitle(atom renderWindow,sequence title)
	atom str = allocate_string(title,1)
	c_proc(xsfRenderWindow_setUnicodeTitle,{renderWindow,str})
end procedure

public constant xsfRenderWindow_setIcon = define_c_proc(gfx,"+sfRenderWindow_setIcon",{C_POINTER,sfVector2u,C_POINTER})

public procedure sfRenderWindow_setIcon(atom renderWindow,sequence size,atom pixels)
	c_proc(xsfRenderWindow_setIcon,{renderWindow,size,pixels})
end procedure

public constant xsfRenderWindow_setVisible = define_c_proc(gfx,"+sfRenderWindow_setVisible",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setVisible(atom renderWindow,atom visible)
	c_proc(xsfRenderWindow_setVisible,{renderWindow,visible})
end procedure

public constant xsfRenderWindow_setVerticalSyncEnabled = define_c_proc(gfx,"+sfRenderWindow_setVerticalSyncEnabled",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setVerticalSyncEnabled(atom renderWindow,atom enabled)
	c_proc(xsfRenderWindow_setVerticalSyncEnabled,{renderWindow,enabled})
end procedure

public constant xsfRenderWindow_setMouseCursorVisible = define_c_proc(gfx,"+sfRenderWindow_setMouseCursorVisible",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setMouseCursorVisible(atom renderWindow,atom show)
	c_proc(xsfRenderWindow_setMouseCursorVisible,{renderWindow,show})
end procedure

public constant xsfRenderWindow_setMouseCursorGrabbed = define_c_proc(gfx,"+sfRenderWindow_setMouseCursorGrabbed",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setMouseCursorGrabbed(atom renderWindow,atom grabbed)
	c_proc(xsfRenderWindow_setMouseCursorGrabbed,{renderWindow,grabbed})
end procedure

public constant xsfRenderWindow_setMouseCursor = define_c_proc(gfx,"+sfRenderWindow_setMouseCursor",{C_POINTER,C_POINTER})

public procedure sfRenderWindow_setMouseCursor(atom renderWindow,atom cursor)
	c_proc(xsfRenderWindow_setMouseCursor,{renderWindow,cursor})
end procedure

public constant xsfRenderWindow_setKeyRepeatEnabled = define_c_proc(gfx,"+sfRenderWindow_setKeyRepeatEnabled",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setKeyRepeatEnabled(atom renderWindow,atom enabled)
	c_proc(xsfRenderWindow_setKeyRepeatEnabled,{renderWindow,enabled})
end procedure

public constant xsfRenderWindow_setFramerateLimit = define_c_proc(gfx,"+sfRenderWindow_setFramerateLimit",{C_POINTER,C_UINT})

public procedure sfRenderWindow_setFramerateLimit(atom renderWindow,atom limit)
	c_proc(xsfRenderWindow_setFramerateLimit,{renderWindow,limit})
end procedure

public constant xsfRenderWindow_setJoystickThreshold = define_c_proc(gfx,"+sfRenderWindow_setJoystickThreshold",{C_POINTER,C_FLOAT})

public procedure sfRenderWindow_setJoystickThreshold(atom renderWindow,atom threshold)
	c_proc(xsfRenderWindow_setJoystickThreshold,{renderWindow,threshold})
end procedure

public constant xsfRenderWindow_setActive = define_c_func(gfx,"+sfRenderWindow_setActive",{C_POINTER,C_BOOL},C_BOOL)

public function sfRenderWindow_setActive(atom renderWindow,atom active)
	return c_func(xsfRenderWindow_setActive,{renderWindow,active})
end function

public constant xsfRenderWindow_requestFocus = define_c_proc(gfx,"+sfRenderWindow_requestFocus",{C_POINTER})

public procedure sfRenderWindow_requestFocus(atom renderWindow)
	c_proc(xsfRenderWindow_requestFocus,{renderWindow})
end procedure

public constant xsfRenderWindow_hasFocus = define_c_func(gfx,"+sfRenderWindow_hasFocus",{C_POINTER},C_BOOL)

public function sfRenderWindow_hasFocus(atom renderWindow)
	return c_func(xsfRenderWindow_hasFocus,{renderWindow})
end function

public constant xsfRenderWindow_display = define_c_proc(gfx,"+sfRenderWindow_display",{C_POINTER})

public procedure sfRenderWindow_display(atom renderWindow)
	c_proc(xsfRenderWindow_display,{renderWindow})
end procedure

public constant xsfRenderWindow_getNativeHandle = define_c_func(gfx,"+sfRenderWindow_getNativeHandle",{C_POINTER},C_POINTER)

public function sfRenderWindow_getNativeHandle(atom renderWindow)
	return c_func(xsfRenderWindow_getNativeHandle,{renderWindow})
end function

public constant xsfRenderWindow_clear = define_c_proc(gfx,"+sfRenderWindow_clear",{C_POINTER,sfColor})

public procedure sfRenderWindow_clear(atom renderWindow,sequence color)
	c_proc(xsfRenderWindow_clear,{renderWindow,color})
end procedure

public constant xsfRenderWindow_clearStencil = define_c_proc(gfx,"+sfRenderWindow_clearStencil",{C_POINTER,sfStencilValue})

public procedure sfRenderWindow_clearStencil(atom renderWindow,sequence stencil)
	c_proc(xsfRenderWindow_clearStencil,{renderWindow,stencil})
end procedure

public constant xsfRenderWindow_clearColorAndStencil = define_c_proc(gfx,"+sfRenderWindow_clearColorAndStencil",{C_POINTER,sfColor,sfStencilValue})

public procedure sfRenderWindow_clearColorAndStencil(atom renderWindow,sequence color,sequence stencil)
	c_proc(xsfRenderWindow_clearColorAndStencil,{renderWindow,color,stencil})
end procedure

public constant xsfRenderWindow_setView = define_c_proc(gfx,"+sfRenderWindow_setView",{C_POINTER,C_POINTER})

public procedure sfRenderWindow_setView(atom renderWindow,atom view)
	c_proc(xsfRenderWindow_setView,{renderWindow,view})
end procedure

public constant xsfRenderWindow_getView = define_c_func(gfx,"+sfRenderWindow_getView",{C_POINTER},C_POINTER)

public function sfRenderWindow_getView(atom renderWindow)
	return c_func(xsfRenderWindow_getView,{renderWindow})
end function

public constant xsfRenderWindow_getDefaultView = define_c_func(gfx,"+sfRenderWindow_getDefaultView",{C_POINTER},C_POINTER)

public function sfRenderWindow_getDefaultView(atom renderWindow)
	return c_func(xsfRenderWindow_getDefaultView,{renderWindow})
end function

public constant xsfRenderWindow_getViewport = define_c_func(gfx,"+sfRenderWindow_getViewport",{C_POINTER,C_POINTER},sfIntRect)

public function sfRenderWindow_getViewport(atom renderWindow,atom view)
	return c_func(xsfRenderWindow_getViewport,{renderWindow,view})
end function

public constant xsfRenderWindow_getScissor = define_c_func(gfx,"+sfRenderWindow_getScissor",{C_POINTER,C_POINTER},sfIntRect)

public function sfRenderWindow_getScissor(atom renderWindow,atom view)
	return c_func(xsfRenderWindow_getScissor,{renderWindow,view})
end function

public constant xsfRenderWindow_mapPixelToCoords = define_c_func(gfx,"+sfRenderWindow_mapPixelToCoords",{C_POINTER,sfVector2i,C_POINTER},sfVector2f)

public function sfRenderWindow_mapPixelToCoords(atom renderWindow,sequence point,atom view)
	return c_func(xsfRenderWindow_mapPixelToCoords,{renderWindow,point,view})
end function

public constant xsfRenderWindow_mapCoordsToPixel = define_c_func(gfx,"+sfRenderWindow_mapCoordsToPixel",{C_POINTER,sfVector2f,C_POINTER},sfVector2i)

public function sfRenderWindow_mapCoordsToPixel(atom renderWindow,sequence point,atom view)
	return c_func(xsfRenderWindow_mapCoordsToPixel,{renderWindow,point,view})
end function

public constant xsfRenderWindow_drawSprite = define_c_proc(gfx,"+sfRenderWindow_drawSprite",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderWindow_drawSprite(atom renderWindow,atom sprite,atom state)
	c_proc(xsfRenderWindow_drawSprite,{renderWindow,sprite,state})
end procedure

public constant xsfRenderWindow_drawText = define_c_proc(gfx,"+sfRenderWindow_drawText",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderWindow_drawText(atom renderWindow,atom text,atom state)
	c_proc(xsfRenderWindow_drawText,{renderWindow,text,state})
end procedure

public constant xsfRenderWindow_drawShape = define_c_proc(gfx,"+sfRenderWindow_drawShape",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderWindow_drawShape(atom renderWindow,atom shape,atom state)
	c_proc(xsfRenderWindow_drawShape,{renderWindow,shape,state})
end procedure

public constant xsfRenderWindow_drawCircleShape = define_c_proc(gfx,"+sfRenderWindow_drawCircleShape",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderWindow_drawCircleShape(atom renderWindow,atom shape,atom state)
	c_proc(xsfRenderWindow_drawCircleShape,{renderWindow,shape,state})
end procedure

public constant xsfRenderWindow_drawConvexShape = define_c_proc(gfx,"+sfRenderWindow_drawConvexShape",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderWindow_drawConvexShape(atom renderWindow,atom shape,atom state)
	c_proc(xsfRenderWindow_drawConvexShape,{renderWindow,shape,state})
end procedure

public constant xsfRenderWindow_drawRectangleShape = define_c_proc(gfx,"+sfRenderWindow_drawRectangleShape",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderWindow_drawRectangleShape(atom renderWindow,atom shape,atom state)
	c_proc(xsfRenderWindow_drawRectangleShape,{renderWindow,shape,state})
end procedure

public constant xsfRenderWindow_drawVertexArray = define_c_proc(gfx,"+sfRenderWindow_drawVertexArray",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderWindow_drawVertexArray(atom renderWindow,atom vertexArray,atom state)
	c_proc(xsfRenderWindow_drawVertexArray,{renderWindow,vertexArray,state})
end procedure

public constant xsfRenderWindow_drawVertexBuffer = define_c_proc(gfx,"+sfRenderWindow_drawVertexBuffer",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderWindow_drawVertexBuffer(atom renderWindow,atom vertexBuffer,atom state)
	c_proc(xsfRenderWindow_drawVertexBuffer,{renderWindow,vertexBuffer,state})
end procedure

public constant xsfRenderWindow_drawVertexBufferRange = define_c_proc(gfx,"+sfRenderWindow_drawVertexBufferRange",{C_POINTER,C_POINTER,C_SIZE_T,C_SIZE_T,C_POINTER})

public procedure sfRenderWindow_drawVertexBufferRange(atom renderWindow,atom vertexBuffer,atom firstVertex,atom count,atom state)
	c_proc(xsfRenderWindow_drawVertexBufferRange,{renderWindow,vertexBuffer,firstVertex,count,state})
end procedure

public constant xsfRenderWindow_drawPrimitives = define_c_proc(gfx,"+sfRenderWindow_drawPrimitives",{C_POINTER,C_POINTER,C_SIZE_T,C_INT,C_POINTER})

public procedure sfRenderWindow_drawPrimitives(atom renderWindow,atom vertices,atom count,sfPrimitiveType ptype,atom state)
	c_proc(xsfRenderWindow_drawPrimitives,{renderWindow,vertices,count,ptype,state})
end procedure

public constant xsfRenderWindow_pushGLStates = define_c_proc(gfx,"+sfRenderWindow_pushGLStates",{C_POINTER})

public procedure sfRenderWindow_pushGLStates(atom renderWindow)
	c_proc(xsfRenderWindow_pushGLStates,{renderWindow})
end procedure

public constant xsfRenderWindow_popGLStates = define_c_proc(gfx,"+sfRenderWindow_popGLStates",{C_POINTER})

public procedure sfRenderWindow_popGLStates(atom renderWindow)
	c_proc(xsfRenderWindow_popGLStates,{renderWindow})
end procedure

public constant xsfRenderWindow_resetGLStates = define_c_proc(gfx,"+sfRenderWindow_resetGLStates",{C_POINTER})

public procedure sfRenderWindow_resetGLStates(atom renderWindow)
	c_proc(xsfRenderWindow_resetGLStates,{renderWindow})
end procedure

public constant xsfMouse_getPositionRenderWindow = define_c_func(gfx,"+sfMouse_getPositionRenderWindow",{C_POINTER},sfVector2i)

public function sfMouse_getPositionRenderWindow(atom relativeTo)
	return c_func(xsfMouse_getPositionRenderWindow,{relativeTo})
end function

public constant xsfMouse_setPositionRenderWindow = define_c_proc(gfx,"+sfMouse_setPositionRenderWindow",{sfVector2i,C_POINTER})

public procedure sfMouse_setPositionRenderWindow(sequence pos,atom relativeTo)
	c_proc(xsfMouse_setPositionRenderWindow,{pos,relativeTo})
end procedure

public constant xsfTouch_getPositionRenderWindow = define_c_func(gfx,"+sfTouch_getPositionRenderWindow",{C_UINT,C_POINTER},sfVector2i)

public function sfTouch_getPositionRenderWindow(atom finger,atom relativeTo)
	return c_func(xsfTouch_getPositionRenderWindow,{finger,relativeTo})
end function

public constant xsfRenderWindow_createVulkanSurface = define_c_func(gfx,"+sfRenderWindow_createVulkanSurface",{C_POINTER,C_POINTER,C_POINTER,C_POINTER},C_BOOL)

public function sfRenderWindow_createVulkanSurface(atom renderWindow,atom xinstance,atom surface,atom allocator)
	return c_func(xsfRenderWindow_createVulkanSurface,{renderWindow,xinstance,surface,allocator})
end function

--CircleShape
public constant xsfCircleShape_create = define_c_func(gfx,"+sfCircleShape_create",{},C_POINTER)

public function sfCircleShape_create()
	return c_func(xsfCircleShape_create,{})
end function

public constant xsfCircleShape_copy = define_c_proc(gfx,"+sfCircleShape_copy",{C_POINTER})

public procedure sfCircleShape_copy(atom shape)
	c_proc(xsfCircleShape_copy,{shape})
end procedure

public constant xsfCircleShape_destroy = define_c_proc(gfx,"+sfCircleShape_destroy",{C_POINTER})

public procedure sfCircleShape_destroy(atom shape)
	c_proc(xsfCircleShape_destroy,{shape})
end procedure

public constant xsfCircleShape_setPosition = define_c_proc(gfx,"+sfCircleShape_setPosition",{C_POINTER,sfVector2f})

public procedure sfCircleShape_setPosition(atom shape,sequence pos)
	c_proc(xsfCircleShape_setPosition,{shape,pos})
end procedure

public constant xsfCircleShape_setRotation = define_c_proc(gfx,"+sfCircleShape_setRotation",{C_POINTER,C_FLOAT})

public procedure sfCircleShape_setRotation(atom shape,atom angle)
	c_proc(xsfCircleShape_setRotation,{shape,angle})
end procedure

public constant xsfCircleShape_setScale = define_c_proc(gfx,"+sfCircleShape_setScale",{C_POINTER,sfVector2f})

public procedure sfCircleShape_setScale(atom shape,sequence scale)
	c_proc(xsfCircleShape_setScale,{shape,scale})
end procedure

public constant xsfCircleShape_setOrigin = define_c_proc(gfx,"+sfCircleShape_setOrigin",{C_POINTER,sfVector2f})

public procedure sfCircleShape_setOrigin(atom shape,sequence origin)
	c_proc(xsfCircleShape_setOrigin,{shape,origin})
end procedure

public constant xsfCircleShape_getPosition = define_c_func(gfx,"+sfCircleShape_getPosition",{C_POINTER},sfVector2f)

public function sfCircleShape_getPosition(atom shape)
	return c_func(xsfCircleShape_getPosition,{shape})
end function

public constant xsfCircleShape_getRotation = define_c_func(gfx,"+sfCircleShape_getRotation",{C_POINTER},C_FLOAT)

public function sfCircleShape_getRotation(atom shape)
	return c_func(xsfCircleShape_getRotation,{shape})
end function

public constant xsfCircleShape_getScale = define_c_func(gfx,"+sfCircleShape_getScale",{C_POINTER},sfVector2f)

public function sfCircleShape_getScale(atom shape)
	return c_func(xsfCircleShape_getScale,{shape})
end function

public constant xsfCircleShape_getOrigin = define_c_func(gfx,"+sfCircleShape_getOrigin",{C_POINTER},sfVector2f)

public function sfCircleShape_getOrigin(atom shape)
	return c_func(xsfCircleShape_getOrigin,{shape})
end function

public constant xsfCircleShape_move = define_c_proc(gfx,"+sfCircleShape_move",{C_POINTER,sfVector2f})

public procedure sfCircleShape_move(atom shape,sequence offset)
	c_proc(xsfCircleShape_move,{shape,offset})
end procedure

public constant xsfCircleShape_rotate = define_c_proc(gfx,"+sfCircleShape_rotate",{C_POINTER,C_FLOAT})

public procedure sfCircleShape_rotate(atom shape,atom angle)
	c_proc(xsfCircleShape_rotate,{shape,angle})
end procedure

public constant xsfCircleShape_scale = define_c_proc(gfx,"+sfCircleShape_scale",{C_POINTER,sfVector2f})

public procedure sfCircleShape_scale(atom shape,sequence factors)
	c_proc(xsfCircleShape_scale,{shape,factors})
end procedure

public constant xsfCircleShape_getTransform = define_c_func(gfx,"+sfCircleShape_getTransform",{C_POINTER},sfTransform)

public function sfCircleShape_getTransform(atom shape)
	return c_func(xsfCircleShape_getTransform,{shape})
end function

public constant xsfCircleShape_getInverseTransform = define_c_func(gfx,"+sfCircleShape_getInverseTransform",{C_POINTER},sfTransform)

public function sfCircleShape_getInverseTransform(atom shape)
	return c_func(xsfCircleShape_getInverseTransform,{shape})
end function

public constant xsfCircleShape_setTexture = define_c_proc(gfx,"+sfCircleShape_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfCircleShape_setTexture(atom shape,atom texture,atom resetRect)
	c_proc(xsfCircleShape_setTexture,{shape,texture,resetRect})
end procedure

public constant xsfCircleShape_setTextureRect = define_c_proc(gfx,"+sfCircleShape_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfCircleShape_setTextureRect(atom shape,sequence rect)
	c_proc(xsfCircleShape_setTextureRect,{shape,rect})
end procedure

public constant xsfCircleShape_setFillColor = define_c_proc(gfx,"+sfCircleShape_setFillColor",{C_POINTER,sfColor})

public procedure sfCircleShape_setFillColor(atom shape,sequence color)
	c_proc(xsfCircleShape_setFillColor,{shape,color})
end procedure

public constant xsfCircleShape_setOutlineColor = define_c_proc(gfx,"+sfCircleShape_setOutlineColor",{C_POINTER,sfColor})

public procedure sfCircleShape_setOutlineColor(atom shape,sequence color)
	c_proc(xsfCircleShape_setOutlineColor,{shape,color})
end procedure

public constant xsfCircleShape_setOutlineThickness = define_c_proc(gfx,"+sfCircleShape_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfCircleShape_setOutlineThickness(atom shape,atom thick)
	c_proc(xsfCircleShape_setOutlineThickness,{shape,thick})
end procedure

public constant xsfCircleShape_getTexture = define_c_func(gfx,"+sfCircleShape_getTexture",{C_POINTER},C_POINTER)

public function sfCircleShape_getTexture(atom shape)
	return c_func(xsfCircleShape_getTexture,{shape})
end function

public constant xsfCircleShape_getTextureRect = define_c_func(gfx,"+sfCircleShape_getTextureRect",{C_POINTER},sfIntRect)

public function sfCircleShape_getTextureRect(atom shape)
	return c_func(xsfCircleShape_getTextureRect,{shape})
end function

public constant xsfCircleShape_getFillColor = define_c_func(gfx,"+sfCircleShape_getFillColor",{C_POINTER},sfColor)

public function sfCircleShape_getFillColor(atom shape)
	return c_func(xsfCircleShape_getFillColor,{shape})
end function

public constant xsfCircleShape_getOutlineColor = define_c_func(gfx,"+sfCircleShape_getOutlineColor",{C_POINTER},sfColor)

public function sfCircleShape_getOutlineColor(atom shape)
	return c_func(xsfCircleShape_getOutlineColor,{shape})
end function

public constant xsfCircleShape_getOutlineThickness = define_c_func(gfx,"+sfCircleShape_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfCircleShape_getOutlineThickness(atom shape)
	return c_func(xsfCircleShape_getOutlineThickness,{shape})
end function

public constant xsfCircleShape_getPointCount = define_c_func(gfx,"+sfCircleShape_getPointCount",{C_POINTER},C_SIZE_T)

public function sfCircleShape_getPointCount(atom shape)
	return c_func(xsfCircleShape_getPointCount,{shape})
end function

public constant xsfCircleShape_getPoint = define_c_func(gfx,"+sfCircleShape_getPoint",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfCircleShape_getPoint(atom shape,atom index)
	return c_func(xsfCircleShape_getPoint,{shape,index})
end function

public constant xsfCircleShape_getGeometricCenter = define_c_func(gfx,"+sfCircleShape_getGeometricCenter",{C_POINTER},sfVector2f)

public function sfCircleShape_getGeometricCenter(atom shape)
	return c_func(xsfCircleShape_getGeometricCenter,{shape})
end function

public constant xsfCircleShape_setRadius = define_c_proc(gfx,"+sfCircleShape_setRadius",{C_POINTER,C_FLOAT})

public procedure sfCircleShape_setRadius(atom shape,atom radius)
	c_proc(xsfCircleShape_setRadius,{shape,radius})
end procedure

public constant xsfCircleShape_getRadius = define_c_func(gfx,"+sfCircleShape_getRadius",{C_POINTER},C_FLOAT)

public function sfCircleShape_getRadius(atom shape)
	return c_func(xsfCircleShape_getRadius,{shape})
end function

public constant xsfCircleShape_setPointCount = define_c_proc(gfx,"+sfCircleShape_setPointCount",{C_POINTER,C_SIZE_T})

public procedure sfCircleShape_setPointCount(atom shape,atom count)
	c_proc(xsfCircleShape_setPointCount,{shape,count})
end procedure

public constant xsfCircleShape_getLocalBounds = define_c_func(gfx,"+sfCircleShape_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfCircleShape_getLocalBounds(atom shape)
	return c_func(xsfCircleShape_getLocalBounds,{shape})
end function

public constant xsfCircleShape_getGlobalBounds = define_c_func(gfx,"+sfCircleShape_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfCircleShape_getGlobalBounds(atom shape)
	return c_func(xsfCircleShape_getGlobalBounds,{shape})
end function

--Convexshape

public constant xsfConvexShape_create = define_c_func(gfx,"+sfConvexShape_create",{},C_POINTER)

public function sfConvexShape_create()
	return c_func(xsfConvexShape_create,{})
end function

public constant xsfConvexShape_copy = define_c_func(gfx,"+sfConvexShape_copy",{C_POINTER},C_POINTER)

public function sfConvexShape_copy(atom shape)
	return c_func(xsfConvexShape_copy,{shape})
end function

public constant xsfConvexShape_destroy = define_c_proc(gfx,"+sfConvexShape_destroy",{C_POINTER})

public procedure sfConvexShape_destroy(atom shape)
	c_proc(xsfConvexShape_destroy,{shape})
end procedure

public constant xsfConvexShape_setPosition = define_c_proc(gfx,"+sfConvexShape_setPosition",{C_POINTER,sfVector2f})

public procedure sfConvexShape_setPosition(atom shape,sequence pos)
	c_proc(xsfConvexShape_setPosition,{shape,pos})
end procedure

public constant xsfConvexShape_setRotation = define_c_proc(gfx,"+sfConvexShape_setRotation",{C_POINTER,C_FLOAT})

public procedure sfConvexShape_setRotation(atom shape,atom angle)
	c_proc(xsfConvexShape_setRotation,{shape,angle})
end procedure

public constant xsfConvexShape_setScale = define_c_proc(gfx,"+sfConvexShape_setScale",{C_POINTER,sfVector2f})

public procedure sfConvexShape_setScale(atom shape,sequence scale)
	c_proc(xsfConvexShape_setScale,{shape,scale})
end procedure

public constant xsfConvexShape_setOrigin = define_c_proc(gfx,"+sfConvexShape_setOrigin",{C_POINTER,sfVector2f})

public procedure sfConvexShape_setOrigin(atom shape,sequence origin)
	c_proc(xsfConvexShape_setOrigin,{shape,origin})
end procedure

public constant xsfConvexShape_getPosition = define_c_func(gfx,"+sfConvexShape_getPosition",{C_POINTER},sfVector2f)

public function sfConvexShape_getPosition(atom shape)
	return c_func(xsfConvexShape_getPosition,{shape})
end function

public constant xsfConvexShape_getRotation = define_c_func(gfx,"+sfConvexShape_getRotation",{C_POINTER},C_FLOAT)

public function sfConvexShape_getRotation(atom shape)
	return c_func(xsfConvexShape_getRotation,{shape})
end function

public constant xsfConvexShape_getScale = define_c_func(gfx,"+sfConvexShape_getScale",{C_POINTER},sfVector2f)

public function sfConvexShape_getScale(atom shape)
	return c_func(xsfConvexShape_getScale,{shape})
end function

public constant xsfConvexShape_getOrigin = define_c_func(gfx,"+sfConvexShape_getOrigin",{C_POINTER},sfVector2f)

public function sfConvexShape_getOrigin(atom shape)
	return c_func(xsfConvexShape_getOrigin,{shape})
end function

public constant xsfConvexShape_move = define_c_proc(gfx,"+sfConvexShape_move",{C_POINTER,sfVector2f})

public procedure sfConvexShape_move(atom shape,sequence offset)
	c_proc(xsfConvexShape_move,{shape,offset})
end procedure

public constant xsfConvexShape_rotate = define_c_proc(gfx,"+sfConvexShape_rotate",{C_POINTER,C_FLOAT})

public procedure sfConvexShape_rotate(atom shape,atom angle)
	c_proc(xsfConvexShape_rotate,{shape,angle})
end procedure

public constant xsfConvexShape_scale = define_c_proc(gfx,"+sfConvexShape_scale",{C_POINTER,sfVector2f})

public procedure sfConvexShape_scale(atom shape,sequence factors)
	c_proc(xsfConvexShape_scale,{shape,factors})
end procedure

public constant xsfConvexShape_getTransform = define_c_func(gfx,"+sfConvexShape_getTransform",{C_POINTER},sfTransform)

public function sfConvexShape_getTransform(atom shape)
	return c_func(xsfConvexShape_getTransform,{shape})
end function

public constant xsfConvexShape_getInverseTransform = define_c_func(gfx,"+sfConvexShape_getInverseTransform",{C_POINTER},sfTransform)

public function sfConvexShape_getInverseTransform(atom shape)
	return c_func(xsfConvexShape_getInverseTransform,{shape})
end function

public constant xsfConvexShape_setTexture = define_c_proc(gfx,"+sfConvexShape_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfConvexShape_setTexture(atom shape,atom texture,atom resetRect)
	c_proc(xsfConvexShape_setTexture,{shape,texture,resetRect})
end procedure

public constant xsfConvexShape_setTextureRect = define_c_proc(gfx,"+sfConvexShape_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfConvexShape_setTextureRect(atom shape,sequence rect)
	c_proc(xsfConvexShape_setTextureRect,{shape,rect})
end procedure

public constant xsfConvexShape_setFillColor = define_c_proc(gfx,"+sfConvexShape_setFillColor",{C_POINTER,sfColor})

public procedure sfConvexShape_setFillColor(atom shape,sequence color)
	c_proc(xsfConvexShape_setFillColor,{shape,color})
end procedure

public constant xsfConvexShape_setOutlineColor = define_c_proc(gfx,"+sfConvexShape_setOutlineColor",{C_POINTER,sfColor})

public procedure sfConvexShape_setOutlineColor(atom shape,sequence color)
	c_proc(xsfConvexShape_setOutlineColor,{shape,color})
end procedure

public constant xsfConvexShape_setOutlineThickness = define_c_proc(gfx,"+sfConvexShape_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfConvexShape_setOutlineThickness(atom shape,atom thick)
	c_proc(xsfConvexShape_setOutlineThickness,{shape,thick})
end procedure

public constant xsfConvexShape_getTexture = define_c_func(gfx,"+sfConvexShape_getTexture",{C_POINTER},C_POINTER)

public function sfConvexShape_getTexture(atom shape)
	return c_func(xsfConvexShape_getTexture,{shape})
end function

public constant xsfConvexShape_getTextureRect = define_c_func(gfx,"+sfConvexShape_getTextureRect",{C_POINTER},sfIntRect)

public function sfConvexShape_getTextureRect(atom shape)
	return c_func(xsfConvexShape_getTextureRect,{shape})
end function

public constant xsfConvexShape_getFillColor = define_c_func(gfx,"+sfConvexShape_getFillColor",{C_POINTER},sfColor)

public function sfConvexShape_getFillColor(atom shape)
	return c_func(xsfConvexShape_getFillColor,{shape})
end function

public constant xsfConvexShape_getOutlineColor = define_c_func(gfx,"+sfConvexShape_getOutlineColor",{C_POINTER},sfColor)

public function sfConvexShape_getOutlineColor(atom shape)
	return c_func(xsfConvexShape_getOutlineColor,{shape})
end function

public constant xsfConvexShape_getOutlineThickness = define_c_func(gfx,"+sfConvexShape_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfConvexShape_getOutlineThickness(atom shape)
	return c_func(xsfConvexShape_getOutlineThickness,{shape})
end function

public constant xsfConvexShape_getPointCount = define_c_func(gfx,"+sfConvexShape_getPointCount",{C_POINTER},C_SIZE_T)

public function sfConvexShape_getPointCount(atom shape)
	return c_func(xsfConvexShape_getPointCount,{shape})
end function

public constant xsfConvexShape_getPoint = define_c_func(gfx,"+sfConvexShape_getPoint",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfConvexShape_getPoint(atom shape,atom index)
	return c_func(xsfConvexShape_getPoint,{shape,index})
end function

public constant xsfConvexShape_getGeometricCenter = define_c_func(gfx,"+sfConvexShape_getGeometricCenter",{C_POINTER},sfVector2f)

public function sfConvexShape_getGeometricCenter(atom shape)
	return c_func(xsfConvexShape_getGeometricCenter,{shape})
end function

public constant xsfConvexShape_setPointCount = define_c_proc(gfx,"+sfConvexShape_setPointCount",{C_POINTER,C_SIZE_T})

public procedure sfConvexShape_setPointCount(atom shape,atom count)
	c_proc(xsfConvexShape_setPointCount,{shape,count})
end procedure

public constant xsfConvexShape_setPoint = define_c_proc(gfx,"+sfConvexShape_setPoint",{C_POINTER,C_SIZE_T,sfVector2f})

public procedure sfConvexShape_setPoint(atom shape,atom index,sequence point)
	c_proc(xsfConvexShape_setPoint,{shape,index,point})
end procedure

public constant xsfConvexShape_getLocalBounds = define_c_func(gfx,"+sfConvexShape_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfConvexShape_getLocalBounds(atom shape)
	return c_func(xsfConvexShape_getLocalBounds,{shape})
end function

public constant xsfConvexShape_getGlobalBounds = define_c_func(gfx,"+sfConvexShape_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfConvexShape_getGlobalBounds(atom shape)
	return c_func(xsfConvexShape_getGlobalBounds,{shape})
end function

--Image

public constant xsfImage_create = define_c_func(gfx,"+sfImage_create",{sfVector2u},C_POINTER)

public function sfImage_create(sequence size)
	return c_func(xsfImage_create,{size})
end function

public constant xsfImage_createFromColor = define_c_func(gfx,"+sfImage_createFromColor",{sfVector2u,sfColor},C_POINTER)

public function sfImage_createFromColor(sequence size,sequence color)
	return c_func(xsfImage_createFromColor,{size,color})
end function

public constant xsfImage_createFromPixels = define_c_func(gfx,"+sfImage_createFromPixels",{sfVector2u,C_POINTER},C_POINTER)

public function sfImage_createFromPixels(sequence size,atom pixels)
	return c_func(xsfImage_createFromPixels,{size,pixels})
end function

public constant xsfImage_createFromFile = define_c_func(gfx,"+sfImage_createFromFile",{C_STRING},C_POINTER)

public function sfImage_createFromFile(sequence fname)
	return c_func(xsfImage_createFromFile,{fname})
end function

public constant xsfImage_createFromMemory = define_c_func(gfx,"+sfImage_createFromMemory",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfImage_createFromMemory(atom data,atom size)
	return c_func(xsfImage_createFromMemory,{data,size})
end function

public constant xsfImage_createFromStream = define_c_func(gfx,"+sfImage_createFromStream",{C_POINTER},C_POINTER)

public function sfImage_createFromStream(atom stream)
	return c_func(xsfImage_createFromStream,{stream})
end function

public constant xsfImage_copy = define_c_func(gfx,"+sfImage_copy",{C_POINTER},C_POINTER)

public function sfImage_copy(atom image)
	return c_func(xsfImage_copy,{image})
end function

public constant xsfImage_destroy = define_c_proc(gfx,"+sfImage_destroy",{C_POINTER})

public procedure sfImage_destroy(atom image)
	c_proc(xsfImage_destroy,{image})
end procedure

public constant xsfImage_saveToFile = define_c_func(gfx,"+sfImage_saveToFile",{C_POINTER,C_STRING},C_BOOL)

public function sfImage_saveToFile(atom image,sequence fname)
	return c_func(xsfImage_saveToFile,{image,fname})
end function

public constant xsfImage_saveToMemory = define_c_func(gfx,"+sfImage_saveToMemory",{C_POINTER,C_POINTER,C_STRING},C_BOOL)

public function sfImage_saveToMemory(atom image,atom output,sequence format)
	return c_func(xsfImage_saveToMemory,{image,output,format})
end function

public constant xsfImage_getSize = define_c_func(gfx,"+sfImage_getSize",{C_POINTER},sfVector2u)

public function sfImage_getSize(atom image)
	return c_func(xsfImage_getSize,{image})
end function

public constant xsfImage_createMaskFromColor = define_c_proc(gfx,"+sfImage_createMaskFromColor",{C_POINTER,sfColor,C_UINT8})

public procedure sfImage_createMaskFromColor(atom image,sequence color,atom alpha)
	c_proc(xsfImage_createMaskFromColor,{image,color,alpha})
end procedure

public constant xsfImage_copyImage = define_c_func(gfx,"+sfImage_copyImage",{C_POINTER,C_POINTER,sfVector2u,sfIntRect,C_BOOL},C_BOOL)

public function sfImage_copyImage(atom image,atom source,sequence dest,sequence sourceRect,atom applyAlpha)
	return c_func(xsfImage_copyImage,{image,source,dest,sourceRect,applyAlpha})
end function

public constant xsfImage_setPixel = define_c_proc(gfx,"+sfImage_setPixel",{C_POINTER,sfVector2u,sfColor})

public procedure sfImage_setPixel(atom image,sequence coords,sequence color)
	c_proc(xsfImage_setPixel,{image,coords,color})
end procedure

public constant xsfImage_getPixel = define_c_func(gfx,"+sfImage_getPixel",{C_POINTER,sfVector2u},sfColor)

public function sfImage_getPixel(atom image,sequence coords)
	return c_func(xsfImage_getPixel,{image,coords})
end function

public constant xsfImage_getPixelsPtr = define_c_func(gfx,"+sfImage_getPixelsPtr",{C_POINTER},C_POINTER)

public function sfImage_getPixelsPtr(atom image)
	return c_func(xsfImage_getPixelsPtr,{image})
end function

public constant xsfImage_flipHorizontally = define_c_proc(gfx,"+sfImage_flipHorizontally",{C_POINTER})

public procedure sfImage_flipHorizontally(atom image)
	c_proc(xsfImage_flipHorizontally,{image})
end procedure

public constant xsfImage_flipVertically = define_c_proc(gfx,"+sfImage_flipVertically",{C_POINTER})

public procedure sfImage_flipVertically(atom image)
	c_proc(xsfImage_flipVertically,{image})
end procedure

--Rectangle

public constant xsfRectangleShape_create = define_c_func(gfx,"+sfRectangleShape_create",{},C_POINTER)

public function sfRectangleShape_create()
	return c_func(xsfRectangleShape_create,{})
end function

public constant xsfRectangleShape_copy = define_c_func(gfx,"+sfRectangleShape_copy",{C_POINTER},C_POINTER)

public function sfRectangleShape_copy(atom shape)
	return c_func(xsfRectangleShape_copy,{shape})
end function

public constant xsfRectangleShape_destroy = define_c_proc(gfx,"+sfRectangleShape_destroy",{C_POINTER})

public procedure sfRectangleShape_destroy(atom shape)
	c_proc(xsfRectangleShape_destroy,{shape})
end procedure

public constant xsfRectangleShape_setPosition = define_c_proc(gfx,"+sfRectangleShape_setPosition",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_setPosition(atom shape,sequence pos)
	c_proc(xsfRectangleShape_setPosition,{shape,pos})
end procedure

public constant xsfRectangleShape_setRotation = define_c_proc(gfx,"+sfRectangleShape_setRotation",{C_POINTER,C_FLOAT})

public procedure sfRectangleShape_setRotation(atom shape,atom angle)
	c_proc(xsfRectangleShape_setRotation,{shape,angle})
end procedure

public constant xsfRectangleShape_setScale = define_c_proc(gfx,"+sfRectangleShape_setScale",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_setScale(atom shape,sequence scale)
	c_proc(xsfRectangleShape_setScale,{shape,scale})
end procedure

public constant xsfRectangleShape_setOrigin = define_c_proc(gfx,"+sfRectangleShape_setOrigin",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_setOrigin(atom shape,sequence origin)
	c_proc(xsfRectangleShape_setOrigin,{shape,origin})
end procedure

public constant xsfRectangleShape_getPosition = define_c_func(gfx,"+sfRectangleShape_getPosition",{C_POINTER},sfVector2f)

public function sfRectangleShape_getPosition(atom shape)
	return c_func(xsfRectangleShape_getPosition,{shape})
end function

public constant xsfRectangleShape_getRotation = define_c_func(gfx,"+sfRectangleShape_getRotation",{C_POINTER},C_FLOAT)

public function sfRectangleShape_getRotation(atom shape)
	return c_func(xsfRectangleShape_getRotation,{shape})
end function

public constant xsfRectangleShape_getScale = define_c_func(gfx,"+sfRectangleShape_getScale",{C_POINTER},sfVector2f)

public function sfRectangleShape_getScale(atom shape)
	return c_func(xsfRectangleShape_getScale,{shape})
end function

public constant xsfRectangleShape_getOrigin = define_c_func(gfx,"+sfRectangleShape_getOrigin",{C_POINTER},sfVector2f)

public function sfRectangleShape_getOrigin(atom shape)
	return c_func(xsfRectangleShape_getOrigin,{shape})
end function

public constant xsfRectangleShape_move = define_c_proc(gfx,"+sfRectangleShape_move",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_move(atom shape,sequence offset)
	c_proc(xsfRectangleShape_move,{shape,offset})
end procedure

public constant xsfRectangleShape_rotate = define_c_proc(gfx,"+sfRectangleShape_rotate",{C_POINTER,C_FLOAT})

public procedure sfRectangleShape_rotate(atom shape,atom angle)
	c_proc(xsfRectangleShape_rotate,{shape,angle})
end procedure

public constant xsfRectangleShape_scale = define_c_proc(gfx,"+sfRectangleShape_scale",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_scale(atom shape,sequence factors)
	c_proc(xsfRectangleShape_scale,{shape,factors})
end procedure

public constant xsfRectangleShape_getTransform = define_c_func(gfx,"+sfRectangleShape_getTransform",{C_POINTER},sfTransform)

public function sfRectangleShape_getTransform(atom shape)
	return c_func(xsfRectangleShape_getTransform,{shape})
end function

public constant xsfRectangleShape_getInverseTransform = define_c_func(gfx,"+sfRectangleShape_getInverseTransform",{C_POINTER},sfTransform)

public function sfRectangleShape_getInverseTransform(atom shape)
	return c_func(xsfRectangleShape_getInverseTransform,{shape})
end function

public constant xsfRectangleShape_setTexture = define_c_proc(gfx,"+sfRectangleShape_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfRectangleShape_setTexture(atom shape,atom texture,atom resetRect)
	c_proc(xsfRectangleShape_setTexture,{shape,texture,resetRect})
end procedure

public constant xsfRectangleShape_setTextureRect = define_c_proc(gfx,"+sfRectangleShape_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfRectangleShape_setTextureRect(atom shape,sequence rect)
	c_proc(xsfRectangleShape_setTextureRect,{shape,rect})
end procedure

public constant xsfRectangleShape_setFillColor = define_c_proc(gfx,"+sfRectangleShape_setFillColor",{C_POINTER,sfColor})

public procedure sfRectangleShape_setFillColor(atom shape,sequence color)
	c_proc(xsfRectangleShape_setFillColor,{shape,color})
end procedure

public constant xsfRectangleShape_setOutlineColor = define_c_proc(gfx,"+sfRectangleShape_setOutlineColor",{C_POINTER,sfColor})

public procedure sfRectangleShape_setOutlineColor(atom shape,sequence color)
	c_proc(xsfRectangleShape_setOutlineColor,{shape,color})
end procedure

public constant xsfRectangleShape_setOutlineThickness = define_c_proc(gfx,"+sfRectangleShape_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfRectangleShape_setOutlineThickness(atom shape,atom thick)
	c_proc(xsfRectangleShape_setOutlineThickness,{shape,thick})
end procedure

public constant xsfRectangleShape_getTexture = define_c_func(gfx,"+sfRectangleShape_getTexture",{C_POINTER},C_POINTER)

public function sfRectangleShape_getTexture(atom shape)
	return c_func(xsfRectangleShape_getTexture,{shape})
end function

public constant xsfRectangleShape_getTextureRect = define_c_func(gfx,"+sfRectangleShape_getTextureRect",{C_POINTER},sfIntRect)

public function sfRectangleShape_getTextureRect(atom shape)
	return c_func(xsfRectangleShape_getTextureRect,{shape})
end function

public constant xsfRectangleShape_getFillColor = define_c_func(gfx,"+sfRectangleShape_getFillColor",{C_POINTER},sfColor)

public function sfRectangleShape_getFillColor(atom shape)
	return c_func(xsfRectangleShape_getFillColor,{shape})
end function

public constant xsfRectangleShape_getOutlineColor = define_c_func(gfx,"+sfRectangleShape_getOutlineColor",{C_POINTER},sfColor)

public function sfRectangleShape_getOutlineColor(atom shape)
	return c_func(xsfRectangleShape_getOutlineColor,{shape})
end function

public constant xsfRectangleShape_getOutlineThickness = define_c_func(gfx,"+sfRectangleShape_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfRectangleShape_getOutlineThickness(atom shape)
	return c_func(xsfRectangleShape_getOutlineThickness,{shape})
end function

public constant xsfRectangleShape_getPointCount = define_c_func(gfx,"+sfRectangleShape_getPointCount",{C_POINTER},C_SIZE_T)

public function sfRectangleShape_getPointCount(atom shape)
	return c_func(xsfRectangleShape_getPointCount,{shape})
end function

public constant xsfRectangleShape_getPoint = define_c_func(gfx,"+sfRectangleShape_getPoint",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfRectangleShape_getPoint(atom shape,atom index)
	return c_func(xsfRectangleShape_getPoint,{shape,index})
end function

public constant xfRectangleShape_getGeometricCenter = define_c_func(gfx,"+fRectangleShape_getGeometricCenter",{C_POINTER},sfVector2f)

public function fRectangleShape_getGeometricCenter(atom shape)
	return c_func(xfRectangleShape_getGeometricCenter,{shape})
end function

public constant xsfRectangleShape_setSize = define_c_proc(gfx,"+sfRectangleShape_setSize",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_setSize(atom shape,sequence size)
	c_proc(xsfRectangleShape_setSize,{shape,size})
end procedure

public constant xsfRectangleShape_getSize = define_c_func(gfx,"+sfRectangleShape_getSize",{C_POINTER},sfVector2f)

public function sfRectangleShape_getSize(atom shape)
	return c_func(xsfRectangleShape_getSize,{shape})
end function

public constant xsfRectangleShape_getLocalBounds = define_c_func(gfx,"+sfRectangleShape_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfRectangleShape_getLocalBounds(atom shape)
	return c_func(xsfRectangleShape_getLocalBounds,{shape})
end function

public constant xsfRectangleShape_getGlobalBounds = define_c_func(gfx,"+sfRectangleShape_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfRectangleShape_getGlobalBounds(atom shape)
	return c_func(xsfRectangleShape_getGlobalBounds,{shape})
end function

--RenderTexture

public constant xsfRenderTexture_create = define_c_func(gfx,"+sfRenderTexture_create",{sfVector2u,C_POINTER},C_POINTER)

public function sfRenderTexture_create(sequence size,atom settings)
	return c_func(xsfRenderTexture_create,{size,settings})
end function

public constant xsfRenderTexture_destroy = define_c_proc(gfx,"+sfRenderTexture_destroy",{C_POINTER})

public procedure sfRenderTexture_destroy(atom rt)
	c_proc(xsfRenderTexture_destroy,{rt})
end procedure

public constant xsfRenderTexture_getSize = define_c_func(gfx,"+sfRenderTexture_getSize",{C_POINTER},sfVector2u)

public function sfRenderTexture_getSize(atom rt)
	return c_func(xsfRenderTexture_getSize,{rt})
end function

public constant xsfRenderTexture_isSrgb = define_c_func(gfx,"+sfRenderTexture_isSrgb",{C_POINTER},C_BOOL)

public function sfRenderTexture_isSrgb(atom rt)
	return c_func(xsfRenderTexture_isSrgb,{rt})
end function

public constant xsfRenderTexture_setActive = define_c_func(gfx,"+sfRenderTexture_setActive",{C_POINTER,C_BOOL},C_BOOL)

public function sfRenderTexture_setActive(atom rt,atom active)
	return c_func(xsfRenderTexture_setActive,{rt,active})
end function

public constant xsfRenderTexture_display = define_c_proc(gfx,"+sfRenderTexture_display",{C_POINTER})

public procedure sfRenderTexture_display(atom rt)
	c_proc(xsfRenderTexture_display,{rt})
end procedure

public constant xsfRenderTexture_clear = define_c_proc(gfx,"+sfRenderTexture_clear",{C_POINTER,sfColor})

public procedure sfRenderTexture_clear(atom rt,sequence color)
	c_proc(xsfRenderTexture_clear,{rt,color})
end procedure

public constant xsfRenderTexture_clearStencil = define_c_proc(gfx,"+sfRenderTexture_clearStencil",{C_POINTER,sfStencilValue})

public procedure sfRenderTexture_clearStencil(atom rt,sequence stencil)
	c_proc(xsfRenderTexture_clearStencil,{rt,stencil})
end procedure

public constant xsfRenderTexture_clearColorAndStencil = define_c_proc(gfx,"+sfRenderTexture_clearColorAndStencil",{C_POINTER,sfColor,sfStencilValue})

public procedure sfRenderTexture_clearColorAndStencil(atom rt,sequence color,sequence stencil)
	c_proc(xsfRenderTexture_clearColorAndStencil,{rt,color,stencil})
end procedure

public constant xsfRenderTexture_setView = define_c_proc(gfx,"+sfRenderTexture_setView",{C_POINTER,C_POINTER})

public procedure sfRenderTexture_setView(atom rt,atom view)
	c_proc(xsfRenderTexture_setView,{rt,view})
end procedure

public constant xsfRenderTexture_getView = define_c_func(gfx,"+sfRenderTexture_getView",{C_POINTER},C_POINTER)

public function sfRenderTexture_getView(atom rt)
	return c_func(xsfRenderTexture_getView,{rt})
end function

public constant xsfRenderTexture_getDefaultView = define_c_func(gfx,"+sfRenderTexture_getDefaultView",{C_POINTER},C_POINTER)

public function sfRenderTexture_getDefaultView(atom rt)
	return c_func(xsfRenderTexture_getDefaultView,{rt})
end function

public constant xsfRenderTexture_getViewport = define_c_func(gfx,"+sfRenderTexture_getViewport",{C_POINTER,C_POINTER},sfIntRect)

public function sfRenderTexture_getViewport(atom rt,atom view)
	return c_func(xsfRenderTexture_getViewport,{rt,view})
end function

public constant xsfRenderTexture_getScissor = define_c_func(gfx,"+sfRenderTexture_getScissor",{C_POINTER,C_POINTER},sfIntRect)

public function sfRenderTexture_getScissor(atom rt,atom view)
	return c_func(xsfRenderTexture_getScissor,{rt,view})
end function

public constant xsfRenderTexture_mapPixelToCoords = define_c_func(gfx,"+sfRenderTexture_mapPixelToCoords",{C_POINTER,sfVector2i,C_POINTER},sfVector2f)

public function sfRenderTexture_mapPixelToCoords(atom rt,sequence point,atom view)
	return c_func(xsfRenderTexture_mapPixelToCoords,{rt,point,view})
end function

public constant xsfRenderTexture_mapCoordsToPixel = define_c_func(gfx,"+sfRenderTexture_mapCoordsToPixel",{C_POINTER,sfVector2f,C_POINTER},sfVector2i)

public function sfRenderTexture_mapCoordsToPixel(atom rt,sequence point,atom view)
	return c_func(xsfRenderTexture_mapCoordsToPixel,{rt,point,view})
end function

public constant xsfRenderTexture_drawSprite = define_c_proc(gfx,"+sfRenderTexture_drawSprite",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderTexture_drawSprite(atom rt,atom sprite,atom state)
	c_proc(xsfRenderTexture_drawSprite,{rt,sprite,state})
end procedure

public constant xsfRenderTexture_drawText = define_c_proc(gfx,"+sfRenderTexture_drawText",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderTexture_drawText(atom rt,atom text,atom state)
	c_proc(xsfRenderTexture_drawText,{rt,text,state})
end procedure

public constant xsfRenderTexture_drawShape = define_c_proc(gfx,"+sfRenderTexture_drawShape",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderTexture_drawShape(atom rt,atom shape,atom state)
	c_proc(xsfRenderTexture_drawShape,{rt,shape,state})
end procedure

public constant xsfRenderTexture_drawCircleShape = define_c_proc(gfx,"+sfRenderTexture_drawCircleShape",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderTexture_drawCircleShape(atom rt,atom circle,atom state)
	c_proc(xsfRenderTexture_drawCircleShape,{rt,circle,state})
end procedure

public constant xsfRenderTexture_drawConvexShape = define_c_proc(gfx,"+sfRenderTexture_drawConvexShape",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderTexture_drawConvexShape(atom rt,atom convex,atom state)
	c_proc(xsfRenderTexture_drawConvexShape,{rt,convex,state})
end procedure

public constant xsfRenderTexture_drawRectangleShape = define_c_proc(gfx,"+sfRenderTexture_drawRectangleShape",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderTexture_drawRectangleShape(atom rt,atom rectangle,atom state)
	c_proc(xsfRenderTexture_drawRectangleShape,{rt,rectangle,state})
end procedure

public constant xsfRenderTexture_drawVertexArray = define_c_proc(gfx,"+sfRenderTexture_drawVertexArray",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderTexture_drawVertexArray(atom rt,atom vertexArray,atom state)
	c_proc(xsfRenderTexture_drawVertexArray,{rt,vertexArray,state})
end procedure

public constant xsfRenderTexture_drawVertexBuffer = define_c_proc(gfx,"+sfRenderTexture_drawVertexBuffer",{C_POINTER,C_POINTER,C_POINTER})

public procedure sfRenderTexture_drawVertexBuffer(atom rt,atom vertexBuffer,atom state)
	c_proc(xsfRenderTexture_drawVertexBuffer,{rt,vertexBuffer,state})
end procedure

public constant xsfRenderTexture_drawVertexBufferRange = define_c_proc(gfx,"+sfRenderTexture_drawVertexBufferRange",{C_POINTER,C_POINTER,C_SIZE_T,C_SIZE_T,C_POINTER})

public procedure sfRenderTexture_drawVertexBufferRange(atom rt,atom vertexBuffer,atom first,atom count,atom state)
	c_proc(xsfRenderTexture_drawVertexBufferRange,{rt,vertexBuffer,first,count,state})
end procedure

public constant xsfRenderTexture_drawPrimitives = define_c_proc(gfx,"+sfRenderTexture_drawPrimitives",{C_POINTER,C_POINTER,C_SIZE_T,C_INT,C_POINTER})

public procedure sfRenderTexture_drawPrimitives(atom rt,atom vertices,atom count,sfPrimitiveType ptype,atom state)
	c_proc(xsfRenderTexture_drawPrimitives,{rt,vertices,count,ptype,state})
end procedure

public constant xsfRenderTexture_pushGLStates = define_c_proc(gfx,"+sfRenderTexture_pushGLStates",{C_POINTER})

public procedure sfRenderTexture_pushGLStates(atom rt)
	c_proc(xsfRenderTexture_pushGLStates,{rt})
end procedure

public constant xsfRenderTexture_popGLStates = define_c_proc(gfx,"+sfRenderTexture_popGLStates",{C_POINTER})

public procedure sfRenderTexture_popGLStates(atom rt)
	c_proc(xsfRenderTexture_popGLStates,{rt})
end procedure

public constant xsfRenderTexture_resetGLStates = define_c_proc(gfx,"+sfRenderTexture_resetGLStates",{C_POINTER})

public procedure sfRenderTexture_resetGLStates(atom rt)
	c_proc(xsfRenderTexture_resetGLStates,{rt})
end procedure

public constant xsfRenderTexture_getTexture = define_c_func(gfx,"+sfRenderTexture_getTexture",{C_POINTER},C_POINTER)

public function sfRenderTexture_getTexture(atom rt)
	return c_func(xsfRenderTexture_getTexture,{rt})
end function

public constant xsfRenderTexture_getMaximumAntiAliasingLevel = define_c_func(gfx,"+sfRenderTexture_getMaximumAntiAliasingLevel",{},C_UINT)

public function sfRenderTexture_getMaximumAntiAliasingLevel()
	return c_func(xsfRenderTexture_getMaximumAntiAliasingLevel,{})
end function

public constant xsfRenderTexture_setSmooth = define_c_proc(gfx,"+sfRenderTexture_setSmooth",{C_POINTER,C_BOOL})

public procedure sfRenderTexture_setSmooth(atom rt,atom smooth)
	c_proc(xsfRenderTexture_setSmooth,{rt,smooth})
end procedure

public constant xsfRenderTexture_isSmooth = define_c_func(gfx,"+sfRenderTexture_isSmooth",{C_POINTER},C_BOOL)

public function sfRenderTexture_isSmooth(atom rt)
	return c_func(xsfRenderTexture_isSmooth,{rt})
end function

public constant xsfRenderTexture_setRepeated = define_c_proc(gfx,"+sfRenderTexture_setRepeated",{C_POINTER,C_BOOL})

public procedure sfRenderTexture_setRepeated(atom rt,atom repeated)
	c_proc(xsfRenderTexture_setRepeated,{rt,repeated})
end procedure

public constant xsfRenderTexture_isRepeated = define_c_func(gfx,"+sfRenderTexture_isRepeated",{C_POINTER},C_BOOL)

public function sfRenderTexture_isRepeated(atom rt)
	return c_func(xsfRenderTexture_isRepeated,{rt})
end function

public constant xsfRenderTexture_generateMipmap = define_c_func(gfx,"+sfRenderTexture_generateMipmap",{C_POINTER},C_BOOL)

public function sfRenderTexture_generateMipmap(atom rt)
	return c_func(xsfRenderTexture_generateMipmap,{rt})
end function

--Shader

public constant xsfShader_createFromFile = define_c_func(gfx,"+sfShader_createFromFile",{C_STRING,C_STRING,C_STRING},C_POINTER)

public function sfShader_createFromFile(sequence vertexfName,sequence geometryfName,sequence fragmentfName)
	return c_func(xsfShader_createFromFile,{vertexfName,geometryfName,fragmentfName})
end function

public constant xsfShader_createFromMemory = define_c_func(gfx,"+sfShader_createFromMemory",{C_STRING,C_STRING,C_STRING},C_POINTER)

public function sfShader_createFromMemory(sequence vertex,sequence geometry,sequence fragment)
	return c_func(xsfShader_createFromMemory,{vertex,geometry,fragment})
end function

public constant xsfShader_createFromStream = define_c_func(gfx,"+sfShader_createFromStream",{C_POINTER,C_POINTER,C_POINTER},C_POINTER)

public function sfShader_createFromStream(atom vertex,atom geometry,atom fragment)
	return c_func(xsfShader_createFromStream,{vertex,geometry,fragment})
end function

public constant xsfShader_destroy = define_c_proc(gfx,"+sfShader_destroy",{C_POINTER})

public procedure sfShader_destroy(atom shader)
	c_proc(xsfShader_destroy,{shader})
end procedure

public constant xsfShader_setFloatUniform = define_c_proc(gfx,"+sfShader_setFloatUniform",{C_POINTER,C_STRING,C_FLOAT})

public procedure sfShader_setFloatUniform(atom shader,sequence name,atom x)
	c_proc(xsfShader_setFloatUniform,{shader,name,x})
end procedure

public constant xsfShader_setVec2Uniform = define_c_proc(gfx,"+sfShader_setVec2Uniform",{C_POINTER,C_STRING,sfGlslVec2})

public procedure sfShader_setVec2Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setVec2Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setVec3Uniform = define_c_proc(gfx,"+sfShader_setVec3Uniform",{C_POINTER,C_STRING,sfGlslVec3})

public procedure sfShader_setVec3Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setVec3Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setVec4Uniform = define_c_proc(gfx,"+sfShader_setVec4Uniform",{C_POINTER,C_STRING,sfGlslVec4})

public procedure sfShader_setVec4Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setVec4Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setColorUniform = define_c_proc(gfx,"+sfShader_setColorUniform",{C_POINTER,C_STRING,sfColor})

public procedure sfShader_setColorUniform(atom shader,sequence name,sequence color)
	c_proc(xsfShader_setColorUniform,{shader,name,color})
end procedure

public constant xsfShader_setIntUniform = define_c_proc(gfx,"+sfShader_setIntUniform",{C_POINTER,C_STRING,C_INT})

public procedure sfShader_setIntUniform(atom shader,sequence name,atom x)
	c_proc(xsfShader_setIntUniform,{shader,name,x})
end procedure

public constant xsfShader_setIvec2Uniform = define_c_proc(gfx,"+sfShader_setIvec2Uniform",{C_POINTER,C_STRING,sfGlslIvec2})

public procedure sfShader_setIvec2Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setIvec2Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setIvec3Uniform = define_c_proc(gfx,"+sfShader_setIvec3Uniform",{C_POINTER,C_STRING,sfGlslIvec3})

public procedure sfShader_setIvec3Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setIvec3Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setIvec4Uniform = define_c_proc(gfx,"+sfShader_setIvec4Uniform",{C_POINTER,C_STRING,sfGlslIvec4})

public procedure sfShader_setIvec4Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setIvec4Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setIntColorUniform = define_c_proc(gfx,"+sfShader_setIntColorUniform",{C_POINTER,C_STRING,sfColor})

public procedure sfShader_setIntColorUniform(atom shader,sequence name,sequence color)
	c_proc(xsfShader_setIntColorUniform,{shader,name,color})
end procedure

public constant xsfShader_setBoolUniform = define_c_proc(gfx,"+sfShader_setBoolUniform",{C_POINTER,C_STRING,C_BOOL})

public procedure sfShader_setBoolUniform(atom shader,sequence name,atom x)
	c_proc(xsfShader_setBoolUniform,{shader,name,x})
end procedure

public constant xsfShader_setBvec2Uniform = define_c_proc(gfx,"+sfShader_setBvec2Uniform",{C_POINTER,C_STRING,sfGlslBvec2})

public procedure sfShader_setBvec2Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setBvec2Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setBvec3Uniform = define_c_proc(gfx,"+sfShader_setBvec3Uniform",{C_POINTER,C_STRING,sfGlslBvec3})

public procedure sfShader_setBvec3Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setBvec3Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setBvec4Uniform = define_c_proc(gfx,"+sfShader_setBvec4Uniform",{C_POINTER,C_STRING,sfGlslBvec4})

public procedure sfShader_setBvec4Uniform(atom shader,sequence name,sequence vector)
	c_proc(xsfShader_setBvec4Uniform,{shader,name,vector})
end procedure

public constant xsfShader_setMat3Uniform = define_c_proc(gfx,"+sfShader_setMat3Uniform",{C_POINTER,C_STRING,C_POINTER})

public procedure sfShader_setMat3Uniform(atom shader,sequence name,atom matrix)
	c_proc(xsfShader_setMat3Uniform,{shader,name,matrix})
end procedure

public constant xsfShader_setMat4Uniform = define_c_proc(gfx,"+sfShader_setMat4Uniform",{C_POINTER,C_STRING,C_POINTER})

public procedure sfShader_setMat4Uniform(atom shader,sequence name,atom matrix)
	c_proc(xsfShader_setMat4Uniform,{shader,name,matrix})
end procedure

public constant xsfShader_setTextureUniform = define_c_proc(gfx,"+sfShader_setTextureUniform",{C_POINTER,C_STRING,C_POINTER})

public procedure sfShader_setTextureUniform(atom shader,sequence name,atom texture)
	c_proc(xsfShader_setTextureUniform,{shader,name,texture})
end procedure

public constant xsfShader_setCurrentTextureUniform = define_c_proc(gfx,"+sfShader_setCurrentTextureUniform",{C_POINTER,C_STRING})

public procedure sfShader_setCurrentTextureUniform(atom shader,sequence name)
	c_proc(xsfShader_setCurrentTextureUniform,{shader,name})
end procedure

public constant xsfShader_setFloatUniformArray = define_c_proc(gfx,"+sfShader_setFloatUniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setFloatUniformArray(atom shader,sequence name,atom scalarArray,atom len)
	c_proc(xsfShader_setFloatUniformArray,{shader,name,scalarArray,len})
end procedure

public constant xsfShader_setVec2UniformArray = define_c_proc(gfx,"+sfShader_setVec2UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setVec2UniformArray(atom shader,sequence name,atom vectorArray,atom len)
	c_proc(xsfShader_setVec2UniformArray,{shader,name,vectorArray,len})
end procedure

public constant xsfShader_setVec3UniformArray = define_c_proc(gfx,"+sfShader_setVec3UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setVec3UniformArray(atom shader,sequence name,atom vectorArray,atom len)
	c_proc(xsfShader_setVec3UniformArray,{shader,name,vectorArray,len})
end procedure

public constant xsfShader_setVec4UniformArray = define_c_proc(gfx,"+sfShader_setVec4UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setVec4UniformArray(atom shader,sequence name,atom vectorArray,atom len)
	c_proc(xsfShader_setVec4UniformArray,{shader,name,vectorArray,len})
end procedure

public constant xsfShader_setMat3UniformArray = define_c_proc(gfx,"+sfShader_setMat3UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setMat3UniformArray(atom shader,sequence name,atom matrixArray,atom len)
	c_proc(xsfShader_setMat3UniformArray,{shader,name,matrixArray,len})
end procedure

public constant xsfShader_setMat4UniformArray = define_c_proc(gfx,"+sfShader_setMat4UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setMat4UniformArray(atom shader,sequence name,atom matrixArray,atom len)
	c_proc(xsfShader_setMat4UniformArray,{shader,name,matrixArray,len})
end procedure

public constant xsfShader_getNativeHandle = define_c_func(gfx,"+sfShader_getNativeHandle",{C_POINTER},C_UINT)

public function sfShader_getNativeHandle(atom shader)
	return c_func(xsfShader_getNativeHandle,{shader})
end function

public constant xsfShader_bind = define_c_proc(gfx,"+sfShader_bind",{C_POINTER})

public procedure sfShader_bind(atom shader)
	c_proc(xsfShader_bind,{shader})
end procedure

public constant xsfShader_isAvailable = define_c_func(gfx,"+sfShader_isAvailable",{},C_BOOL)

public function sfShader_isAvailable()
	return c_func(xsfShader_isAvailable,{})
end function

public constant xsfShader_isGeometryAvailable = define_c_func(gfx,"+sfShader_isGeometryAvailable",{},C_BOOL)

public function sfShader_isGeometryAvailable()
	return c_func(xsfShader_isGeometryAvailable,{})
end function

--Shape

public constant xsfShape_create = define_c_func(gfx,"+sfShape_create",{C_POINTER,C_POINTER,C_POINTER},C_POINTER)

public function sfShape_create(atom getPointCount,atom getPoint,atom userData)
	return c_func(xsfShape_create,{getPointCount,getPoint,userData})
end function

public constant xsfShape_destroy = define_c_proc(gfx,"+sfShape_destroy",{C_POINTER})

public procedure sfShape_destroy(atom shape)
	c_proc(xsfShape_destroy,{shape})
end procedure

public constant xsfShape_setPosition = define_c_proc(gfx,"+sfShape_setPosition",{C_POINTER,sfVector2f})

public procedure sfShape_setPosition(atom shape,sequence pos)
	c_proc(xsfShape_setPosition,{shape,pos})
end procedure

public constant xsfShape_setRotation = define_c_proc(gfx,"+sfShape_setRotation",{C_POINTER,C_FLOAT})

public procedure sfShape_setRotation(atom shape,atom angle)
	c_proc(xsfShape_setRotation,{shape,angle})
end procedure

public constant xsfShape_setScale = define_c_proc(gfx,"+sfShape_setScale",{C_POINTER,sfVector2f})

public procedure sfShape_setScale(atom shape,sequence scale)
	c_proc(xsfShape_setScale,{shape,scale})
end procedure

public constant xsfShape_setOrigin = define_c_proc(gfx,"+sfShape_setOrigin",{C_POINTER,sfVector2f})

public procedure sfShape_setOrigin(atom shape,sequence origin)
	c_proc(xsfShape_setOrigin,{shape,origin})
end procedure

public constant xsfShape_getPosition = define_c_func(gfx,"+sfShape_getPosition",{C_POINTER},sfVector2f)

public function sfShape_getPosition(atom shape)
	return c_func(xsfShape_getPosition,{shape})
end function

public constant xsfShape_getRotation = define_c_func(gfx,"+sfShape_getRotation",{C_POINTER},C_FLOAT)

public function sfShape_getRotation(atom shape)
	return c_func(xsfShape_getRotation,{shape})
end function

public constant xsfShape_getScale = define_c_func(gfx,"+sfShape_getScale",{C_POINTER},sfVector2f)

public function sfShape_getScale(atom shape)
	return c_func(xsfShape_getScale,{shape})
end function

public constant xsfShape_getOrigin = define_c_func(gfx,"+sfShape_getOrigin",{C_POINTER},sfVector2f)

public function sfShape_getOrigin(atom shape)
	return c_func(xsfShape_getOrigin,{shape})
end function

public constant xsfShape_move = define_c_proc(gfx,"+sfShape_move",{C_POINTER,sfVector2f})

public procedure sfShape_move(atom shape,sequence offset)
	c_proc(xsfShape_move,{shape,offset})
end procedure

public constant xsfShape_rotate = define_c_proc(gfx,"+sfShape_rotate",{C_POINTER,C_FLOAT})

public procedure sfShape_rotate(atom shape,atom angle)
	c_proc(xsfShape_rotate,{shape,angle})
end procedure

public constant xsfShape_scale = define_c_proc(gfx,"+sfShape_scale",{C_POINTER,sfVector2f})

public procedure sfShape_scale(atom shape,sequence factors)
	c_proc(xsfShape_scale,{shape,factors})
end procedure

public constant xsfShape_getTransform = define_c_func(gfx,"+sfShape_getTransform",{C_POINTER},sfTransform)

public function sfShape_getTransform(atom shape)
	return c_func(xsfShape_getTransform,{shape})
end function

public constant xsfShape_getInverseTransform = define_c_func(gfx,"+sfShape_getInverseTransform",{C_POINTER},sfTransform)

public function sfShape_getInverseTransform(atom shape)
	return c_func(xsfShape_getInverseTransform,{shape})
end function

public constant xsfShape_setTexture = define_c_proc(gfx,"+sfShape_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfShape_setTexture(atom shape,atom texture,atom resetRect)
	c_proc(xsfShape_setTexture,{shape,texture,resetRect})
end procedure

public constant xsfShape_setTextureRect = define_c_proc(gfx,"+sfShape_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfShape_setTextureRect(atom shape,sequence rect)
	c_proc(xsfShape_setTextureRect,{shape,rect})
end procedure

public constant xsfShape_setFillColor = define_c_proc(gfx,"+sfShape_setFillColor",{C_POINTER,sfColor})

public procedure sfShape_setFillColor(atom shape,sequence color)
	c_proc(xsfShape_setFillColor,{shape,color})
end procedure

public constant xsfShape_setOutlineColor = define_c_proc(gfx,"+sfShape_setOutlineColor",{C_POINTER,sfColor})

public procedure sfShape_setOutlineColor(atom shape,sequence color)
	c_proc(xsfShape_setOutlineColor,{shape,color})
end procedure

public constant xsfShape_setOutlineThickness = define_c_proc(gfx,"+sfShape_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfShape_setOutlineThickness(atom shape,atom thick)
	c_proc(xsfShape_setOutlineThickness,{shape,thick})
end procedure

public constant xsfShape_getTexture = define_c_func(gfx,"+sfShape_getTexture",{C_POINTER},C_POINTER)

public function sfShape_getTexture(atom shape)
	return c_func(xsfShape_getTexture,{shape})
end function

public constant xsfShape_getTextureRect = define_c_func(gfx,"+sfShape_getTextureRect",{C_POINTER},sfIntRect)

public function sfShape_getTextureRect(atom shape)
	return c_func(xsfShape_getTextureRect,{shape})
end function

public constant xsfShape_getFillColor = define_c_func(gfx,"+sfShape_getFillColor",{C_POINTER},sfColor)

public function sfShape_getFillColor(atom shape)
	return c_func(xsfShape_getFillColor,{shape})
end function

public constant xsfShape_getOutlineColor = define_c_func(gfx,"+sfShape_getOutlineColor",{C_POINTER},sfColor)

public function sfShape_getOutlineColor(atom shape)
	return c_func(xsfShape_getOutlineColor,{shape})
end function

public constant xsfShape_getOutlineThickness = define_c_func(gfx,"+sfShape_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfShape_getOutlineThickness(atom shape)
	return c_func(xsfShape_getOutlineThickness,{shape})
end function

public constant xsfShape_getPointCount = define_c_func(gfx,"+sfShape_getPointCount",{C_POINTER},C_SIZE_T)

public function sfShape_getPointCount(atom shape)
	return c_func(xsfShape_getPointCount,{shape})
end function

public constant xsfShape_getPoint = define_c_func(gfx,"+sfShape_getPoint",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfShape_getPoint(atom shape,atom index)
	return c_func(xsfShape_getPoint,{shape,index})
end function

public constant xsfShape_getGeometricCenter = define_c_func(gfx,"+sfShape_getGeometricCenter",{C_POINTER},sfVector2f)

public function sfShape_getGeometricCenter(atom shape)
	return c_func(xsfShape_getGeometricCenter,{shape})
end function

public constant xsfShape_getLocalBounds = define_c_func(gfx,"+sfShape_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfShape_getLocalBounds(atom shape)
	return c_func(xsfShape_getLocalBounds,{shape})
end function

public constant xsfShape_getGlobalBounds = define_c_func(gfx,"+sfShape_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfShape_getGlobalBounds(atom shape)
	return c_func(xsfShape_getGlobalBounds,{shape})
end function

public constant xsfShape_update = define_c_proc(gfx,"+sfShape_update",{C_POINTER})

public procedure sfShape_update(atom shape)
	c_proc(xsfShape_update,{shape})
end procedure

--Sprite

public constant xsfSprite_create = define_c_func(gfx,"+sfSprite_create",{C_POINTER},C_POINTER)

public function sfSprite_create(atom texture)
	return c_func(xsfSprite_create,{texture})
end function

public constant xsfSprite_copy = define_c_func(gfx,"+sfSprite_copy",{C_POINTER},C_POINTER)

public function sfSprite_copy(atom sprite)
	return c_func(xsfSprite_copy,{sprite})
end function

public constant xsfSprite_destroy = define_c_proc(gfx,"+sfSprite_destroy",{C_POINTER})

public procedure sfSprite_destroy(atom sprite)
	c_proc(xsfSprite_destroy,{sprite})
end procedure

public constant xsfSprite_setPosition = define_c_proc(gfx,"+sfSprite_setPosition",{C_POINTER,sfVector2f})

public procedure sfSprite_setPosition(atom sprite,sequence pos)
	c_proc(xsfSprite_setPosition,{sprite,pos})
end procedure

public constant xsfSprite_setRotation = define_c_proc(gfx,"+sfSprite_setRotation",{C_POINTER,C_FLOAT})

public procedure sfSprite_setRotation(atom sprite,atom angle)
	c_proc(xsfSprite_setRotation,{sprite,angle})
end procedure

public constant xsfSprite_setScale = define_c_proc(gfx,"+sfSprite_setScale",{C_POINTER,sfVector2f})

public procedure sfSprite_setScale(atom sprite,sequence scale)
	c_proc(xsfSprite_setScale,{sprite,scale})
end procedure

public constant xsfSprite_setOrigin = define_c_proc(gfx,"+sfSprite_setOrigin",{C_POINTER,sfVector2f})

public procedure sfSprite_setOrigin(atom sprite,sequence origin)
	c_proc(xsfSprite_setOrigin,{sprite,origin})
end procedure

public constant xsfSprite_getPosition = define_c_func(gfx,"+sfSprite_getPosition",{C_POINTER},sfVector2f)

public function sfSprite_getPosition(atom sprite)
	return c_func(xsfSprite_getPosition,{sprite})
end function

public constant xsfSprite_getRotation = define_c_func(gfx,"+sfSprite_getRotation",{C_POINTER},C_FLOAT)

public function sfSprite_getRotation(atom sprite)
	return c_func(xsfSprite_getRotation,{sprite})
end function

public constant xsfSprite_getScale = define_c_func(gfx,"+sfSprite_getScale",{C_POINTER},sfVector2f)

public function sfSprite_getScale(atom sprite)
	return c_func(xsfSprite_getScale,{sprite})
end function

public constant xsfSprite_getOrigin = define_c_func(gfx,"+sfSprite_getOrigin",{C_POINTER},sfVector2f)

public function sfSprite_getOrigin(atom sprite)
	return c_func(xsfSprite_getOrigin,{sprite})
end function

public constant xsfSprite_move = define_c_proc(gfx,"+sfSprite_move",{C_POINTER,sfVector2f})

public procedure sfSprite_move(atom sprite,sequence offset)
	c_proc(xsfSprite_move,{sprite,offset})
end procedure

public constant xsfSprite_rotate = define_c_proc(gfx,"+sfSprite_rotate",{C_POINTER,C_FLOAT})

public procedure sfSprite_rotate(atom sprite,atom angle)
	c_proc(xsfSprite_rotate,{sprite,angle})
end procedure

public constant xsfSprite_scale = define_c_proc(gfx,"+sfSprite_scale",{C_POINTER,sfVector2f})

public procedure sfSprite_scale(atom sprite,sequence factors)
	c_proc(xsfSprite_scale,{sprite,factors})
end procedure

public constant xsfSprite_getTransform = define_c_func(gfx,"+sfSprite_getTransform",{C_POINTER},sfTransform)

public function sfSprite_getTransform(atom sprite)
	return c_func(xsfSprite_getTransform,{sprite})
end function

public constant xsfSprite_getInverseTransform = define_c_func(gfx,"+sfSprite_getInverseTransform",{C_POINTER},sfTransform)

public function sfSprite_getInverseTransform(atom sprite)
	return c_func(xsfSprite_getInverseTransform,{sprite})
end function

public constant xsfSprite_setTexture = define_c_proc(gfx,"+sfSprite_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfSprite_setTexture(atom sprite,atom texture,atom resetRect)
	c_proc(xsfSprite_setTexture,{sprite,texture,resetRect})
end procedure

public constant xsfSprite_setTextureRect = define_c_proc(gfx,"+sfSprite_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfSprite_setTextureRect(atom sprite,sequence rectangle)
	c_proc(xsfSprite_setTextureRect,{sprite,rectangle})
end procedure

public constant xsfSprite_setColor = define_c_proc(gfx,"+sfSprite_setColor",{C_POINTER,sfColor})

public procedure sfSprite_setColor(atom sprite,sequence color)
	c_proc(xsfSprite_setColor,{sprite,color})
end procedure

public constant xsfSprite_getTexture = define_c_func(gfx,"+sfSprite_getTexture",{C_POINTER},C_POINTER)

public function sfSprite_getTexture(atom sprite)
	return c_func(xsfSprite_getTexture,{sprite})
end function

public constant xsfSprite_getTextureRect = define_c_func(gfx,"+sfSprite_getTextureRect",{C_POINTER},sfIntRect)

public function sfSprite_getTextureRect(atom sprite)
	return c_func(xsfSprite_getTextureRect,{sprite})
end function

public constant xsfSprite_getColor = define_c_func(gfx,"+sfSprite_getColor",{C_POINTER},sfColor)

public function sfSprite_getColor(atom sprite)
	return c_func(xsfSprite_getColor,{sprite})
end function

public constant xsfSprite_getLocalBounds = define_c_func(gfx,"+sfSprite_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfSprite_getLocalBounds(atom sprite)
	return c_func(xsfSprite_getLocalBounds,{sprite})
end function

public constant xsfSprite_getGlobalBounds = define_c_func(gfx,"+sfSprite_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfSprite_getGlobalBounds(atom sprite)
	return c_func(xsfSprite_getGlobalBounds,{sprite})
end function

--Text

public enum type sfTextStyle
	sfTextRegular = 0,
	sfTextBold = 1, -- 1 << 0
	sfTextItalic = 2, -- 1 << 1
	sfTextUnderlined = 4, -- 1 << 2
	sfTextStrikethrough = 8 -- 1 << 3
end type

public constant xsfText_create = define_c_func(gfx,"+sfText_create",{C_POINTER},C_POINTER)

public function sfText_create(atom font)
	return c_func(xsfText_create,{font})
end function

public constant xsfText_copy = define_c_func(gfx,"+sfText_copy",{C_POINTER},C_POINTER)

public function sfText_copy(atom text)
	return c_func(xsfText_copy,{text})
end function

public constant xsfText_destroy = define_c_proc(gfx,"+sfText_destroy",{C_POINTER})

public procedure sfText_destroy(atom text)
	c_proc(xsfText_destroy,{text})
end procedure

public constant xsfText_setPosition = define_c_proc(gfx,"+sfText_setPosition",{C_POINTER,sfVector2f})

public procedure sfText_setPosition(atom text,sequence pos)
	c_proc(xsfText_setPosition,{text,pos})
end procedure

public constant xsfText_setRotation = define_c_proc(gfx,"+sfText_setRotation",{C_POINTER,C_FLOAT})

public procedure sfText_setRotation(atom text,atom angle)
	c_proc(xsfText_setRotation,{text,angle})
end procedure

public constant xsfText_setScale = define_c_proc(gfx,"+sfText_setScale",{C_POINTER,sfVector2f})

public procedure sfText_setScale(atom text,sequence scale)
	c_proc(xsfText_setScale,{text,scale})
end procedure

public constant xsfText_setOrigin = define_c_proc(gfx,"+sfText_setOrigin",{C_POINTER,sfVector2f})

public procedure sfText_setOrigin(atom text,sequence origin)
	c_proc(xsfText_setOrigin,{text,origin})
end procedure

public constant xsfText_getPosition = define_c_func(gfx,"+sfText_getPosition",{C_POINTER},sfVector2f)

public function sfText_getPosition(atom text)
	return c_func(xsfText_getPosition,{text})
end function

public constant xsfText_getRotation = define_c_func(gfx,"+sfText_getRotation",{C_POINTER},C_FLOAT)

public function sfText_getRotation(atom text)
	return c_func(xsfText_getRotation,{text})
end function

public constant xsfText_getScale = define_c_func(gfx,"+sfText_getScale",{C_POINTER},sfVector2f)

public function sfText_getScale(atom text)
	return c_func(xsfText_getScale,{text})
end function

public constant xsfText_getOrigin = define_c_func(gfx,"+sfText_getOrigin",{C_POINTER},sfVector2f)

public function sfText_getOrigin(atom text)
	return c_func(xsfText_getOrigin,{text})
end function

public constant xsfText_move = define_c_proc(gfx,"+sfText_move",{C_POINTER,sfVector2f})

public procedure sfText_move(atom text,sequence offset)
	c_proc(xsfText_move,{text,offset})
end procedure

public constant xsfText_rotate = define_c_proc(gfx,"+sfText_rotate",{C_POINTER,C_FLOAT})

public procedure sfText_rotate(atom text,atom angle)
	c_proc(xsfText_rotate,{text,angle})
end procedure

public constant xsfText_scale = define_c_proc(gfx,"+sfText_scale",{C_POINTER,sfVector2f})

public procedure sfText_scale(atom text,sequence factors)
	c_proc(xsfText_scale,{text,factors})
end procedure

public constant xsfText_getTransform = define_c_func(gfx,"+sfText_getTransform",{C_POINTER},sfTransform)

public function sfText_getTransform(atom text)
	return c_func(xsfText_getTransform,{text})
end function

public constant xsfText_getInverseTransform = define_c_func(gfx,"+sfText_getInverseTransform",{C_POINTER},sfTransform)

public function sfText_getInverseTransform(atom text)
	return c_func(xsfText_getInverseTransform,{text})
end function

public constant xsfText_setString = define_c_proc(gfx,"+sfText_setString",{C_POINTER,C_STRING})

public procedure sfText_setString(atom text,sequence str)
	c_proc(xsfText_setString,{text,str})
end procedure

public constant xsfText_setUnicodeString = define_c_proc(gfx,"+sfText_setUnicodeString",{C_POINTER,C_POINTER})

public procedure sfText_setUnicodeString(atom text,sequence string)
	atom str = allocate_string(string,1)
	c_proc(xsfText_setUnicodeString,{text,str})
end procedure

public constant xsfText_setFont = define_c_proc(gfx,"+sfText_setFont",{C_POINTER,C_POINTER})

public procedure sfText_setFont(atom text,atom font)
	c_proc(xsfText_setFont,{text,font})
end procedure

public constant xsfText_setCharacterSize = define_c_proc(gfx,"+sfText_setCharacterSize",{C_POINTER,C_UINT})

public procedure sfText_setCharacterSize(atom text,atom size)
	c_proc(xsfText_setCharacterSize,{text,size})
end procedure

public constant xsfText_setLineSpacing = define_c_proc(gfx,"+sfText_setLineSpacing",{C_POINTER,C_FLOAT})

public procedure sfText_setLineSpacing(atom text,atom spacingFactor)
	c_proc(xsfText_setLineSpacing,{text,spacingFactor})
end procedure

public constant xsfText_setLetterSpacing = define_c_proc(gfx,"+sfText_setLetterSpacing",{C_POINTER,C_FLOAT})

public procedure sfText_setLetterSpacing(atom text,atom spacingFactor)
	c_proc(xsfText_setLetterSpacing,{text,spacingFactor})
end procedure

public constant xsfText_setStyle = define_c_proc(gfx,"+sfText_setStyle",{C_POINTER,C_UINT32})

public procedure sfText_setStyle(atom text,atom style)
	c_proc(xsfText_setStyle,{text,style})
end procedure

public constant xsfText_setFillColor = define_c_proc(gfx,"+sfText_setFillColor",{C_POINTER,sfColor})

public procedure sfText_setFillColor(atom text,sequence color)
	c_proc(xsfText_setFillColor,{text,color})
end procedure

public constant xsfText_setOutlineColor = define_c_proc(gfx,"+sfText_setOutlineColor",{C_POINTER,sfColor})

public procedure sfText_setOutlineColor(atom text,sequence color)
	c_proc(xsfText_setOutlineColor,{text,color})
end procedure

public constant xsfText_setOutlineThickness = define_c_proc(gfx,"+sfText_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfText_setOutlineThickness(atom text,atom thick)
	c_proc(xsfText_setOutlineThickness,{text,thick})
end procedure

public constant xsfText_getString = define_c_func(gfx,"+sfText_getString",{C_POINTER},C_STRING)

public function sfText_getString(atom text)
	return c_func(xsfText_getString,{text})
end function

public constant xsfText_getUnicodeString = define_c_func(gfx,"+sfText_getUnicodeString",{C_POINTER},C_POINTER)

public function sfText_getUnicodeString(atom text)
	return c_func(xsfText_getUnicodeString,{text})
end function

public constant xsfText_getFont = define_c_func(gfx,"+sfText_getFont",{C_POINTER},C_POINTER)

public function sfText_getFont(atom text)
	return c_func(xsfText_getFont,{text})
end function

public constant xsfText_getCharacterSize = define_c_func(gfx,"+sfText_getCharacterSize",{C_POINTER},C_UINT)

public function sfText_getCharacterSize(atom text)
	return c_func(xsfText_getCharacterSize,{text})
end function

public constant xsfText_getLetterSpacing = define_c_func(gfx,"+sfText_getLetterSpacing",{C_POINTER},C_FLOAT)

public function sfText_getLetterSpacing(atom text)
	return c_func(xsfText_getLetterSpacing,{text})
end function

public constant xsfText_getLineSpacing = define_c_func(gfx,"+sfText_getLineSpacing",{C_POINTER},C_FLOAT)

public function sfText_getLineSpacing(atom text)
	return c_func(xsfText_getLineSpacing,{text})
end function

public constant xsfText_getStyle = define_c_func(gfx,"+sfText_getStyle",{C_POINTER},C_UINT32)

public function sfText_getStyle(atom text)
	return c_func(xsfText_getStyle,{text})
end function

public constant xsfText_getFillColor = define_c_func(gfx,"+sfText_getFillColor",{C_POINTER},sfColor)

public function sfText_getFillColor(atom text)
	return c_func(xsfText_getFillColor,{text})
end function

public constant xsfText_getOutlineColor = define_c_func(gfx,"+sfText_getOutlineColor",{C_POINTER},sfColor)

public function sfText_getOutlineColor(atom text)
	return c_func(xsfText_getOutlineColor,{text})
end function

public constant xsfText_getOutlineThickness = define_c_func(gfx,"+sfText_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfText_getOutlineThickness(atom text)
	return c_func(xsfText_getOutlineThickness,{text})
end function

public constant xsfText_findCharacterPos = define_c_func(gfx,"+sfText_findCharacterPos",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfText_findCharacterPos(atom text,atom index)
	return c_func(xsfText_findCharacterPos,{text,index})
end function

public constant xsfText_getLocalBounds = define_c_func(gfx,"+sfText_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfText_getLocalBounds(atom text)
	return c_func(xsfText_getLocalBounds,{text})
end function

public constant xsfText_getGlobalBounds = define_c_func(gfx,"+sfText_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfText_getGlobalBounds(atom text)
	return c_func(xsfText_getGlobalBounds,{text})
end function

--Texture

public constant xsfTexture_create = define_c_func(gfx,"+sfTexture_create",{sfVector2u},C_POINTER)

public function sfTexture_create(sequence size)
	return c_func(xsfTexture_create,{size})
end function

public constant xsfTexture_createSrgb = define_c_func(gfx,"+sfTexture_createSrgb",{sfVector2u},C_POINTER)

public function sfTexture_createSrgb(sequence size)
	return c_func(xsfTexture_createSrgb,{size})
end function

public constant xsfTexture_createFromFile = define_c_func(gfx,"+sfTexture_createFromFile",{C_STRING,C_POINTER},C_POINTER)

public function sfTexture_createFromFile(sequence fname,atom area)
	return c_func(xsfTexture_createFromFile,{fname,area})
end function

public constant xsfTexture_createSrgbFromFile = define_c_func(gfx,"+sfTexture_createSrgbFromFile",{C_STRING,C_POINTER},C_POINTER)

public function sfTexture_createSrgbFromFile(sequence fname,atom area)
	return c_func(xsfTexture_createSrgbFromFile,{fname,area})
end function

public constant xsfTexture_createFromMemory = define_c_func(gfx,"+sfTexture_createFromMemory",{C_POINTER,C_SIZE_T,C_POINTER},C_POINTER)

public function sfTexture_createFromMemory(atom data,atom size,atom area)
	return c_func(xsfTexture_createFromMemory,{data,size,area})
end function

public constant xsfTexture_createSrgbFromMemory = define_c_func(gfx,"+sfTexture_createSrgbFromMemory",{C_POINTER,C_SIZE_T,C_POINTER},C_POINTER)

public function sfTexture_createSrgbFromMemory(atom data,atom size,atom area)
	return c_func(xsfTexture_createSrgbFromMemory,{data,size,area})
end function

public constant xsfTexture_createFromStream = define_c_func(gfx,"+sfTexture_createFromStream",{C_POINTER,C_POINTER},C_POINTER)

public function sfTexture_createFromStream(atom stream,atom area)
	return c_func(xsfTexture_createFromStream,{stream,area})
end function

public constant xsfTexture_createSrgbFromStream = define_c_func(gfx,"+sfTexture_createSrgbFromStream",{C_POINTER,C_POINTER},C_POINTER)

public function sfTexture_createSrgbFromStream(atom stream,atom area)
	return c_func(xsfTexture_createSrgbFromStream,{stream,area})
end function

public constant xsfTexture_createFromImage = define_c_func(gfx,"+sfTexture_createFromImage",{C_POINTER,C_POINTER},C_POINTER)

public function sfTexture_createFromImage(atom image,atom area)
	return c_func(xsfTexture_createFromImage,{image,area})
end function

public constant xsfTexture_createSrgbFromImage = define_c_func(gfx,"+sfTexture_createSrgbFromImage",{C_POINTER,C_POINTER},C_POINTER)

public function sfTexture_createSrgbFromImage(atom image,atom area)
	return c_func(xsfTexture_createSrgbFromImage,{image,area})
end function

public constant xsfTexture_copy = define_c_func(gfx,"+sfTexture_copy",{C_POINTER},C_POINTER)

public function sfTexture_copy(atom texture)
	return c_func(xsfTexture_copy,{texture})
end function

public constant xsfTexture_destroy = define_c_proc(gfx,"+sfTexture_destroy",{C_POINTER})

public procedure sfTexture_destroy(atom texture)
	c_proc(xsfTexture_destroy,{texture})
end procedure

public constant xsfTexture_resize = define_c_func(gfx,"+sfTexture_resize",{C_POINTER,sfVector2u},C_BOOL)

public function sfTexture_resize(atom texture,sequence size)
	return c_func(xsfTexture_resize,{texture,size})
end function

public constant xsfTexture_resizeSrgb = define_c_func(gfx,"+sfTexture_resizeSrgb",{C_POINTER,sfVector2u},C_BOOL)

public function sfTexture_resizeSrgb(atom texture,sequence size)
	return c_func(xsfTexture_resizeSrgb,{texture,size})
end function

public constant xsfTexture_getSize = define_c_func(gfx,"+sfTexture_getSize",{C_POINTER},sfVector2u)

public function sfTexture_getSize(atom texture)
	return c_func(xsfTexture_getSize,{texture})
end function

public constant xsfTexture_copyToImage = define_c_func(gfx,"+sfTexture_copyToImage",{C_POINTER},C_POINTER)

public function sfTexture_copyToImage(atom texture)
	return c_func(xsfTexture_copyToImage,{texture})
end function

public constant xsfTexture_updateFromPixels = define_c_proc(gfx,"+sfTexture_updateFromPixels",{C_POINTER,C_POINTER,sfVector2u,sfVector2u})

public procedure sfTexture_updateFromPixels(atom texture,atom pixels,sequence size,sequence offset)
	c_proc(xsfTexture_updateFromPixels,{texture,pixels,size,offset})
end procedure

public constant xsfTexture_updateFromTexture = define_c_proc(gfx,"+sfTexture_updateFromTexture",{C_POINTER,C_POINTER,sfVector2u})

public procedure sfTexture_updateFromTexture(atom dest,atom source,sequence offset)
	c_proc(xsfTexture_updateFromTexture,{dest,source,offset})
end procedure

public constant xsfTexture_updateFromImage = define_c_proc(gfx,"+sfTexture_updateFromImage",{C_POINTER,C_POINTER,sfVector2u})

public procedure sfTexture_updateFromImage(atom texture,atom image,sequence offset)
	c_proc(xsfTexture_updateFromImage,{texture,image,offset})
end procedure

public constant xsfTexture_updateFromWindow = define_c_proc(gfx,"+sfTexture_updateFromWindow",{C_POINTER,C_POINTER,sfVector2u})

public procedure sfTexture_updateFromWindow(atom texture,atom window,sequence offset)
	c_proc(xsfTexture_updateFromWindow,{texture,window,offset})
end procedure

public constant xsfTexture_updateFromRenderWindow = define_c_proc(gfx,"+sfTexture_updateFromRenderWindow",{C_POINTER,C_POINTER,sfVector2u})

public procedure sfTexture_updateFromRenderWindow(atom texture,atom renderWindow,sequence offset)
	c_proc(xsfTexture_updateFromRenderWindow,{texture,renderWindow,offset})
end procedure

public constant xsfTexture_setSmooth = define_c_proc(gfx,"+sfTexture_setSmooth",{C_POINTER,C_BOOL})

public procedure sfTexture_setSmooth(atom texture,atom smooth)
	c_proc(xsfTexture_setSmooth,{texture,smooth})
end procedure

public constant xsfTexture_isSmooth = define_c_func(gfx,"+sfTexture_isSmooth",{C_POINTER},C_BOOL)

public function sfTexture_isSmooth(atom texture)
	return c_func(xsfTexture_isSmooth,{texture})
end function

public constant xsfTexture_isSrgb = define_c_func(gfx,"+sfTexture_isSrgb",{C_POINTER},C_BOOL)

public function sfTexture_isSrgb(atom texture)
	return c_func(xsfTexture_isSrgb,{texture})
end function

public constant xsfTexture_setRepeated = define_c_proc(gfx,"+sfTexture_setRepeated",{C_POINTER,C_BOOL})

public procedure sfTexture_setRepeated(atom texture,atom repeated)
	c_proc(xsfTexture_setRepeated,{texture,repeated})
end procedure

public constant xsfTexture_isRepeated = define_c_func(gfx,"+sfTexture_isRepeated",{C_POINTER},C_BOOL)

public function sfTexture_isRepeated(atom texture)
	return c_func(xsfTexture_isRepeated,{texture})
end function

public constant xsfTexture_generateMipmap = define_c_func(gfx,"+sfTexture_generateMipmap",{C_POINTER},C_BOOL)

public function sfTexture_generateMipmap(atom texture)
	return c_func(xsfTexture_generateMipmap,{texture})
end function

public constant xsfTexture_swap = define_c_proc(gfx,"+sfTexture_swap",{C_POINTER,C_POINTER})

public procedure sfTexture_swap(atom left,atom right)
	c_proc(xsfTexture_swap,{left,right})
end procedure

public constant xsfTexture_getNativeHandle = define_c_func(gfx,"+sfTexture_getNativeHandle",{C_POINTER},C_UINT)

public function sfTexture_getNativeHandle(atom texture)
	return c_func(xsfTexture_getNativeHandle,{texture})
end function

public constant xsfTexture_bind = define_c_proc(gfx,"+sfTexture_bind",{C_POINTER,C_INT})

public procedure sfTexture_bind(atom texture,sfCoordinateType ctype)
	c_proc(xsfTexture_bind,{texture,ctype})
end procedure

public constant xsfTexture_getMaximumSize = define_c_func(gfx,"+sfTexture_getMaximumSize",{},C_UINT)

public function sfTexture_getMaximumSize()
	return c_func(xsfTexture_getMaximumSize,{})
end function

--Transformable

public constant xsfTransformable_create = define_c_func(gfx,"+sfTransformable_create",{},C_POINTER)

public function sfTransformable_create()
	return c_func(xsfTransformable_create,{})
end function

public constant xsfTransformable_copy = define_c_func(gfx,"+sfTransformable_copy",{C_POINTER},C_POINTER)

public function sfTransformable_copy(atom trans)
	return c_func(xsfTransformable_copy,{trans})
end function

public constant xsfTransformable_destroy = define_c_proc(gfx,"+sfTransformable_destroy",{C_POINTER})

public procedure sfTransformable_destroy(atom trans)
	c_proc(xsfTransformable_destroy,{trans})
end procedure

public constant xsfTransformable_setPosition = define_c_proc(gfx,"+sfTransformable_setPosition",{C_POINTER,sfVector2f})

public procedure sfTransformable_setPosition(atom trans,sequence pos)
	c_proc(xsfTransformable_setPosition,{trans,pos})
end procedure

public constant xsfTransformable_setRotation = define_c_proc(gfx,"+sfTransformable_setRotation",{C_POINTER,C_FLOAT})

public procedure sfTransformable_setRotation(atom trans,atom angle)
	c_proc(xsfTransformable_setRotation,{trans,angle})
end procedure

public constant xsfTransformable_setScale = define_c_proc(gfx,"+sfTransformable_setScale",{C_POINTER,sfVector2f})

public procedure sfTransformable_setScale(atom trans,sequence scale)
	c_proc(xsfTransformable_setScale,{trans,scale})
end procedure

public constant xsfTransformable_setOrigin = define_c_proc(gfx,"+sfTransformable_setOrigin",{C_POINTER,sfVector2f})

public procedure sfTransformable_setOrigin(atom trans,sequence origin)
	c_proc(xsfTransformable_setOrigin,{trans,origin})
end procedure

public constant xsfTransformable_getPosition = define_c_func(gfx,"+sfTransformable_getPosition",{C_POINTER},sfVector2f)

public function sfTransformable_getPosition(atom trans)
	return c_func(xsfTransformable_getPosition,{trans})
end function

public constant xsfTransformable_getRotation = define_c_func(gfx,"+sfTransformable_getRotation",{C_POINTER},C_FLOAT)

public function sfTransformable_getRotation(atom trans)
	return c_func(xsfTransformable_getRotation,{trans})
end function

public constant xsfTransformable_getScale = define_c_func(gfx,"+sfTransformable_getScale",{C_POINTER},sfVector2f)

public function sfTransformable_getScale(atom trans)
	return c_func(xsfTransformable_getScale,{trans})
end function

public constant xsfTransformable_getOrigin = define_c_func(gfx,"+sfTransformable_getOrigin",{C_POINTER},sfVector2f)

public function sfTransformable_getOrigin(atom trans)
	return c_func(xsfTransformable_getOrigin,{trans})
end function

public constant xsfTransformable_move = define_c_proc(gfx,"+sfTransformable_move",{C_POINTER,sfVector2f})

public procedure sfTransformable_move(atom trans,sequence offset)
	c_proc(xsfTransformable_move,{trans,offset})
end procedure

public constant xsfTransformable_rotate = define_c_proc(gfx,"+sfTransformable_rotate",{C_POINTER,C_FLOAT})

public procedure sfTransformable_rotate(atom trans,atom angle)
	c_proc(xsfTransformable_rotate,{trans,angle})
end procedure

public constant xsfTransformable_scale = define_c_proc(gfx,"+sfTransformable_scale",{C_POINTER,sfVector2f})

public procedure sfTransformable_scale(atom trans,sequence factors)
	c_proc(xsfTransformable_scale,{trans,factors})
end procedure

public constant xsfTransformable_getTransform = define_c_func(gfx,"+sfTransformable_getTransform",{C_POINTER},sfTransform)

public function sfTransformable_getTransform(atom trans)
	return c_func(xsfTransformable_getTransform,{trans})
end function

public constant xsfTransformable_getInverseTransform = define_c_func(gfx,"+sfTransformable_getInverseTransform",{C_POINTER},sfTransform)

public function sfTransformable_getInverseTransform(atom trans)
	return c_func(xsfTransformable_getInverseTransform,{trans})
end function

--VertexArray

public constant xsfVertexArray_create = define_c_func(gfx,"+sfVertexArray_create",{},C_POINTER)

public function sfVertexArray_create()
	return c_func(xsfVertexArray_create,{})
end function

public constant xsfVertexArray_copy = define_c_func(gfx,"+sfVertexArray_copy",{C_POINTER},C_POINTER)

public function sfVertexArray_copy(atom va)
	return c_func(xsfVertexArray_copy,{va})
end function

public constant xsfVertexArray_destroy = define_c_proc(gfx,"+sfVertexArray_destroy",{C_POINTER})

public procedure sfVertexArray_destroy(atom va)
	c_proc(xsfVertexArray_destroy,{va})
end procedure

public constant xsfVertexArray_getVertexCount = define_c_func(gfx,"+sfVertexArray_getVertexCount",{C_POINTER},C_SIZE_T)

public function sfVertexArray_getVertexCount(atom va)
	return c_func(xsfVertexArray_getVertexCount,{va})
end function

public constant xsfVertexArray_getVertex = define_c_func(gfx,"+sfVertexArray_getVertex",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfVertexArray_getVertex(atom va,atom index)
	return c_func(xsfVertexArray_getVertex,{va,index})
end function

public constant xsfVertexArray_clear = define_c_proc(gfx,"+sfVertexArray_clear",{C_POINTER})

public procedure sfVertexArray_clear(atom va)
	c_proc(xsfVertexArray_clear,{va})
end procedure

public constant xsfVertexArray_resize = define_c_proc(gfx,"+sfVertexArray_resize",{C_POINTER,C_SIZE_T})

public procedure sfVertexArray_resize(atom va,atom count)
	c_proc(xsfVertexArray_resize,{va,count})
end procedure

public constant xsfVertexArray_append = define_c_proc(gfx,"+sfVertexArray_append",{C_POINTER,sfVertex})

public procedure sfVertexArray_append(atom va,sequence vertex)
	c_proc(xsfVertexArray_append,{va,vertex})
end procedure

public constant xsfVertexArray_setPrimitiveType = define_c_proc(gfx,"+sfVertexArray_setPrimitiveType",{C_POINTER,C_INT})

public procedure sfVertexArray_setPrimitiveType(atom va,sfPrimitiveType ptype)
	c_proc(xsfVertexArray_setPrimitiveType,{va,ptype})
end procedure

public constant xsfVertexArray_getPrimitiveType = define_c_func(gfx,"+sfVertexArray_getPrimitiveType",{C_POINTER},C_INT)

public function sfVertexArray_getPrimitiveType(atom va)
	return c_func(xsfVertexArray_getPrimitiveType,{va})
end function

public constant xsfVertexArray_getBounds = define_c_func(gfx,"+sfVertexArray_getBounds",{C_POINTER},sfFloatRect)

public function sfVertexArray_getBounds(atom va)
	return c_func(xsfVertexArray_getBounds,{va})
end function

--VertexBuffer

public enum type sfVertexBufferUsage
	sfVertexBufferStream = 0, -- Constantly changing data
	sfVertexBufferDynamic, --Occasionally changing data
	sfVertexBufferStatic --Rarely changing data
end type

public constant xsfVertexBuffer_create = define_c_func(gfx,"+sfVertexBuffer_create",{C_SIZE_T,C_INT,C_INT},C_POINTER)

public function sfVertexBuffer_create(atom count,sfPrimitiveType ptype,sfVertexBufferUsage usage)
	return c_func(xsfVertexBuffer_create,{count,ptype,usage})
end function

public constant xsfVertexBuffer_copy = define_c_func(gfx,"+sfVertexBuffer_copy",{C_POINTER},C_POINTER)

public function sfVertexBuffer_copy(atom vb)
	return c_func(xsfVertexBuffer_copy,{vb})
end function

public constant xsfVertexBuffer_destroy = define_c_proc(gfx,"+sfVertexBuffer_destroy",{C_POINTER})

public procedure sfVertexBuffer_destroy(atom vb)
	c_proc(xsfVertexBuffer_destroy,{vb})
end procedure

public constant xsfVertexBuffer_getVertexCount = define_c_func(gfx,"+sfVertexBuffer_getVertexCount",{C_POINTER},C_SIZE_T)

public function sfVertexBuffer_getVertexCount(atom vb)
	return c_func(xsfVertexBuffer_getVertexCount,{vb})
end function

public constant xsfVertexBuffer_update = define_c_func(gfx,"+sfVertexBuffer_update",{C_POINTER,C_POINTER,C_UINT,C_UINT},C_BOOL)

public function sfVertexBuffer_update(atom vb,atom vertices,atom count,atom offset)
	return c_func(xsfVertexBuffer_update,{vb,vertices,count,offset})
end function

public constant xsfVertexBuffer_updateFromVertexBuffer = define_c_func(gfx,"+sfVertexBuffer_updateFromVertexBuffer",{C_POINTER,C_POINTER},C_BOOL)

public function sfVertexBuffer_updateFromVertexBuffer(atom vb,atom other)
	return c_func(xsfVertexBuffer_updateFromVertexBuffer,{vb,other})
end function

public constant xsfVertexBuffer_swap = define_c_proc(gfx,"+sfVertexBuffer_swap",{C_POINTER,C_POINTER})

public procedure sfVertexBuffer_swap(atom left,atom right)
	c_proc(xsfVertexBuffer_swap,{left,right})
end procedure

public constant xsfVertexBuffer_getNativeHandle = define_c_func(gfx,"+sfVertexBuffer_getNativeHandle",{C_POINTER},C_UINT)

public function sfVertexBuffer_getNativeHandle(atom vb)
	return c_func(xsfVertexBuffer_getNativeHandle,{vb})
end function

public constant xsfVertexBuffer_setPrimitiveType = define_c_proc(gfx,"+sfVertexBuffer_setPrimitiveType",{C_POINTER,C_INT})

public procedure sfVertexBuffer_setPrimitiveType(atom vb,sfPrimitiveType ptype)
	c_proc(xsfVertexBuffer_setPrimitiveType,{vb,ptype})
end procedure

public constant xsfVertexBuffer_getPrimitiveType = define_c_func(gfx,"+sfVertexBuffer_getPrimitiveType",{C_POINTER},C_INT)

public function sfVertexBuffer_getPrimitiveType(atom vb)
	return c_func(xsfVertexBuffer_getPrimitiveType,{vb})
end function

public constant xsfVertexBuffer_setUsage = define_c_proc(gfx,"+sfVertexBuffer_setUsage",{C_POINTER,C_INT})

public procedure sfVertexBuffer_setUsage(atom vb,sfVertexBufferUsage usage)
	c_proc(xsfVertexBuffer_setUsage,{vb,usage})
end procedure

public constant xsfVertexBuffer_getUsage = define_c_func(gfx,"+sfVertexBuffer_getUsage",{C_POINTER},C_INT)

public function sfVertexBuffer_getUsage(atom vb)
	return c_func(xsfVertexBuffer_getUsage,{vb})
end function

public constant xsfVertexBuffer_bind = define_c_proc(gfx,"+sfVertexBuffer_bind",{C_POINTER})

public procedure sfVertexBuffer_bind(atom vb)
	c_proc(xsfVertexBuffer_bind,{vb})
end procedure

public constant xsfVertexBuffer_isAvailable = define_c_func(gfx,"+sfVertexBuffer_isAvailable",{},C_BOOL)

public function sfVertexBuffer_isAvailable()
	return c_func(xsfVertexBuffer_isAvailable,{})
end function

--View

public constant xsfView_create = define_c_func(gfx,"+sfView_create",{},C_POINTER)

public function sfView_create()
	return c_func(xsfView_create,{})
end function

public constant xsfView_createFromRect = define_c_func(gfx,"+sfView_createFromRect",{sfFloatRect},C_POINTER)

public function sfView_createFromRect(sequence rect)
	return c_func(xsfView_createFromRect,{rect})
end function

public constant xsfView_copy = define_c_func(gfx,"+sfView_copy",{C_POINTER},C_POINTER)

public function sfView_copy(atom view)
	return c_func(xsfView_copy,{view})
end function

public constant xsfView_destroy = define_c_proc(gfx,"+sfView_destroy",{C_POINTER})

public procedure sfView_destroy(atom view)
	c_proc(xsfView_destroy,{view})
end procedure

public constant xsfView_setCenter = define_c_proc(gfx,"+sfView_setCenter",{C_POINTER,sfVector2f})

public procedure sfView_setCenter(atom view,sequence center)
	c_proc(xsfView_setCenter,{view,center})
end procedure

public constant xsfView_setSize = define_c_proc(gfx,"+sfView_setSize",{C_POINTER,sfVector2f})

public procedure sfView_setSize(atom view,sequence size)
	c_proc(xsfView_setSize,{view,size})
end procedure

public constant xsfView_setRotation = define_c_proc(gfx,"+sfView_setRotation",{C_POINTER,C_FLOAT})

public procedure sfView_setRotation(atom view,atom angle)
	c_proc(xsfView_setRotation,{view,angle})
end procedure

public constant xsfView_setViewport = define_c_proc(gfx,"+sfView_setViewport",{C_POINTER,sfFloatRect})

public procedure sfView_setViewport(atom view,sequence viewport)
	c_proc(xsfView_setViewport,{view,viewport})
end procedure

public constant xsfView_setScissor = define_c_proc(gfx,"+sfView_setScissor",{C_POINTER,sfFloatRect})

public procedure sfView_setScissor(atom view,sequence scissor)
	c_proc(xsfView_setScissor,{view,scissor})
end procedure

public constant xsfView_getCenter = define_c_func(gfx,"+sfView_getCenter",{C_POINTER},sfVector2f)

public function sfView_getCenter(atom view)
	return c_func(xsfView_getCenter,{view})
end function

public constant xsfView_getSize = define_c_func(gfx,"+sfView_getSize",{C_POINTER},sfVector2f)

public function sfView_getSize(atom view)
	return c_func(xsfView_getSize,{view})
end function

public constant xsfView_getRotation = define_c_func(gfx,"+sfView_getRotation",{C_POINTER},C_FLOAT)

public function sfView_getRotation(atom view)
	return c_func(xsfView_getRotation,{view})
end function

public constant xsfView_getViewport = define_c_func(gfx,"+sfView_getViewport",{C_POINTER},sfFloatRect)

public function sfView_getViewport(atom view)
	return c_func(xsfView_getViewport,{view})
end function

public constant xsfView_getScissor = define_c_func(gfx,"+sfView_getScissor",{C_POINTER},sfFloatRect)

public function sfView_getScissor(atom view)
	return c_func(xsfView_getScissor,{view})
end function

public constant xsfView_move = define_c_proc(gfx,"+sfView_move",{C_POINTER,sfVector2f})

public procedure sfView_move(atom view,sequence offset)
	c_proc(xsfView_move,{view,offset})
end procedure

public constant xsfView_rotate = define_c_proc(gfx,"+sfView_rotate",{C_POINTER,C_FLOAT})

public procedure sfView_rotate(atom view,atom angle)
	c_proc(xsfView_rotate,{view,angle})
end procedure

public constant xsfView_zoom = define_c_proc(gfx,"+sfView_zoom",{C_POINTER,C_FLOAT})

public procedure sfView_zoom(atom view,atom factor)
	c_proc(xsfView_zoom,{view,factor})
end procedure
­3094.26