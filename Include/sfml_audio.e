--EuSFML Audio 3
--Written by Andy P.
--Copyright (c) 2026
include std/ffi.e
include std/machine.e
include std/os.e

public atom aud

public include sfml_system.e
public include sfml_window.e

ifdef WINDOWS then
	aud = open_dll("sfml-audio-3.dll")
	elsifdef LINUX or FREEBSD then
	aud = open_dll("libsfml-audio-3.so")
	elsifdef OSX then
	aud = open_dll("libcsfml-audio-3.dylib")
end ifdef

if aud = -1 then
	puts(1,"Failed to load sfml-audio-3!\n")
	abort(0)
end if

--SoundStatus

public enum type sfSoundStatus
	sfStopped = 0,
	sfPaused,
	sfPlaying
end type

--sfSoundSourceCone
public constant sfSoundSourceCone = define_c_struct({
	C_FLOAT, --innerAngle
	C_FLOAT, --outerAngle
	C_FLOAT  --outerGain
})

--SoundChannel
public enum type sfSoundChannel
	sfSoundChannelUnspecified = 0,
    sfSoundChannelMono,
    sfSoundChannelFrontLeft,
    sfSoundChannelFrontRight,
    sfSoundChannelFrontCenter,
    sfSoundChannelFrontLeftOfCenter,
    sfSoundChannelFrontRightOfCenter,
    sfSoundChannelLowFrequencyEffects,
    sfSoundChannelBackLeft,
    sfSoundChannelBackRight,
    sfSoundChannelBackCenter,
    sfSoundChannelSideLeft,
    sfSoundChannelSideRight,
    sfSoundChannelTopCenter,
    sfSoundChannelTopFrontLeft,
    sfSoundChannelTopFrontRight,
    sfSoundChannelTopFrontCenter,
    sfSoundChannelTopBackLeft,
    sfSoundChannelTopBackRight,
    sfSoundChannelTopBackCenter
end type

--Listener

public constant sfListenerCone = define_c_struct({
	C_FLOAT, --innerAngle
	C_FLOAT, --outerAngle
	C_FLOAT  --outerGain
})

public constant xsfListener_setGlobalVolume = define_c_proc(aud,"+sfListener_setGlobalVolume",{C_FLOAT})

public procedure sfListener_setGlobalVolume(atom volume)
	c_proc(xsfListener_setGlobalVolume,{volume})
end procedure

public constant xsfListener_getGlobalVolume = define_c_func(aud,"+sfListener_getGlobalVolume",{},C_FLOAT)

public function sfListener_getGlobalVolume()
	return c_func(xsfListener_getGlobalVolume,{})
end function

public constant xsfListener_setPosition = define_c_proc(aud,"+sfListener_setPosition",{sfVector3f})

public procedure sfListener_setPosition(sequence pos)
	c_proc(xsfListener_setPosition,{pos})
end procedure

public constant xsfListener_getPosition = define_c_func(aud,"+sfListener_getPosition",{},sfVector3f)

public function sfListener_getPosition()
	return c_func(xsfListener_getPosition,{})
end function

public constant xsfListener_setDirection = define_c_proc(aud,"+sfListener_setDirection",{sfVector3f})

public procedure sfListener_setDirection(sequence direction)
	c_proc(xsfListener_setDirection,{direction})
end procedure

public constant xsfListener_getDirection = define_c_func(aud,"+sfListener_getDirection",{},sfVector3f)

public function sfListener_getDirection()
	return c_func(xsfListener_getDirection,{})
end function

public constant xsfListener_setVelocity = define_c_proc(aud,"+sfListener_setVelocity",{sfVector3f})

public procedure sfListener_setVelocity(sequence velocity)
	c_proc(xsfListener_setVelocity,{velocity})
end procedure

public constant xsfListener_getVelocity = define_c_func(aud,"+sfListener_getVelocity",{},sfVector3f)

public function sfListener_getVelocity()
	return c_func(xsfListener_getVelocity,{})
end function

public constant xsfListener_setCone = define_c_proc(aud,"+sfListener_setCone",{sfListenerCone})

public procedure sfListener_setCone(sequence cone)
	c_proc(xsfListener_setCone,{cone})
end procedure

public constant xsfListener_getCone = define_c_func(aud,"+sfListener_getCone",{},sfListenerCone)

public function sfListener_getCone()
	return c_func(xsfListener_getCone,{})
end function

public constant xsfListener_setUpVector = define_c_proc(aud,"+sfListener_setUpVector",{sfVector3f})

public procedure sfListener_setUpVector(sequence upVector)
	c_proc(xsfListener_setUpVector,{upVector})
end procedure

public constant xsfListener_getUpVector = define_c_func(aud,"+sfListener_getUpVector",{},sfVector3f)

public function sfListener_getUpVector()
	return c_func(xsfListener_getUpVector,{})
end function

--Music

public constant sfTimeSpan = define_c_struct({
	sfTime, --offset
	sfTime  --length
})

public constant xsfMusic_createFromFile = define_c_func(aud,"+sfMusic_createFromFile",{C_STRING},C_POINTER)

public function sfMusic_createFromFile(sequence fname)
	return c_func(xsfMusic_createFromFile,{fname})
end function

public constant xsfMusic_createFromMemory = define_c_func(aud,"+sfMusic_createFromMemory",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfMusic_createFromMemory(atom data,atom size)
	return c_func(xsfMusic_createFromMemory,{data,size})
end function

public constant xsfMusic_createFromStream = define_c_func(aud,"+sfMusic_createFromStream",{C_POINTER},C_POINTER)

public function sfMusic_createFromStream(atom stream)
	return c_func(xsfMusic_createFromStream,{stream})
end function

public constant xsfMusic_destroy = define_c_proc(aud,"+sfMusic_destroy",{C_POINTER})

public procedure sfMusic_destroy(atom music)
	c_proc(xsfMusic_destroy,{music})
end procedure

public constant xsfMusic_setLooping = define_c_proc(aud,"+sfMusic_setLooping",{C_POINTER,C_BOOL})

public procedure sfMusic_setLooping(atom music,atom xloop)
	c_proc(xsfMusic_setLooping,{music,xloop})
end procedure

public constant xsfMusic_isLooping = define_c_func(aud,"+sfMusic_isLooping",{C_POINTER},C_BOOL)

public function sfMusic_isLooping(atom music)
	return c_func(xsfMusic_isLooping,{music})
end function

public constant xsfMusic_setEffectProcessor = define_c_proc(aud,"+sfMusic_setEffectProcessor",{C_POINTER,C_POINTER})

public procedure sfMusic_setEffectProcessor(atom music,object effectProcessor)
	c_proc(xsfMusic_setEffectProcessor,{music,effectProcessor})
end procedure

public constant xsfMusic_getDuration = define_c_func(aud,"+sfMusic_getDuration",{C_POINTER},sfTime)

public function sfMusic_getDuration(atom music)
	return c_func(xsfMusic_getDuration,{music})
end function

public constant xsfMusic_getLoopPoints = define_c_func(aud,"+sfMusic_getLoopPoints",{C_POINTER},sfTimeSpan)

public function sfMusic_getLoopPoints(atom music)
	return c_func(xsfMusic_getLoopPoints,{music})
end function

public constant xsfMusic_setLoopPoints = define_c_proc(aud,"+sfMusic_setLoopPoints",{C_POINTER,sfTimeSpan})

public procedure sfMusic_setLoopPoints(atom music,sequence timePoints)
	c_proc(xsfMusic_setLoopPoints,{music,timePoints})
end procedure

public constant xsfMusic_play = define_c_proc(aud,"+sfMusic_play",{C_POINTER})

public procedure sfMusic_play(atom music)
	c_proc(xsfMusic_play,{music})
end procedure

public constant xsfMusic_pause = define_c_proc(aud,"+sfMusic_pause",{C_POINTER})

public procedure sfMusic_pause(atom music)
	c_proc(xsfMusic_pause,{music})
end procedure

public constant xsfMusic_stop = define_c_proc(aud,"+sfMusic_stop",{C_POINTER})

public procedure sfMusic_stop(atom music)
	c_proc(xsfMusic_stop,{music})
end procedure

public constant xsfMusic_getChannelCount = define_c_func(aud,"+sfMusic_getChannelCount",{C_POINTER},C_UINT)

public function sfMusic_getChannelCount(atom music)
	return c_func(xsfMusic_getChannelCount,{music})
end function

public constant xsfMusic_getSampleRate = define_c_func(aud,"+sfMusic_getSampleRate",{C_POINTER},C_UINT)

public function sfMusic_getSampleRate(atom music)
	return c_func(xsfMusic_getSampleRate,{music})
end function

public constant xsfMusic_getChannelMap = define_c_func(aud,"+sfMusic_getChannelMap",{C_POINTER,C_POINTER},C_POINTER)

public function sfMusic_getChannelMap(atom music,atom count)
	return c_func(xsfMusic_getChannelMap,{music,count})
end function

public constant xsfMusic_getStatus = define_c_func(aud,"+sfMusic_getStatus",{C_POINTER},C_INT)

public function sfMusic_getStatus(atom music)
	return c_func(xsfMusic_getStatus,{music})
end function

public constant xsfMusic_getPlayingOffset = define_c_func(aud,"+sfMusic_getPlayingOffset",{C_POINTER},sfTime)

public function sfMusic_getPlayingOffset(atom music)
	return c_func(xsfMusic_getPlayingOffset,{music})
end function

public constant xsfMusic_setPitch = define_c_proc(aud,"+sfMusic_setPitch",{C_POINTER,C_FLOAT})

public procedure sfMusic_setPitch(atom music,atom pitch)
	c_proc(xsfMusic_setPitch,{music,pitch})
end procedure

public constant xsfMusic_setPan = define_c_proc(aud,"+sfMusic_setPan",{C_POINTER,C_FLOAT})

public procedure sfMusic_setPan(atom music,atom pan)
	c_proc(xsfMusic_setPan,{music,pan})
end procedure

public constant xsfMusic_setVolume = define_c_proc(aud,"+sfMusic_setVolume",{C_POINTER,C_FLOAT})

public procedure sfMusic_setVolume(atom music,atom volume)
	c_proc(xsfMusic_setVolume,{music,volume})
end procedure

public constant xsfMusic_setSpatializationEnabled = define_c_proc(aud,"+sfMusic_setSpatializationEnabled",{C_POINTER,C_BOOL})

public procedure sfMusic_setSpatializationEnabled(atom music,atom enabled)
	c_proc(xsfMusic_setSpatializationEnabled,{music,enabled})
end procedure

public constant xsfMusic_setPosition = define_c_proc(aud,"+sfMusic_setPosition",{C_POINTER,sfVector3f})

public procedure sfMusic_setPosition(atom music,sequence pos)
	c_proc(xsfMusic_setPosition,{music,pos})
end procedure

public constant xsfMusic_setDirection = define_c_proc(aud,"+sfMusic_setDirection",{C_POINTER,sfVector3f})

public procedure sfMusic_setDirection(atom music,sequence direction)
	c_proc(xsfMusic_setDirection,{music,direction})
end procedure

public constant xsfMusic_setCone = define_c_proc(aud,"+sfMusic_setCone",{C_POINTER,sfSoundSourceCone})

public procedure sfMusic_setCone(atom music,sequence cone)
	c_proc(xsfMusic_setCone,{music,cone})
end procedure

public constant xsfMusic_setVelocity = define_c_proc(aud,"+sfMusic_setVelocity",{C_POINTER,sfVector3f})

public procedure sfMusic_setVelocity(atom music,sequence velocity)
	c_proc(xsfMusic_setVelocity,{music,velocity})
end procedure

public constant xsfMusic_setDopplerFactor = define_c_proc(aud,"+sfMusic_setDopplerFactor",{C_POINTER,C_FLOAT})

public procedure sfMusic_setDopplerFactor(atom music,atom factor)
	c_proc(xsfMusic_setDopplerFactor,{music,factor})
end procedure

public constant xsfMusic_setDirectionalAttenuationFactor = define_c_proc(aud,"+sfMusic_setDirectionalAttenuationFactor",{C_POINTER,C_FLOAT})

public procedure sfMusic_setDirectionalAttenuationFactor(atom music,atom factor)
	c_proc(xsfMusic_setDirectionalAttenuationFactor,{music,factor})
end procedure

public constant xsfMusic_setRelativeToListener = define_c_proc(aud,"+sfMusic_setRelativeToListener",{C_POINTER,C_BOOL})

public procedure sfMusic_setRelativeToListener(atom music,atom relative)
	c_proc(xsfMusic_setRelativeToListener,{music,relative})
end procedure

public constant xsfMusic_setMinDistance = define_c_proc(aud,"+sfMusic_setMinDistance",{C_POINTER,C_FLOAT})

public procedure sfMusic_setMinDistance(atom music,atom distance)
	c_proc(xsfMusic_setMinDistance,{music,distance})
end procedure

public constant xsfMusic_setMaxDistance = define_c_proc(aud,"+sfMusic_setMaxDistance",{C_POINTER,C_FLOAT})

public procedure sfMusic_setMaxDistance(atom music,atom distance)
	c_proc(xsfMusic_setMaxDistance,{music,distance})
end procedure

public constant xsfMusic_setMinGain = define_c_proc(aud,"+sfMusic_setMinGain",{C_POINTER,C_FLOAT})

public procedure sfMusic_setMinGain(atom music,atom gain)
	c_proc(xsfMusic_setMinGain,{music,gain})
end procedure

public constant xsfMusic_setMaxGain = define_c_proc(aud,"+sfMusic_setMaxGain",{C_POINTER,C_FLOAT})

public procedure sfMusic_setMaxGain(atom music,atom gain)
	c_proc(xsfMusic_setMaxGain,{music,gain})
end procedure

public constant xsfMusic_setAttenuation = define_c_proc(aud,"+sfMusic_setAttenuation",{C_POINTER,C_FLOAT})

public procedure sfMusic_setAttenuation(atom music,atom attenuation)
	c_proc(xsfMusic_setAttenuation,{music,attenuation})
end procedure

public constant xsfMusic_setPlayingOffset = define_c_proc(aud,"+sfMusic_setPlayingOffset",{C_POINTER,sfTime})

public procedure sfMusic_setPlayingOffset(atom music,sequence timeOffset)
	c_proc(xsfMusic_setPlayingOffset,{music,timeOffset})
end procedure

public constant xsfMusic_getPitch = define_c_func(aud,"+sfMusic_getPitch",{C_POINTER},C_FLOAT)

public function sfMusic_getPitch(atom music)
	return c_func(xsfMusic_getPitch,{music})
end function

public constant xsfMusic_getPan = define_c_func(aud,"+sfMusic_getPan",{C_POINTER},C_FLOAT)

public function sfMusic_getPan(atom music)
	return c_func(xsfMusic_getPan,{music})
end function

public constant xsfMusic_isSpatializationEnabled = define_c_func(aud,"+sfMusic_isSpatializationEnabled",{C_POINTER},C_BOOL)

public function sfMusic_isSpatializationEnabled(atom music)
	return c_func(xsfMusic_isSpatializationEnabled,{music})
end function

public constant xsfMusic_getVolume = define_c_func(aud,"+sfMusic_getVolume",{C_POINTER},C_FLOAT)

public function sfMusic_getVolume(atom music)
	return c_func(xsfMusic_getVolume,{music})
end function

public constant xsfMusic_getPosition = define_c_func(aud,"+sfMusic_getPosition",{C_POINTER},sfVector3f)

public function sfMusic_getPosition(atom music)
	return c_func(xsfMusic_getPosition,{music})
end function

public constant xsfMusic_getDirection = define_c_func(aud,"+sfMusic_getDirection",{C_POINTER},sfVector3f)

public function sfMusic_getDirection(atom music)
	return c_func(xsfMusic_getDirection,{music})
end function

public constant xsfMusic_getCone = define_c_func(aud,"+sfMusic_getCone",{C_POINTER},sfSoundSourceCone)

public function sfMusic_getCone(atom music)
	return c_func(xsfMusic_getCone,{music})
end function

public constant xsfMusic_getVelocity = define_c_func(aud,"+sfMusic_getVelocity",{C_POINTER},sfVector3f)

public function sfMusic_getVelocity(atom music)
	return c_func(xsfMusic_getVelocity,{music})
end function

public constant xsfMusic_getDopplerFactor = define_c_func(aud,"+sfMusic_getDopplerFactor",{C_POINTER},C_FLOAT)

public function sfMusic_getDopplerFactor(atom music)
	return c_func(xsfMusic_getDopplerFactor,{music})
end function

public constant xsfMusic_getDirectionalAttenuationFactor = define_c_func(aud,"+sfMusic_getDirectionalAttenuationFactor",{C_POINTER},C_FLOAT)

public function sfMusic_getDirectionalAttenuationFactor(atom music)
	return c_func(xsfMusic_getDirectionalAttenuationFactor,{music})
end function

public constant xsfMusic_isRelativeToListener = define_c_func(aud,"+sfMusic_isRelativeToListener",{C_POINTER},C_BOOL)

public function sfMusic_isRelativeToListener(atom music)
	return c_func(xsfMusic_isRelativeToListener,{music})
end function

public constant xsfMusic_getMinDistance = define_c_func(aud,"+sfMusic_getMinDistance",{C_POINTER},C_FLOAT)

public function sfMusic_getMinDistance(atom music)
	return c_func(xsfMusic_getMinDistance,{music})
end function

public constant xsfMusic_getMaxDistance = define_c_func(aud,"+sfMusic_getMaxDistance",{C_POINTER},C_FLOAT)

public function sfMusic_getMaxDistance(atom music)
	return c_func(xsfMusic_getMaxDistance,{music})
end function

public constant xsfMusic_getMinGain = define_c_func(aud,"+sfMusic_getMinGain",{C_POINTER},C_FLOAT)

public function sfMusic_getMinGain(atom music)
	return c_func(xsfMusic_getMinGain,{music})
end function

public constant xsfMusic_getMaxGain = define_c_func(aud,"+sfMusic_getMaxGain",{C_POINTER},C_FLOAT)

public function sfMusic_getMaxGain(atom music)
	return c_func(xsfMusic_getMaxGain,{music})
end function

public constant xsfMusic_getAttenuation = define_c_func(aud,"+sfMusic_getAttenuation",{C_POINTER},C_FLOAT)

public function sfMusic_getAttenuation(atom music)
	return c_func(xsfMusic_getAttenuation,{music})
end function

--SoundStream

--TODO: SoundStream Callbacks

public constant sfSoundStreamChunk = define_c_struct({
	C_POINTER, --samples
	C_UINT     --sampleCount
})

public constant xsfSoundStream_create = define_c_func(aud,"+sfSoundStream_create",{C_POINTER,C_POINTER,C_UINT,C_UINT,C_POINTER,C_SIZE_T,C_POINTER},C_POINTER)

public function sfSoundStream_create(object onGetData,object onSeek,atom channelCount,atom sampleRate,atom channelMapData,atom channelMapSize,atom userData)
	return c_func(xsfSoundStream_create,{onGetData,onSeek,channelCount,sampleRate,channelMapData,channelMapSize,userData})
end function

public constant xsfSoundStream_destroy = define_c_proc(aud,"+sfSoundStream_destroy",{C_POINTER})

public procedure sfSoundStream_destroy(atom ss)
	c_proc(xsfSoundStream_destroy,{ss})
end procedure

public constant xsfSoundStream_play = define_c_proc(aud,"+sfSoundStream_play",{C_POINTER})

public procedure sfSoundStream_play(atom ss)
	c_proc(xsfSoundStream_play,{ss})
end procedure

public constant xsfSoundStream_pause = define_c_proc(aud,"+sfSoundStream_pause",{C_POINTER})

public procedure sfSoundStream_pause(atom ss)
	c_proc(xsfSoundStream_pause,{ss})
end procedure

public constant xsfSoundStream_stop = define_c_proc(aud,"+sfSoundStream_stop",{C_POINTER})

public procedure sfSoundStream_stop(atom ss)
	c_proc(xsfSoundStream_stop,{ss})
end procedure

public constant xsfSoundStream_getStatus = define_c_func(aud,"+sfSoundStream_getStatus",{C_POINTER},C_INT)

public function sfSoundStream_getStatus(atom ss)
	return c_func(xsfSoundStream_getStatus,{ss})
end function

public constant xsfSoundStream_getChannelCount = define_c_func(aud,"+sfSoundStream_getChannelCount",{C_POINTER},C_UINT)

public function sfSoundStream_getChannelCount(atom ss)
	return c_func(xsfSoundStream_getChannelCount,{ss})
end function

public constant xsfSoundStream_getSampleRate = define_c_func(aud,"+sfSoundStream_getSampleRate",{C_POINTER},C_UINT)

public function sfSoundStream_getSampleRate(atom ss)
	return c_func(xsfSoundStream_getSampleRate,{ss})
end function

public constant xsfSoundStream_getChannelMap = define_c_func(aud,"+sfSoundStream_getChannelMap",{C_POINTER,C_POINTER},C_POINTER)

public function sfSoundStream_getChannelMap(atom ss,atom count)
	return c_func(xsfSoundStream_getChannelMap,{ss,count})
end function

public constant xsfSoundStream_setPitch = define_c_proc(aud,"+sfSoundStream_setPitch",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setPitch(atom ss,atom pitch)
	c_proc(xsfSoundStream_setPitch,{ss,pitch})
end procedure

public constant xsfSoundStream_setPan = define_c_proc(aud,"+sfSoundStream_setPan",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setPan(atom ss,atom pan)
	c_proc(xsfSoundStream_setPan,{ss,pan})
end procedure

public constant xsfSoundStream_setVolume = define_c_proc(aud,"+sfSoundStream_setVolume",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setVolume(atom ss,atom volume)
	c_proc(xsfSoundStream_setVolume,{ss,volume})
end procedure

public constant xsfSoundStream_setSpatializationEnabled = define_c_proc(aud,"+sfSoundStream_setSpatializationEnabled",{C_POINTER,C_BOOL})

public procedure sfSoundStream_setSpatializationEnabled(atom ss,atom enabled)
	c_proc(xsfSoundStream_setSpatializationEnabled,{ss,enabled})
end procedure

public constant xsfSoundStream_setPosition = define_c_proc(aud,"+sfSoundStream_setPosition",{C_POINTER,sfVector3f})

public procedure sfSoundStream_setPosition(atom ss,sequence pos)
	c_proc(xsfSoundStream_setPosition,{ss,pos})
end procedure

public constant xsfSoundStream_setDirection = define_c_proc(aud,"+sfSoundStream_setDirection",{C_POINTER,sfVector3f})

public procedure sfSoundStream_setDirection(atom ss,sequence direction)
	c_proc(xsfSoundStream_setDirection,{ss,direction})
end procedure

public constant xsfSoundStream_setCone = define_c_proc(aud,"+sfSoundStream_setCone",{C_POINTER,sfSoundSourceCone})

public procedure sfSoundStream_setCone(atom ss,sequence cone)
	c_proc(xsfSoundStream_setCone,{ss,cone})
end procedure

public constant xsfSoundStream_setVelocity = define_c_proc(aud,"+sfSoundStream_setVelocity",{C_POINTER,sfVector3f})

public procedure sfSoundStream_setVelocity(atom ss,sequence velocity)
	c_proc(xsfSoundStream_setVelocity,{ss,velocity})
end procedure

public constant xsfSoundStream_setDopplerFactor = define_c_proc(aud,"+sfSoundStream_setDopplerFactor",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setDopplerFactor(atom ss,atom factor)
	c_proc(xsfSoundStream_setDopplerFactor,{ss,factor})
end procedure

public constant xsfSoundStream_setDirectionalAttenuationFactor = define_c_proc(aud,"+sfSoundStream_setDirectionalAttenuationFactor",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setDirectionalAttenuationFactor(atom ss,atom factor)
	c_proc(xsfSoundStream_setDirectionalAttenuationFactor,{ss,factor})
end procedure

public constant xsfSoundStream_setRelativeToListener = define_c_proc(aud,"+sfSoundStream_setRelativeToListener",{C_POINTER,C_BOOL})

public procedure sfSoundStream_setRelativeToListener(atom ss,atom relative)
	c_proc(xsfSoundStream_setRelativeToListener,{ss,relative})
end procedure

public constant xsfSoundStream_setMinDistance = define_c_proc(aud,"+sfSoundStream_setMinDistance",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setMinDistance(atom ss,atom distance)
	c_proc(xsfSoundStream_setMinDistance,{ss,distance})
end procedure

public constant xsfSoundStream_setMaxDistance = define_c_proc(aud,"+sfSoundStream_setMaxDistance",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setMaxDistance(atom ss,atom distance)
	c_proc(xsfSoundStream_setMaxDistance,{ss,distance})
end procedure

public constant xsfSoundStream_setMinGain = define_c_proc(aud,"+sfSoundStream_setMinGain",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setMinGain(atom ss,atom gain)
	c_proc(xsfSoundStream_setMinGain,{ss,gain})
end procedure

public constant xsfSoundStream_setMaxGain = define_c_proc(aud,"+sfSoundStream_setMaxGain",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setMaxGain(atom ss,atom gain)
	c_proc(xsfSoundStream_setMaxGain,{ss,gain})
end procedure

public constant xsfSoundStream_setAttenuation = define_c_proc(aud,"+sfSoundStream_setAttenuation",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setAttenuation(atom ss,atom attenuation)
	c_proc(xsfSoundStream_setAttenuation,{ss,attenuation})
end procedure

public constant xsfSoundStream_setPlayingOffset = define_c_proc(aud,"+sfSoundStream_setPlayingOffset",{C_POINTER,sfTime})

public procedure sfSoundStream_setPlayingOffset(atom ss,sequence timeOffset)
	c_proc(xsfSoundStream_setPlayingOffset,{ss,timeOffset})
end procedure

public constant xsfSoundStream_setLooping = define_c_proc(aud,"+sfSoundStream_setLooping",{C_POINTER,C_BOOL})

public procedure sfSoundStream_setLooping(atom ss,atom xloop)
	c_proc(xsfSoundStream_setLooping,{ss,xloop})
end procedure

public constant xsfSoundStream_getPitch = define_c_func(aud,"+sfSoundStream_getPitch",{C_POINTER},C_FLOAT)

public function sfSoundStream_getPitch(atom ss)
	return c_func(xsfSoundStream_getPitch,{ss})
end function

public constant xsfSoundStream_getPan = define_c_func(aud,"+sfSoundStream_getPan",{C_POINTER},C_FLOAT)

public function sfSoundStream_getPan(atom ss)
	return c_func(xsfSoundStream_getPan,{ss})
end function

public constant xsfSoundStream_getVolume = define_c_func(aud,"+sfSoundStream_getVolume",{C_POINTER},C_FLOAT)

public function sfSoundStream_getVolume(atom ss)
	return c_func(xsfSoundStream_getVolume,{ss})
end function

public constant xsfSoundStream_isSpatializationEnabled = define_c_func(aud,"+sfSoundStream_isSpatializationEnabled",{C_POINTER},C_BOOL)

public function sfSoundStream_isSpatializationEnabled(atom ss)
	return c_func(xsfSoundStream_isSpatializationEnabled,{ss})
end function

public constant xsfSoundStream_getPosition = define_c_func(aud,"+sfSoundStream_getPosition",{C_POINTER},sfVector3f)

public function sfSoundStream_getPosition(atom ss)
	return c_func(xsfSoundStream_getPosition,{ss})
end function

public constant xsfSoundStream_getDirection = define_c_func(aud,"+sfSoundStream_getDirection",{C_POINTER},sfVector3f)

public function sfSoundStream_getDirection(atom ss)
	return c_func(xsfSoundStream_getDirection,{ss})
end function

public constant xsfSoundStream_getCone = define_c_func(aud,"+sfSoundStream_getCone",{C_POINTER},sfSoundSourceCone)

public function sfSoundStream_getCone(atom ss)
	return c_func(xsfSoundStream_getCone,{ss})
end function

public constant xsfSoundStream_getVelocity = define_c_func(aud,"+sfSoundStream_getVelocity",{C_POINTER},sfVector3f)

public function sfSoundStream_getVelocity(atom ss)
	return c_func(xsfSoundStream_getVelocity,{ss})
end function

public constant xsfSoundStream_getDopplerFactor = define_c_func(aud,"+sfSoundStream_getDopplerFactor",{C_POINTER},C_FLOAT)

public function sfSoundStream_getDopplerFactor(atom ss)
	return c_func(xsfSoundStream_getDopplerFactor,{ss})
end function

public constant xsfSoundStream_getDirectionalAttenuationFactor = define_c_func(aud,"+sfSoundStream_getDirectionalAttenuationFactor",{C_POINTER},C_FLOAT)

public function sfSoundStream_getDirectionalAttenuationFactor(atom ss)
	return c_func(xsfSoundStream_getDirectionalAttenuationFactor,{ss})
end function

public constant xsfSoundStream_isRelativeToListener = define_c_func(aud,"+sfSoundStream_isRelativeToListener",{C_POINTER},C_BOOL)

public function sfSoundStream_isRelativeToListener(atom ss)
	return c_func(xsfSoundStream_isRelativeToListener,{ss})
end function

public constant xsfSoundStream_getMinDistance = define_c_func(aud,"+sfSoundStream_getMinDistance",{C_POINTER},C_FLOAT)

public function sfSoundStream_getMinDistance(atom ss)
	return c_func(xsfSoundStream_getMinDistance,{ss})
end function

public constant xsfSoundStream_getMaxDistance = define_c_func(aud,"+sfSoundStream_getMaxDistance",{C_POINTER},C_FLOAT)

public function sfSoundStream_getMaxDistance(atom ss)
	return c_func(xsfSoundStream_getMaxDistance,{ss})
end function

public constant xsfSoundStream_getMinGain = define_c_func(aud,"+sfSoundStream_getMinGain",{C_POINTER},C_FLOAT)

public function sfSoundStream_getMinGain(atom ss)
	return c_func(xsfSoundStream_getMinGain,{ss})
end function

public constant xsfSoundStream_getMaxGain = define_c_func(aud,"+sfSoundStream_getMaxGain",{C_POINTER},C_FLOAT)

public function sfSoundStream_getMaxGain(atom ss)
	return c_func(xsfSoundStream_getMaxGain,{ss})
end function

public constant xsfSoundStream_getAttenuation = define_c_func(aud,"+sfSoundStream_getAttenuation",{C_POINTER},C_FLOAT)

public function sfSoundStream_getAttenuation(atom ss)
	return c_func(xsfSoundStream_getAttenuation,{ss})
end function

public constant xsfSoundStream_isLooping = define_c_func(aud,"+sfSoundStream_isLooping",{C_POINTER},C_BOOL)

public function sfSoundStream_isLooping(atom ss)
	return c_func(xsfSoundStream_isLooping,{ss})
end function

public constant xsfSoundStream_setEffectProcessor = define_c_proc(aud,"+sfSoundStream_setEffectProcessor",{C_POINTER,C_POINTER})

public procedure sfSoundStream_setEffectProcessor(atom ss,object ep)
	c_proc(xsfSoundStream_setEffectProcessor,{ss,ep})
end procedure

public constant xsfSoundStream_getPlayingOffset = define_c_func(aud,"+sfSoundStream_getPlayingOffset",{C_POINTER},sfTime)

public function sfSoundStream_getPlayingOffset(atom ss)
	return c_func(xsfSoundStream_getPlayingOffset,{ss})
end function

--Sound

public constant xsfSound_create = define_c_func(aud,"+sfSound_create",{C_POINTER},C_POINTER)

public function sfSound_create(atom buffer)
	return c_func(xsfSound_create,{buffer})
end function

public constant xsfSound_copy = define_c_func(aud,"+sfSound_copy",{C_POINTER},C_POINTER)

public function sfSound_copy(atom sound)
	return c_func(xsfSound_copy,{sound})
end function

public constant xsfSound_destroy = define_c_proc(aud,"+sfSound_destroy",{C_POINTER})

public procedure sfSound_destroy(atom sound)
	c_proc(xsfSound_destroy,{sound})
end procedure

public constant xsfSound_play = define_c_proc(aud,"+sfSound_play",{C_POINTER})

public procedure sfSound_play(atom sound)
	c_proc(xsfSound_play,{sound})
end procedure

public constant xsfSound_pause = define_c_proc(aud,"+sfSound_pause",{C_POINTER})

public procedure sfSound_pause(atom sound)
	c_proc(xsfSound_pause,{sound})
end procedure

public constant xsfSound_stop = define_c_proc(aud,"+sfSound_stop",{C_POINTER})

public procedure sfSound_stop(atom sound)
	c_proc(xsfSound_stop,{sound})
end procedure

public constant xsfSound_setBuffer = define_c_proc(aud,"+sfSound_setBuffer",{C_POINTER,C_POINTER})

public procedure sfSound_setBuffer(atom sound,atom buffer)
	c_proc(xsfSound_setBuffer,{sound,buffer})
end procedure

public constant xsfSound_getBuffer = define_c_func(aud,"+sfSound_getBuffer",{C_POINTER},C_POINTER)

public function sfSound_getBuffer(atom sound)
	return c_func(xsfSound_getBuffer,{sound})
end function

public constant xsfSound_setLooping = define_c_proc(aud,"+sfSound_setLooping",{C_POINTER,C_BOOL})

public procedure sfSound_setLooping(atom sound,atom xloop)
	c_proc(xsfSound_setLooping,{sound,xloop})
end procedure

public constant xsfSound_isLooping = define_c_func(aud,"+sfSound_isLooping",{C_POINTER},C_BOOL)

public function sfSound_isLooping(atom sound)
	return c_func(xsfSound_isLooping,{sound})
end function

public constant xsfSound_getStatus = define_c_func(aud,"+sfSound_getStatus",{C_POINTER},C_INT)

public function sfSound_getStatus(atom sound)
	return c_func(xsfSound_getStatus,{sound})
end function

public constant xsfSound_setPitch = define_c_proc(aud,"+sfSound_setPitch",{C_POINTER,C_FLOAT})

public procedure sfSound_setPitch(atom sound,atom pitch)
	c_proc(xsfSound_setPitch,{sound,pitch})
end procedure

public constant xsfSound_setPan = define_c_proc(aud,"+sfSound_setPan",{C_POINTER,C_FLOAT})

public procedure sfSound_setPan(atom sound,atom pan)
	c_proc(xsfSound_setPan,{sound,pan})
end procedure

public constant xsfSound_setVolume = define_c_proc(aud,"+sfSound_setVolume",{C_POINTER,C_FLOAT})

public procedure sfSound_setVolume(atom sound,atom volume)
	c_proc(xsfSound_setVolume,{sound,volume})
end procedure

public constant xsfSound_setSpatializationEnabled = define_c_proc(aud,"+sfSound_setSpatializationEnabled",{C_POINTER,C_BOOL})

public procedure sfSound_setSpatializationEnabled(atom sound,atom enabled)
	c_proc(xsfSound_setSpatializationEnabled,{sound,enabled})
end procedure

public constant xsfSound_setPosition = define_c_proc(aud,"+sfSound_setPosition",{C_POINTER,sfVector3f})

public procedure sfSound_setPosition(atom sound,sequence pos)
	c_proc(xsfSound_setPosition,{sound,pos})
end procedure

public constant xsfSound_setDirection = define_c_proc(aud,"+sfSound_setDirection",{C_POINTER,sfVector3f})

public procedure sfSound_setDirection(atom sound,sequence direction)
	c_proc(xsfSound_setDirection,{sound,direction})
end procedure

public constant xsfSound_setCone = define_c_proc(aud,"+sfSound_setCone",{C_POINTER,sfSoundSourceCone})

public procedure sfSound_setCone(atom sound,sequence cone)
	c_proc(xsfSound_setCone,{sound,cone})
end procedure

public constant xsfSound_setVelocity = define_c_proc(aud,"+sfSound_setVelocity",{C_POINTER,sfVector3f})

public procedure sfSound_setVelocity(atom sound,sequence velocity)
	c_proc(xsfSound_setVelocity,{sound,velocity})
end procedure

public constant xsfSound_setDopplerFactor = define_c_proc(aud,"+sfSound_setDopplerFactor",{C_POINTER,C_FLOAT})

public procedure sfSound_setDopplerFactor(atom sound,atom factor)
	c_proc(xsfSound_setDopplerFactor,{sound,factor})
end procedure

public constant xsfSound_setDirectionalAttenuationFactor = define_c_proc(aud,"+sfSound_setDirectionalAttenuationFactor",{C_POINTER,C_FLOAT})

public procedure sfSound_setDirectionalAttenuationFactor(atom sound,atom factor)
	c_proc(xsfSound_setDirectionalAttenuationFactor,{sound,factor})
end procedure

public constant xsfSound_setRelativeToListener = define_c_proc(aud,"+sfSound_setRelativeToListener",{C_POINTER,C_BOOL})

public procedure sfSound_setRelativeToListener(atom sound,atom relative)
	c_proc(xsfSound_setRelativeToListener,{sound,relative})
end procedure

public constant xsfSound_setMinDistance = define_c_proc(aud,"+sfSound_setMinDistance",{C_POINTER,C_FLOAT})

public procedure sfSound_setMinDistance(atom sound,atom distance)
	c_proc(xsfSound_setMinDistance,{sound,distance})
end procedure

public constant xsfSound_setMaxDistance = define_c_proc(aud,"+sfSound_setMaxDistance",{C_POINTER,C_FLOAT})

public procedure sfSound_setMaxDistance(atom sound,atom distance)
	c_proc(xsfSound_setMaxDistance,{sound,distance})
end procedure

public constant xsfSound_setMinGain = define_c_proc(aud,"+sfSound_setMinGain",{C_POINTER,C_FLOAT})

public procedure sfSound_setMinGain(atom sound,atom gain)
	c_proc(xsfSound_setMinGain,{sound,gain})
end procedure

public constant xsfSound_setMaxGain = define_c_proc(aud,"+sfSound_setMaxGain",{C_POINTER,C_FLOAT})

public procedure sfSound_setMaxGain(atom sound,atom gain)
	c_proc(xsfSound_setMaxGain,{sound,gain})
end procedure

public constant xsfSound_setAttenuation = define_c_proc(aud,"+sfSound_setAttenuation",{C_POINTER,C_FLOAT})

public procedure sfSound_setAttenuation(atom sound,atom attenuation)
	c_proc(xsfSound_setAttenuation,{sound,attenuation})
end procedure

public constant xsfSound_setPlayingOffset = define_c_proc(aud,"+sfSound_setPlayingOffset",{C_POINTER,sfTime})

public procedure sfSound_setPlayingOffset(atom sound,sequence timeOffset)
	c_proc(xsfSound_setPlayingOffset,{sound,timeOffset})
end procedure

public constant xsfSound_setEffectProcessor = define_c_proc(aud,"+sfSound_setEffectProcessor",{C_POINTER,C_POINTER})

public procedure sfSound_setEffectProcessor(atom sound,object effectProcessor)
	c_proc(xsfSound_setEffectProcessor,{sound,effectProcessor})
end procedure

public constant xsfSound_getPitch = define_c_func(aud,"+sfSound_getPitch",{C_POINTER},C_FLOAT)

public function sfSound_getPitch(atom sound)
	return c_func(xsfSound_getPitch,{sound})
end function

public constant xsfSound_getPan = define_c_func(aud,"+sfSound_getPan",{C_POINTER},C_FLOAT)

public function sfSound_getPan(atom sound)
	return c_func(xsfSound_getPan,{sound})
end function

public constant xsfSound_getVolume = define_c_func(aud,"+sfSound_getVolume",{C_POINTER},C_FLOAT)

public function sfSound_getVolume(atom sound)
	return c_func(xsfSound_getVolume,{sound})
end function

public constant xsfSound_isSpatializationEnabled = define_c_func(aud,"+sfSound_isSpatializationEnabled",{C_POINTER},C_BOOL)

public function sfSound_isSpatializationEnabled(atom sound)
	return c_func(xsfSound_isSpatializationEnabled,{sound})
end function

public constant xsfSound_getPosition = define_c_func(aud,"+sfSound_getPosition",{C_POINTER},sfVector3f)

public function sfSound_getPosition(atom sound)
	return c_func(xsfSound_getPosition,{sound})
end function

public constant xsfSound_getDirection = define_c_func(aud,"+sfSound_getDirection",{C_POINTER},sfVector3f)

public function sfSound_getDirection(atom sound)
	return c_func(xsfSound_getDirection,{sound})
end function

public constant xsfSound_getCone = define_c_func(aud,"+sfSound_getCone",{C_POINTER},sfSoundSourceCone)

public function sfSound_getCone(atom sound)
	return c_func(xsfSound_getCone,{sound})
end function

public constant xsfSound_getVelocity = define_c_func(aud,"+sfSound_getVelocity",{C_POINTER},sfVector3f)

public function sfSound_getVelocity(atom sound)
	return c_func(xsfSound_getVelocity,{sound})
end function

public constant xsfSound_getDopplerFactor = define_c_func(aud,"+sfSound_getDopplerFactor",{C_POINTER},C_FLOAT)

public function sfSound_getDopplerFactor(atom sound)
	return c_func(xsfSound_getDopplerFactor,{sound})
end function

public constant xsfSound_getDirectionalAttenuationFactor = define_c_func(aud,"+sfSound_getDirectionalAttenuationFactor",{C_POINTER},C_FLOAT)

public function sfSound_getDirectionalAttenuationFactor(atom sound)
	return c_func(xsfSound_getDirectionalAttenuationFactor,{sound})
end function

public constant xsfSound_isRelativeToListener = define_c_func(aud,"+sfSound_isRelativeToListener",{C_POINTER},C_BOOL)

public function sfSound_isRelativeToListener(atom sound)
	return c_func(xsfSound_isRelativeToListener,{sound})
end function

public constant xsfSound_getMinDistance = define_c_func(aud,"+sfSound_getMinDistance",{C_POINTER},C_FLOAT)

public function sfSound_getMinDistance(atom sound)
	return c_func(xsfSound_getMinDistance,{sound})
end function

public constant xsfSound_getMaxDistance = define_c_func(aud,"+sfSound_getMaxDistance",{C_POINTER},C_FLOAT)

public function sfSound_getMaxDistance(atom sound)
	return c_func(xsfSound_getMaxDistance,{sound})
end function

public constant xsfSound_getMinGain = define_c_func(aud,"+sfSound_getMinGain",{C_POINTER},C_FLOAT)

public function sfSound_getMinGain(atom sound)
	return c_func(xsfSound_getMinGain,{sound})
end function

public constant xsfSound_getMaxGain = define_c_func(aud,"+sfSound_getMaxGain",{C_POINTER},C_FLOAT)

public function sfSound_getMaxGain(atom sound)
	return c_func(xsfSound_getMaxGain,{sound})
end function

public constant xsfSound_getAttenuation = define_c_func(aud,"+sfSound_getAttenuation",{C_POINTER},C_FLOAT)

public function sfSound_getAttenuation(atom sound)
	return c_func(xsfSound_getAttenuation,{sound})
end function

public constant xsfSound_getPlayingOffset = define_c_func(aud,"+sfSound_getPlayingOffset",{C_POINTER},sfTime)

public function sfSound_getPlayingOffset(atom sound)
	return c_func(xsfSound_getPlayingOffset,{sound})
end function

--SoundRecorder

public constant xsfSoundRecorder_create = define_c_func(aud,"+sfSoundRecorder_create",{C_POINTER,C_POINTER,C_POINTER,C_POINTER},C_POINTER)

public function sfSoundRecorder_create(object onStart,object onProcess,object onStop,atom userData)
	return c_func(xsfSoundRecorder_create,{onStart,onProcess,onStop,userData})
end function

public constant xsfSoundRecorder_destroy = define_c_proc(aud,"+sfSoundRecorder_destroy",{C_POINTER})

public procedure sfSoundRecorder_destroy(atom sr)
	c_proc(xsfSoundRecorder_destroy,{sr})
end procedure

public constant xsfSoundRecorder_start = define_c_func(aud,"+sfSoundRecorder_start",{C_POINTER,C_UINT},C_BOOL)

public function sfSoundRecorder_start(atom sr,atom sampleRate)
	return c_func(xsfSoundRecorder_start,{sr,sampleRate})
end function

public constant xsfSoundRecorder_stop = define_c_proc(aud,"+sfSoundRecorder_stop",{C_POINTER})

public procedure sfSoundRecorder_stop(atom sr)
	c_proc(xsfSoundRecorder_stop,{sr})
end procedure

public constant xsfSoundRecorder_getSampleRate = define_c_func(aud,"+sfSoundRecorder_getSampleRate",{C_POINTER},C_UINT)

public function sfSoundRecorder_getSampleRate(atom sr)
	return c_func(xsfSoundRecorder_getSampleRate,{sr})
end function

public constant xsfSoundRecorder_isAvailable = define_c_func(aud,"+sfSoundRecorder_isAvailable",{},C_BOOL)

public function sfSoundRecorder_isAvailable()
	return c_func(xsfSoundRecorder_isAvailable,{})
end function

public constant xsfSoundRecorder_getAvailableDevices = define_c_func(aud,"+sfSoundRecorder_getAvailableDevices",{C_POINTER},C_POINTER)

public function sfSoundRecorder_getAvailableDevices(atom count)
	return c_func(xsfSoundRecorder_getAvailableDevices,{count})
end function

public constant xsfSoundRecorder_getDefaultDevice = define_c_func(aud,"+sfSoundRecorder_getDefaultDevice",{},C_STRING)

public function sfSoundRecorder_getDefaultDevice()
	return c_func(xsfSoundRecorder_getDefaultDevice,{})
end function

public constant xsfSoundRecorder_setDevice = define_c_func(aud,"+sfSoundRecorder_setDevice",{C_POINTER,C_STRING},C_BOOL)

public function sfSoundRecorder_setDevice(atom sr,sequence name)
	return c_func(xsfSoundRecorder_setDevice,{sr,name})
end function

public constant xsfSoundRecorder_getDevice = define_c_func(aud,"+sfSoundRecorder_getDevice",{C_POINTER},C_STRING)

public function sfSoundRecorder_getDevice(atom sr)
	return c_func(xsfSoundRecorder_getDevice,{sr})
end function

public constant xsfSoundRecorder_setChannelCount = define_c_proc(aud,"+sfSoundRecorder_setChannelCount",{C_POINTER,C_UINT})

public procedure sfSoundRecorder_setChannelCount(atom sr,atom channelCount)
	c_proc(xsfSoundRecorder_setChannelCount,{sr,channelCount})
end procedure

public constant xsfSoundRecorder_getChannelCount = define_c_func(aud,"+sfSoundRecorder_getChannelCount",{C_POINTER},C_UINT)

public function sfSoundRecorder_getChannelCount(atom sr)
	return c_func(xsfSoundRecorder_getChannelCount,{sr})
end function

public constant xsfSoundRecorder_getChannelMap = define_c_func(aud,"+sfSoundRecorder_getChannelMap",{C_POINTER,C_POINTER},C_POINTER)

public function sfSoundRecorder_getChannelMap(atom sr,atom count)
	return c_func(xsfSoundRecorder_getChannelMap,{sr,count})
end function

--SoundBufferRecorder

public constant xsfSoundBufferRecorder_create = define_c_func(aud,"+sfSoundBufferRecorder_create",{},C_POINTER)

public function sfSoundBufferRecorder_create()
	return c_func(xsfSoundBufferRecorder_create,{})
end function

public constant xsfSoundBufferRecorder_destroy = define_c_proc(aud,"+sfSoundBufferRecorder_destroy",{C_POINTER})

public procedure sfSoundBufferRecorder_destroy(atom sbr)
	c_proc(xsfSoundBufferRecorder_destroy,{sbr})
end procedure

public constant xsfSoundBufferRecorder_start = define_c_func(aud,"+sfSoundBufferRecorder_start",{C_POINTER,C_UINT},C_BOOL)

public function sfSoundBufferRecorder_start(atom sbr,atom sampleRate)
	return c_func(xsfSoundBufferRecorder_start,{sbr,sampleRate})
end function

public constant xsfSoundBufferRecorder_stop = define_c_proc(aud,"+sfSoundBufferRecorder_stop",{C_POINTER})

public procedure sfSoundBufferRecorder_stop(atom sbr)
	c_proc(xsfSoundBufferRecorder_stop,{sbr})
end procedure

public constant xsfSoundBufferRecorder_getSampleRate = define_c_func(aud,"+sfSoundBufferRecorder_getSampleRate",{C_POINTER},C_UINT)

public function sfSoundBufferRecorder_getSampleRate(atom sbr)
	return c_func(xsfSoundBufferRecorder_getSampleRate,{sbr})
end function

public constant xsfSoundBufferRecorder_getBuffer = define_c_func(aud,"+sfSoundBufferRecorder_getBuffer",{C_POINTER},C_POINTER)

public function sfSoundBufferRecorder_getBuffer(atom sbr)
	return c_func(xsfSoundBufferRecorder_getBuffer,{sbr})
end function

public constant xsfSoundBufferRecorder_setDevice = define_c_func(aud,"+sfSoundBufferRecorder_setDevice",{C_POINTER,C_STRING},C_BOOL)

public function sfSoundBufferRecorder_setDevice(atom sbr,sequence name)
	return c_func(xsfSoundBufferRecorder_setDevice,{sbr,name})
end function

public constant xfSoundBufferRecorder_getDevice = define_c_func(aud,"+fSoundBufferRecorder_getDevice",{C_POINTER},C_STRING)

public function fSoundBufferRecorder_getDevice(atom sbr)
	return c_func(xfSoundBufferRecorder_getDevice,{sbr})
end function

public constant xsfSoundBufferRecorder_setChannelCount = define_c_proc(aud,"+sfSoundBufferRecorder_setChannelCount",{C_POINTER,C_UINT})

public procedure sfSoundBufferRecorder_setChannelCount(atom sbr,atom channelCount)
	c_proc(xsfSoundBufferRecorder_setChannelCount,{sbr,channelCount})
end procedure

public constant xsfSoundBufferRecorder_getChannelCount = define_c_func(aud,"+sfSoundBufferRecorder_getChannelCount",{C_POINTER},C_UINT)

public function sfSoundBufferRecorder_getChannelCount(atom sbr)
	return c_func(xsfSoundBufferRecorder_getChannelCount,{sbr})
end function

--SoundBuffer

public constant xsfSoundBuffer_createFromFile = define_c_func(aud,"+sfSoundBuffer_createFromFile",{C_STRING},C_POINTER)

public function sfSoundBuffer_createFromFile(sequence fname)
	return c_func(xsfSoundBuffer_createFromFile,{fname})
end function

public constant xsfSoundBuffer_createFromMemory = define_c_func(aud,"+sfSoundBuffer_createFromMemory",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfSoundBuffer_createFromMemory(atom data,atom size)
	return c_func(xsfSoundBuffer_createFromMemory,{data,size})
end function

public constant xsfSoundBuffer_createFromStream = define_c_func(aud,"+sfSoundBuffer_createFromStream",{C_POINTER},C_POINTER)

public function sfSoundBuffer_createFromStream(atom stream)
	return c_func(xsfSoundBuffer_createFromStream,{stream})
end function

public constant xsfSoundBuffer_createFromSamples = define_c_func(aud,"+sfSoundBuffer_createFromSamples",{C_POINTER,C_UINT64,C_UINT,C_UINT,C_POINTER,C_SIZE_T},C_POINTER)

public function sfSoundBuffer_createFromSamples(atom samples,atom sampleCount,atom channelCount,atom sampleRate,atom channelMapData,atom channelMapSize)
	return c_func(xsfSoundBuffer_createFromSamples,{samples,sampleCount,channelCount,sampleRate,channelMapData,channelMapSize})
end function

public constant xsfSoundBuffer_copy = define_c_func(aud,"+sfSoundBuffer_copy",{C_POINTER},C_POINTER)

public function sfSoundBuffer_copy(atom sb)
	return c_func(xsfSoundBuffer_copy,{sb})
end function

public constant xsfSoundBuffer_destroy = define_c_proc(aud,"+sfSoundBuffer_destroy",{C_POINTER})

public procedure sfSoundBuffer_destroy(atom sb)
	c_proc(xsfSoundBuffer_destroy,{sb})
end procedure

public constant xsfSoundBuffer_saveToFile = define_c_func(aud,"+sfSoundBuffer_saveToFile",{C_POINTER,C_STRING},C_BOOL)

public function sfSoundBuffer_saveToFile(atom sb,sequence fname)
	return c_func(xsfSoundBuffer_saveToFile,{sb,fname})
end function

public constant xsfSoundBuffer_getSamples = define_c_func(aud,"+sfSoundBuffer_getSamples",{C_POINTER},C_POINTER)

public function sfSoundBuffer_getSamples(atom sb)
	return c_func(xsfSoundBuffer_getSamples,{sb})
end function

public constant xsfSoundBuffer_getSampleCount = define_c_func(aud,"+sfSoundBuffer_getSampleCount",{C_POINTER},C_UINT64)

public function sfSoundBuffer_getSampleCount(atom sb)
	return c_func(xsfSoundBuffer_getSampleCount,{sb})
end function

public constant xsfSoundBuffer_getSampleRate = define_c_func(aud,"+sfSoundBuffer_getSampleRate",{C_POINTER},C_UINT)

public function sfSoundBuffer_getSampleRate(atom sb)
	return c_func(xsfSoundBuffer_getSampleRate,{sb})
end function

public constant xsfSoundBuffer_getChannelCount = define_c_func(aud,"+sfSoundBuffer_getChannelCount",{C_POINTER},C_UINT)

public function sfSoundBuffer_getChannelCount(atom sb)
	return c_func(xsfSoundBuffer_getChannelCount,{sb})
end function

public constant xsfSoundBuffer_getChannelMap = define_c_func(aud,"+sfSoundBuffer_getChannelMap",{C_POINTER,C_POINTER},C_POINTER)

public function sfSoundBuffer_getChannelMap(atom sb,atom count)
	return c_func(xsfSoundBuffer_getChannelMap,{sb,count})
end function

public constant xsfSoundBuffer_getDuration = define_c_func(aud,"+sfSoundBuffer_getDuration",{C_POINTER},sfTime)

public function sfSoundBuffer_getDuration(atom sb)
	return c_func(xsfSoundBuffer_getDuration,{sb})
end function

--TODO: EffectProcessor Callback
­1240.47