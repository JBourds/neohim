return {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            rust = { "clippy" },
            python = { "ruff" },
            sh = { "shellcheck" },
            bash = { "shellcheck" },
            zsh = { "shellcheck" },
            c = { "cpplint" },
            cpp = { "cpplint" },
            go = { "golangci_lint" },
            typescript = { "eslint_d" },
            javascript = { "eslint_d" },
            sql = { "sqlfluff" },
            markdown = { "markdownlint" },
        }

        -- Only run eslint_d when the project actually has an eslint config and
        -- the binary is installed. Avoids ENOENT in projects with neither.
        local eslint_d = require("lint.linters.eslint_d")
        eslint_d.condition = function(ctx)
            local cfg = vim.fs.find({
                ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
                ".eslintrc.yml", ".eslintrc.yaml", "eslint.config.js",
                "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts",
            }, { path = ctx.dirname, upward = true })[1]
            return cfg ~= nil and vim.fn.executable("eslint_d") == 1
        end

        -- Avoid running the linter too frequently
        local function debounce(ms, fn)
            local timer = vim.uv.new_timer()
            return function(...)
                local argv = { ... }
                timer:start(ms, 0, function()
                    timer:stop()
                    vim.schedule_wrap(fn)(unpack(argv))
                end)
            end
        end

        local function run_lint()
            local names = lint._resolve_linter_by_ft(vim.bo.filetype)
            names = vim.list_extend({}, names)
            vim.list_extend(names, lint.linters_by_ft["_"] or {})
            vim.list_extend(names, lint.linters_by_ft["*"] or {})

            local ctx = { filename = vim.api.nvim_buf_get_name(0) }
            ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

            names = vim.tbl_filter(function(name)
                local linter = lint.linters[name]
                return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
            end, names)

            if #names > 0 then
                lint.try_lint(names)
            end
        end

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = debounce(100, run_lint),
        })
    end,
}
