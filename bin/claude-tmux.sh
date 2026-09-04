# Shared launcher sourced by the claude.* profile wrappers.
#
# Runs "${CMD[@]}" inside a per-directory tmux session so terminal-started
# Claude sessions behave like the ones the contexts app launches. Session names
# match the app's scheme (ctx-<dir>-<hash>), so these sessions show up and are
# controllable from the contexts UI. Skips the wrap when already inside tmux
# (no nesting) or when tmux is unavailable (plain fallback).
#
# Also tints the urxvt background per profile ($CLAUDE_TINT, set by the wrapper)
# so work and personal sessions are told apart at a glance -- imperial red vs
# federation blue. Note this costs us the exec: the tint has to be restored when
# Claude exits, so we stay alive as a parent to run the EXIT trap.

# Repaint urxvt's pseudo-transparency tint (OSC 705). Needs URxvt.transparent,
# which .Xresources sets globally; a no-op in terminals that don't know 705.
# The tint multiplies the root pixmap, so it is invisible on a black wallpaper.
# Inside tmux the sequence only reaches urxvt via DCS pass-through, which tmux
# 3.3+ gates behind allow-passthrough.
_claude_tint() {
    [ -n "$CLAUDE_TINT" ] || return 0
    if [ -n "$TMUX" ]; then
        tmux set -p allow-passthrough on 2>/dev/null
        printf '\033Ptmux;\033\033]705;%s\007\033\\' "$1"
    else
        printf '\033]705;%s\007' "$1"
    fi
}

if [ -n "$TMUX" ] || ! command -v tmux >/dev/null 2>&1; then
    _claude_tint "$CLAUDE_TINT"
    trap '_claude_tint white' EXIT
    "${CMD[@]}"
    exit $?
fi

_cwd="$PWD"
_base="$(basename "${_cwd%/}")"
_base="$(printf '%s' "$_base" | tr -cs 'a-zA-Z0-9' '-' | sed 's/^-*//; s/-*$//' | tr 'A-Z' 'a-z')"
[ -n "$_base" ] || _base=ctx
_short="$(printf '%s' "$_cwd" | sha1sum | cut -c1-4)"
_name="ctx-${_base}-${_short}"

# One session per invocation: append the lowest free numeric suffix if taken.
if tmux has-session -t "$_name" 2>/dev/null; then
    _n=2
    while tmux has-session -t "${_name}-${_n}" 2>/dev/null; do _n=$((_n + 1)); done
    _name="${_name}-${_n}"
fi

# Tint before tmux starts, while stdout is still the bare urxvt pty -- no
# pass-through needed, and the restore below runs after tmux has gone away.
_claude_tint "$CLAUDE_TINT"
trap '_claude_tint white' EXIT

tmux new-session -s "$_name" -c "$_cwd" -- "${CMD[@]}"
