# OpenCode Profile Switcher

This repo contains a small set of OpenCode profile files and two launch scripts.

## Files

- `.opencode/oh-my-openagent-nvoa.json` — NVOA profile for a mixed NVIDIA / OpenAI / OpenCode setup.
- `.opencode/oh-my-opencode-gpt.json` — GPT-focused profile.
- `.opencode/oh-my-opencode-nogpt.json` — non-GPT profile using NVIDIA and OpenCode models.
- `.opencode/oh-my-opencode-lowcost.json` — low-cost profile.
- `oc.sh` — activates one profile, copies it into the active OpenCode config paths, then runs `opencode`.
- `oc_termly.sh` — same profile switcher, but starts OpenCode through `termly`.

## How it works

Both scripts accept an optional mode:

- `nogpt` (default)
- `gpt`
- `nv`
- `lw`

The chosen JSON profile is copied to the active config locations:

- `.opencode/oh-my-openagent.json`
- `.opencode/oh-my-opencode.json`
- `./oh-my-opencode.json`

On exit, the scripts restore the default `nogpt` profile.

## Usage

```bash
./oc.sh gpt
./oc.sh nv
./oc_termly.sh lw
```

## Notes

- `oc.sh` expects `opencode` to be installed.
- `oc_termly.sh` expects `termly` to be installed.
