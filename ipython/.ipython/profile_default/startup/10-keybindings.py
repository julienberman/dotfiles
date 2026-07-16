from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name


shell = get_ipython()

if getattr(shell, "pt_app", None) is not None:
    shell.pt_app.key_bindings.add(
        "escape",
        "up",
        filter=HasFocus(DEFAULT_BUFFER),
    )(get_by_name("previous-history"))
    shell.pt_app.key_bindings.add(
        "escape",
        "down",
        filter=HasFocus(DEFAULT_BUFFER),
    )(get_by_name("next-history"))
