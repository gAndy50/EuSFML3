--EuSFML System 3
--Written by Andy P.
--Copyright (c) 2026
include std/ffi.e
include std/machine.e
include std/os.e

public atom sys

ifdef WINDOWS then
	sys = open_dll("csfml-system-3.dll")
	elsifdef LINUX or FREEBSD then
	sys = open_dll("libcsfml-system-3.so")
	elsifdef OSX then
	sys = open_dll("libcsfml-system-3.dylib")
end ifdef

if sys = -1 then
	puts(1,"Failed to load csfml-system!\n")
	abort(0)
end if

--printf(1,"%d",{sys})

--Vector2
public constant sfVector2i = define_c_struct({
	C_INT, --x
	C_INT  --y
})

public constant sfVector2u = define_c_struct({
	C_UINT, --x
	C_UINT  --y
})

public constant sfVector2f = define_c_struct({
	C_FLOAT, --x
	C_FLOAT  --y
})

--Vector3

public constant sfVector3f = define_c_struct({
	C_FLOAT, --x
	C_FLOAT, --y
	C_FLOAT  --z
})

--Alloc

public constant xsfFree = define_c_proc(sys,"+sfFree",{C_POINTER})

public procedure sfFree(atom ptr)
	c_proc(xsfFree,{ptr})
end procedure

--Time
public constant sfTime = define_c_struct({
	C_INT64 --mircoseconds
})

public constant sfTime_Zero = 0

public constant xsfTime_asSeconds = define_c_func(sys,"+sfTime_asSeconds",{sfTime},C_FLOAT)

public function sfTime_asSeconds(sequence xtime)
	return c_func(xsfTime_asSeconds,{xtime})
end function

public constant xsfTime_asMilliseconds = define_c_func(sys,"+sfTime_asMilliseconds",{sfTime},C_INT32)

public function sfTime_asMilliseconds(sequence xtime)
	return c_func(xsfTime_asMilliseconds,{xtime})
end function

public constant xsfTime_asMicroseconds = define_c_func(sys,"+sfTime_asMicroseconds",{sfTime},C_INT64)

public function sfTime_asMicroseconds(sequence xtime)
	return c_func(xsfTime_asMicroseconds,{xtime})
end function

public constant xsfSeconds = define_c_func(sys,"+sfSeconds",{C_FLOAT},sfTime)

public function sfSeconds(atom amount)
	return c_func(xsfSeconds,{amount})
end function

public constant xsfMilliseconds = define_c_func(sys,"+sfMilliseconds",{C_INT32},sfTime)

public function sfMilliseconds(atom amount)
	return c_func(xsfMilliseconds,{amount})
end function

public constant xsfMicroseconds = define_c_func(sys,"+sfMicroseconds",{C_INT64},sfTime)

public function sfMicroseconds(atom amount)
	return c_func(xsfMicroseconds,{amount})
end function

--Buffer

public constant xsfBuffer_create = define_c_func(sys,"+sfBuffer_create",{},C_POINTER)

public function sfBuffer_create()
	return c_func(xsfBuffer_create,{})
end function

public constant xsfBuffer_destroy = define_c_proc(sys,"+sfBuffer_destroy",{C_POINTER})

public procedure sfBuffer_destroy(atom buffer)
	c_proc(xsfBuffer_destroy,{buffer})
end procedure

public constant xsfBuffer_getSize = define_c_func(sys,"+sfBuffer_getSize",{C_POINTER},C_SIZE_T)

public function sfBuffer_getSize(atom buffer)
	return c_func(xsfBuffer_getSize,{buffer})
end function

public constant xsfBuffer_getData = define_c_func(sys,"+sfBuffer_getData",{C_POINTER},C_POINTER)

public function sfBuffer_getData(atom buffer)
	return c_func(xsfBuffer_getData,{buffer})
end function

--Inputstream
public constant sfInputStream = define_c_struct({
	C_POINTER, --read
	C_POINTER, --seek
	C_POINTER, --tell
	C_POINTER, --getSize
	C_POINTER  --userData
})

--Sleep
public constant xsfSleep = define_c_proc(sys,"+sfSleep",{sfTime})

public procedure sfSleep(sequence duration)
	c_proc(xsfSleep,{duration})
end procedure

--Clock
public constant xsfClock_create = define_c_func(sys,"+sfClock_create",{},C_POINTER)

public function sfClock_create()
	return c_func(xsfClock_create,{})
end function

public constant xsfClock_copy = define_c_func(sys,"+sfClock_copy",{C_POINTER},C_POINTER)

public function sfClock_copy(atom clock)
	return c_func(xsfClock_copy,{clock})
end function

public constant xsfClock_destroy = define_c_proc(sys,"+sfClock_destroy",{C_POINTER})

public procedure sfClock_destroy(atom clock)
	c_proc(xsfClock_destroy,{clock})
end procedure

public constant xsfClock_getElapsedTime = define_c_func(sys,"+sfClock_getElapsedTime",{C_POINTER},sfTime)

public function sfClock_getElapsedTime(atom clock)
	return c_func(xsfClock_getElapsedTime,{clock})
end function

public constant xsfClock_isRunning = define_c_func(sys,"+sfClock_isRunning",{C_POINTER},C_BOOL)

public function sfClock_isRunning(atom clock)
	return c_func(xsfClock_isRunning,{clock})
end function

public constant xsfClock_start = define_c_proc(sys,"+sfClock_start",{C_POINTER})

public procedure sfClock_start(atom clock)
	c_proc(xsfClock_start,{clock})
end procedure

public constant xsfClock_stop = define_c_proc(sys,"+sfClock_stop",{C_POINTER})

public procedure sfClock_stop(atom clock)
	c_proc(xsfClock_stop,{clock})
end procedure

public constant xsfClock_restart = define_c_func(sys,"+sfClock_restart",{C_POINTER},sfTime)

public function sfClock_restart(atom clock)
	return c_func(xsfClock_restart,{clock})
end function

public constant xsfClock_reset = define_c_func(sys,"+sfClock_reset",{C_POINTER},sfTime)

public function sfClock_reset(atom clock)
	return c_func(xsfClock_reset,{clock})
end function
­3.20