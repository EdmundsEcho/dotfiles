-- ctrlp setting
local M = {}

function M.setup()
    vim.g.ctrlp_working_path_mode = 'ra'
    vim.g.ctrlp_custom_ignore = {
        dir = '\\v[\\/]\\.(git|hg|svn)|node_modules|build|dist$',
        file = '\\v\\.(exe|so|dll)$',
        link = 'some_bad_symbolic_links',
    }
    vim.g.ctrlp_user_command = [[find %s -type d \( \
        -name target \
        -o -name node_modules \
        -o -name .git \
        -o -name build \
        -o -name include \
        -o -name .venv \
        -o -name .pytest_cache \
        -o -name .mypy_cache \
        -o -name .ruff_cache \
        \) -prune -o -type f]]

    -- Netrw settings to disable it
    vim.g.netrw_list_hide = {}
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
end

return M
