__precompile__(false)
module ClevErr
using WAV
using Preferences
import Base: error

export celebrate, done, set_volume, toggle_sound

const DEFAULT_PREFS = Dict(
    :volume => 0.75,
    :asset_dir => joinpath(@__DIR__, "..", "assets"),
    :enable_sound => true,
)

"""
    get_default(name::Symbol) -> Any

Returns the current default value for the given preference key.
If the key is not set, it falls back to the value in DEFAULT_PREFS.
"""
function get_default(name::Symbol)
    return @load_preference(String(name), DEFAULT_PREFS[name])
end
"""
    set_default(name::Symbol, value)

Sets a new default value for the given preference key and saves it persistently.
"""
function set_default(name::Symbol, value)
    @set_preferences!(String(name) => value)
end

function set_volume(vol)
    set_default(:volume, vol)
end
# -----------------------------------------------------------------------------
# Asset directories (using self-made sound samples)

function toggle_sound(state::Union{Bool,Nothing}=nothing)
    if isa(state, Bool)
        set_default(:enable_sound, state)
    else
        enable_sound = get_default(:enable_sound)
        set_default(:enable_sound, !enable_sound)
    end
end

function play_asset(filename::String)
    if get_default(:enable_sound)
        # connect the filenames: starting from the directory of this function going ../assets/$filename
        full_name = joinpath(get_default(:asset_dir), filename)
        # read the WAV file

        audio, rate = wavread(full_name)
        # Scale the samples by the volume factor.
        vol = get_default(:volume)
        audio = vol .* audio
        Threads.@spawn wavplay(audio, rate)
    end
end
# Play a random sound from a directory (asynchronously).
function play_error()
    play_asset("descending_error.wav")
end
function play_success()
    play_asset("happy_processed.wav")
end
function play_success2()
    play_asset("quick_rise.wav")
end

# celebrate() behaves like println() but also plays a random "Yoohoo!" sound.
function celebrate(args...)
    if length(args) > 0
        println(args...)
    end
    play_success()
    return nothing
end
function done(args...)
    if length(args) > 0
        println(args...)
    end
    play_success2()
    return nothing
end


# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Overwrite Base.error to play the error sound before throwing

@eval begin
    @eval begin
        # For a single string argument.
        function error(s::AbstractString)
            ClevErr.play_error()
            throw(ErrorException(s))
        end

        # For varargs (like error(msg...))
        function error(s::Vararg{Any,N}) where {N}
            ClevErr.play_error()
            throw(ErrorException(Main.Base.string(s...)))
        end
    end
end


#### Future Plans  ############################################################
# -----------------------------------------------------------------------------
# analyze_error: Uses Ollama (assumed installed and in PATH) to analyze an error.
# It converts the error message to a string, passes it to Ollama, and returns its output.
#function analyze_error(e::Exception)



end # module
